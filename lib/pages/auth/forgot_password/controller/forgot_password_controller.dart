import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/constants/config_constant.dart';
import 'package:oke_car_flutter/databases/config_db.dart';
import 'package:oke_car_flutter/databases/user_db.dart';
import 'package:oke_car_flutter/helpers/extension/email_validator.dart';
import 'package:oke_car_flutter/helpers/extension/validator.dart';
import 'package:oke_car_flutter/models/config_model.dart';
import 'package:oke_car_flutter/models/user_model.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_capture_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'dart:core';

class ForgotPasswordController extends GetxController {
  final AuthenticateClient client;

  ForgotPasswordController({
    required this.client,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();

  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode rePasswordFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();

  var loading = false.obs;
  bool hasError = false;
  var isShowPassword = false.obs;
  var isShowRePassword = false.obs;
  var emailValid = true.obs;
  var passwordValid = true.obs;
  var rePasswordValid = true.obs;
  var otpValid = true.obs;

  var emailErrorMsg = 'invalid_email'.tr.obs;
  var passErrorMsg = 'invalid_password'.tr.obs;
  var otpErrorMsg = 'invalid_otp'.tr.obs;
  var rePassError = 'invalid_otp'.tr.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    emailFocus.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    rePasswordController.dispose();
    rePasswordFocus.dispose();
    super.onClose();
  }

  onChangeText(text) {
    if (emailController.text.isEmpty) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
  }

  onChangeOTP(text) {
    if (otpController.text.isEmpty) {
      otpErrorMsg.value = 'invalid_otp'.tr;
    }
    otpValid.value = otpController.text.isNotEmpty;
  }

  onChangeEmail(String email) {
    if (!emailController.text.isValidEmail()) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
    ConfigDB().save(ConfigModel(CONFIG_REGISTER_USERNAME, email));
  }

  onChangePass(String text) {
    passwordValid.value = passwordController.text.isNotEmpty;
  }

  onChangeRePass(String text) {
    rePasswordValid.value = rePasswordController.text.isNotEmpty;
  }

  bool isValid() {
    return emailValid.value && emailController.text.isNotEmpty;
  }

  bool isValidBtnOtp() {
    return otpValid.value && otpController.text.isNotEmpty;
  }

  bool isValidBtnNewPass() {
    return emailValid.value &&
        emailController.text.isNotEmpty &&
        passwordValid.value &&
        passwordController.text.isNotEmpty &&
        rePasswordValid.value &&
        rePasswordController.text.isNotEmpty;
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleShowRePassword() {
    isShowRePassword.value = !isShowRePassword.value;
  }

  onSubmit() async {
    if (!CheckEmailValidator.validate(emailController.text)) {
      emailValid.value = false;
      emailErrorMsg.value = 'invalid_email'.tr;
      DialogUtil.showErrorMessage(emailErrorMsg.value);
      return;
    }

    if (isValid() && loading.isFalse) {
      loading.value = true;
      await client
          .verifedForgot(emailController.text.toLowerCase())
          .then((response) async {
        print(response);
        loading.value = false;
        Get.toNamed(Routes.VERIFY_OTP);
      }).catchError((error, trace) {
        Get.log(error.toString(), isError: true);
        Get.log(trace.toString(), isError: true);
        loading.value = false;
        String? msg = ErrorUtil.getError(error, trace);
        if (ObjectUtil.isNotEmpty(msg)) {
          if (msg == 'email must be an email') {
            msg = 'invalid_email'.tr;
            emailValid.value = false;
          }
          if (msg == 'EMAIL_EXIST') {
            emailValid.value = false;
          }
          DialogUtil.showErrorMessage(msg!.tr);
        } else {
          DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
        }
      });
      loading.value = false;
    } else {
      loading.value = false;
      if (emailController.text.isEmpty) {
        emailValid.value = false;
        emailErrorMsg.value = 'invalid_email'.tr;
      }
    }
  }

  onVerifyOTP() async {
    if (loading.isFalse) {
      loading.value = true;
      if (otpController.text.isValidOTP()) {
        await client
            .confirmForgotOTP(emailController.text.toLowerCase(),
                int.parse(otpController.text))
            .then((response) async {
          loading.value = false;
          otpValid.value = true;
          Get.toNamed(Routes.NEW_PASS);
        }).catchError((error, trace) {
          loading.value = false;
          print(error);
          print(trace);
          String? msg = ErrorUtil.getError(error, trace);

          if (ObjectUtil.isNotEmpty(msg)) {
            DialogUtil.showErrorMessage(otpErrorMsg.value);
            otpErrorMsg.value = msg!.tr;
            otpValid.value = false;
            otpController.text = '';
            return;
          } else {
            DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
          }
        });
      } else {
        loading.value = false;
        otpValid.value = false;
        otpErrorMsg.value = 'CONFIRM_CODE_NOT_VALID'.tr;
        DialogUtil.showErrorMessage(otpErrorMsg.value);
        return;
      }
    }
  }

  onSubmitNewPass() async {
    try {
      if (!CheckEmailValidator.validate(emailController.text)) {
        emailValid.value = false;
        emailErrorMsg.value = 'invalid_email'.tr;
        DialogUtil.showErrorMessage(emailErrorMsg.value);
        return;
      }

      if (!passwordController.text.isValidPassword()) {
        passwordValid.value = false;
        passErrorMsg.value = 'invalid_password'.tr;
        DialogUtil.showErrorMessage(passErrorMsg.value);
        return;
      }
      if (!rePasswordController.text.isValidPassword()) {
        rePasswordValid.value = false;
        rePassError.value = 'invalid_password'.tr;
        DialogUtil.showErrorMessage(rePassError.value);
        return;
      }

      if (rePasswordController.text != passwordController.text) {
        rePasswordValid.value = false;
        rePassError.value = 'pass_not_true'.tr;
        DialogUtil.showErrorMessage(rePassError.value);
        return;
      }

      await client
          .resetPasscode(
              emailController.text.toLowerCase(), passwordController.text)
          .then((response) async {
        loading.value = false;
        otpValid.value = true;
        Get.offAndToNamed(Routes.LOGIN);
      }).catchError((error, trace) {
        loading.value = false;
        print(error);
        print(trace);
        String? msg = ErrorUtil.getError(error, trace);

        if (ObjectUtil.isNotEmpty(msg)) {
          DialogUtil.showErrorMessage(otpErrorMsg.value);
          otpErrorMsg.value = msg!.tr;
          otpValid.value = false;
          otpController.text = '';
          return;
        } else {
          DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
        }
      });
    } catch (error) {
      loading.value = false;
      DialogUtil.showErrorMessage("serve_error".tr);
    }
  }
}

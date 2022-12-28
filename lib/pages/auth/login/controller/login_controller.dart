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
import 'package:oke_car_flutter/pages/home/controller/home_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_capture_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';
import 'dart:core';

class LoginController extends GetxController {
  final AuthenticateClient client;

  LoginController({
    required this.client,
  });

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();
  var loading = false.obs;
  var isShowPassword = false.obs;
  var emailValid = true.obs;
  var passwordValid = true.obs;
  var otpValid = true.obs;
  var emailErrorMsg = 'invalid_email'.tr.obs;
  var passErrorMsg = 'invalid_password'.tr.obs;
  var otpErrorMsg = 'invalid_otp'.tr.obs;
  var verifyTime = DateTime.now().toLocal().millisecondsSinceEpoch.obs;

  @override
  void onInit() {
    super.onInit();
    String? username = ConfigDB().getConfigByName(CONFIG_LAST_USERNAME);
    if (ObjectUtil.isNotEmpty(username)) {
      emailController.text = username!;
    } else {
      emailController.clear();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    otpController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    otpFocus.dispose();
    super.onClose();
  }

  onChangeText(String text) {
    if (emailController.text.isEmpty) {
      emailErrorMsg.value = 'Vui lòng nhập tên'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
  }

  onChangePass(String pass) {
    passwordValid.value = passwordController.text.isNotEmpty;
  }

  onSubmitLogin() async {
    if (!passwordController.text.isValidPassword()) {
      passwordValid.value = false;
      passErrorMsg.value = 'invalid_password'.tr;
      DialogUtil.showErrorMessage(passErrorMsg.value);
      return;
    }

    if (isValid()) {
      loading.value = true;
      await client
          .login(emailController.text.toLowerCase(), passwordController.text)
          .then((response) async {
            print(response);
        ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);
        await ConfigDB().save(ConfigModel(
            CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
        await ConfigDB().save(
            ConfigModel(CONFIG_USERNAME, emailController.text.toLowerCase()));
            await client.getAccountInfo().then((response) async {
              final user = await UserDB()
                  .save(UserModel.fromJson(response.data['data']));
              ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.userName));
              DialogUtil.showSuccessToast('login_success'.tr);
              try {
                Get.find<HomeController>();
                Get.offAllNamed(Routes.SPLASH);
              } catch (ex) {
                Get.offAllNamed(Routes.HOME);
              }
            }).catchError((error, trace) {
              Get.log(error.toString(), isError: true);
              Get.log(trace.toString(), isError: true);
              DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
              Get.back();
            });
        loading.value = false;
        // Get.toNamed(
        //   Routes.VERIFY_OTP,
        //   arguments: {
        //     'screen': VerifyScreen.login,
        //     'type': VerifyType.otp,
        //     'address': keywordController.text,
        //   },
        // );
      }).catchError((error, trace) {
        Get.log(error.toString(), isError: true);
        Get.log(trace.toString(), isError: true);
        loading.value = false;
        String? msg = ErrorUtil.getError(error, trace);
        if (ObjectUtil.isNotEmpty(msg)) {
          if (msg == 'LOGIN_ERROR' ||
              msg == 'CAN_NOT_FIND_USER' ||
              msg == 'INVALID_EMAIL') {
            emailErrorMsg.value = msg!.tr;
            emailValid.value = false;
          } else {
            passErrorMsg.value = msg!.tr;
            passwordValid.value = false;
          }
          DialogUtil.showErrorMessage(msg.tr);
        } else {
          DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
        }
      });
    } else {
      loading.value = false;
      if (emailController.text.isEmpty) {
        emailValid.value = false;
        emailErrorMsg.value = 'invalid_email'.tr;
      }

      if (passwordController.text.isEmpty) {
        passwordValid.value = false;
        passErrorMsg.value = 'invalid_password'.tr;
      }
    }
  }

  bool isValid() {
    return emailValid.value &&
        passwordValid.value &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  onResendOTP(bool isCountdown) async {
    if (isCountdown) {
      loading.value = true;
      await client
          .login(emailController.text, passwordController.text)
          .then((response) async {
        await ConfigDB().save(ConfigModel(
            CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
        await ConfigDB().save(
            ConfigModel(CONFIG_USERNAME, emailController.text.toLowerCase()));
        loading.value = false;
        onSendOTP();
      }).catchError((error, trace) {
        loading.value = false;
        print(error);
        print(trace);
        String? msg = ErrorUtil.getError(error, trace);
        if (ObjectUtil.isNotEmpty(msg)) {
          otpValid.value = false;
        } else {
          DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
        }
      });
      otpValid.value = true;
      otpController.text = '';
    }
  }

  onVerifyOTP() async {
    // if (loading.isFalse) {
    //   loading.value = true;
    //   if (otpController.text.isValidOTP()) {
    //     await client
    //         .confirmLoginOTP(
    //             ConfigDB().getConfigByName(CONFIG_ACCESS_TOKEN) ?? '',
    //             otpController.text)
    //         .then((response) async {
    //       await ConfigDB().save(ConfigModel(
    //           CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
    //       await client.getAccountInfo().then((response) async {
    //         final user =
    //             await UserDB().save(UserModel.fromJson(response.data['data']));
    //         ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.email));

    //         fcmService.getFcmToken(userClient);
    //         await ConfigDB().save(ConfigModel(
    //             CONFIG_ACCOUNT_MODE,
    //             user.mode == ACCOUNT_MODE_VIRTUAL
    //                 ? ACCOUNT_MODE_VIRTUAL
    //                 : ACCOUNT_MODE_REAL));
    //         Get.offAllNamed(Routes.HOME);
    //       }).catchError((error, trace) {
    //         loading.value = false;
    //         print(error);
    //         print(trace);
    //         String? msg = ErrorUtil.getError(error, trace);
    //         print(msg);
    //       });
    //     }).catchError((error, trace) {
    //       loading.value = false;
    //       print(error);
    //       print(trace);
    //       String? msg = ErrorUtil.getError(error, trace);
    //       if (ObjectUtil.isNotEmpty(msg)) {
    //         otpErrorMsg.value = msg!.tr;
    //         otpValid.value = false;
    //         DialogUtil.showErrorMessage(otpErrorMsg.value);
    //         otpController.text = '';
    //         return;
    //       } else {
    //         DialogUtil.showErrorMessage('SYSTEM_ERROR'.tr);
    //         otpController.text = '';
    //       }
    //     });
    //   } else {
    //     loading.value = false;
    //     otpValid.value = false;
    //     otpErrorMsg.value = 'CONFIRM_CODE_NOT_VALID'.tr;
    //     DialogUtil.showErrorMessage(otpErrorMsg.value);
    //     otpController.text = '';
    //     return;
    //   }
    // }
  }

  onBack() {
    Get.back();
  }

  onSendOTP() {
    verifyTime.value =
        DateTime.now().toLocal().millisecondsSinceEpoch + 1000 * RESEND_OTP;
  }

  onForgotPass() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  onGoToRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }
}

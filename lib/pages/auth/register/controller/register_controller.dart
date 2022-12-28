import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
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
import 'package:oke_car_flutter/pages/auth/register/view/_verify_otp.dart';
import 'package:oke_car_flutter/pages/home/controller/home_controller.dart';
import 'package:oke_car_flutter/repositories/authenticate_client.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/utils/dialog_util.dart';
import 'package:oke_car_flutter/utils/error_util.dart';
import 'package:oke_car_flutter/utils/object_util.dart';

class RegisterController extends GetxController {
  final AuthenticateClient client;

  RegisterController({required this.client});

  final ExpandableController expandableController = ExpandableController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController surNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode otpFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode userNameFocus = FocusNode();
  final FocusNode surNameFocus = FocusNode();
  final FocusNode nameFocus = FocusNode();
  final FocusNode rePassFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  var loading = false.obs;
  var isShowPassword = false.obs;
  var isShowRePassword = false.obs;
  var emailValid = true.obs;
  var userValid = true.obs;
  var surNameValid = true.obs;
  var nameValid = true.obs;
  var phoneValid = true.obs;
  var passValid = true.obs;
  var rePassValid = true.obs;
  var emailErrorMsg = 'invalid_email'.tr.obs;
  var userError = 'invalid_email'.tr.obs;
  var surError = 'invalid_email'.tr.obs;
  var nameError = 'invalid_email'.tr.obs;
  var phoneError = 'invalid_email'.tr.obs;
  var passError = 'invalid_email'.tr.obs;
  var rePassError = 'invalid_email'.tr.obs;

  final hasUppercase = false.obs;
  final hasLowercase = false.obs;
  final hasDigit = false.obs;
  final hasMinLength = false.obs;

  var verifyTime = DateTime.now().toLocal().millisecondsSinceEpoch.obs;
  TapGestureRecognizer? privacyRecognizer;
  TapGestureRecognizer? termsRecognizer;
  bool hasError = false;
  var passwordValid = true.obs;
  var rePasswordValid = true.obs;
  var otpValid = true.obs;

  var passErrorMsg = 'invalid_password'.tr.obs;
  var otpErrorMsg = 'invalid_otp'.tr.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    expandableController.dispose();
    otpController.dispose();
    emailController.dispose();
    userNameController.dispose();
    surNameController.dispose();
    nameController.dispose();
    phoneController.dispose();
    rePasswordController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    userNameFocus.dispose();
    surNameFocus.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    rePassFocus.dispose();
    super.onClose();
  }

  initDeeplinkRef() {
    // String? refCode = ConfigDB().getConfigByName(CONFIG_REF_CODE_DEEPLINK);
    // if (ObjectUtil.isNotEmpty(refCode)) {
    //   expandableController.toggle();
    //   referralController.text = refCode ?? '';
    // }
  }

  openPrivacy() {
    // launch(LINK_PRIVACY_POLICY);
  }

  openTerms() {
    // launch(LINK_TERM_OF_USE);
  }

  onChangeEmail(String email) {
    if (!emailController.text.isValidEmail()) {
      emailErrorMsg.value = 'invalid_email'.tr;
    }
    emailValid.value = emailController.text.isNotEmpty;
    ConfigDB().save(ConfigModel(CONFIG_REGISTER_USERNAME, email));
  }

  onChangePass(String text) {
    hasUppercase.value = passwordController.text.hasUppercase();
    hasLowercase.value = passwordController.text.hasLowercase();
    hasDigit.value = passwordController.text.hasDigit();
    hasMinLength.value = passwordController.text.hasMinLength();
    passValid.value = hasUppercase.value &&
        hasLowercase.value &&
        hasDigit.value &&
        hasMinLength.value;
  }

  onChangeUserName(String text) {
    userValid.value = userNameController.text.isNotEmpty;
  }

  onChangeSurName(String text) {
    surNameValid.value = surNameController.text.isNotEmpty;
  }

  onChangeName(String text) {
    nameValid.value = nameController.text.isNotEmpty;
  }

  onChangePhone(String text) {
    phoneValid.value = phoneController.text.isNotEmpty;
  }

  onChangeRePass(String text) {
    rePassValid.value = rePasswordController.text.isNotEmpty;
  }

  onSubmitRegister() {
    loading.value = true;
    resetFocus();
    if (isValidatePass()) {
      final data = {
        "email": emailController.text.toLowerCase(),
        "phone": phoneController.text,
        "userName": nameController.text.toLowerCase(),
        "password": passwordController.text
      };
      client.register(data).then((response) async {
        ConfigDB().deleteConfigByName(CONFIG_REGISTER_USERNAME);
        await ConfigDB().save(ConfigModel(
            CONFIG_ACCESS_TOKEN, response.data['data']['access_token']));
          final user =
              await UserDB().save(UserModel.fromJson(response.data['data']['user']));
          ConfigDB().save(ConfigModel(CONFIG_LAST_USERNAME, user.email));
          loading.value = false;
          DialogUtil.showSuccessToast('Đăng kí thành công'.tr);
          try {
            Get.find<HomeController>();
            Get.offAllNamed(Routes.SPLASH);
          } catch (ex) {
            Get.offAllNamed(Routes.HOME);
          }

      }).catchError((error, trace) {
        loading.value = false;
        Get.log(error.toString(), isError: true);
        Get.log(trace.toString(), isError: true);
        String? msg = ErrorUtil.getError(error, trace);
        if (ObjectUtil.isNotEmpty(msg)) {
          DialogUtil.showErrorMessage(msg?.tr ?? "Có lỗi xảy ra");
        }
      });
    }
    loading.value = false;
  }

  onGoToLogin() {
    Get.back();
  }

  resetFocus() {
    FocusScope.of(Get.context!).requestFocus(new FocusNode());
  }

  onBack() {
    Get.back();
  }

  onSendOTP() {
    verifyTime.value =
        DateTime.now().toLocal().millisecondsSinceEpoch + 1000 * RESEND_OTP;
  }

  onResendOTP(bool isCountdown) async {
    // if (isCountdown) {
    //   loading.value = true;
    //   await client
    //       .preRegister(emailController.text.toLowerCase(),
    //           referralCode: referralController.text)
    //       .then((response) async {
    //     loading.value = false;
    //     onSendOTP();
    //     // ignore: invalid_return_type_for_catch_error
    //   }).catchError(ErrorUtil.catchError);
    //   loading.value = false;
    //   otpValid.value = true;
    //   otpController.text = '';
    // }
  }

  preRegister() async {}

  onVerifyEmail() async {
    if (!CheckEmailValidator.validate(emailController.text)) {
      emailValid.value = false;
      emailErrorMsg.value = 'invalid_email'.tr;
      DialogUtil.showErrorMessage(emailErrorMsg.value);
      return;
    }

    if (isValid() && loading.isFalse) {
      loading.value = true;
      await client
          .verifedEmail(emailController.text.toLowerCase())
          .then((response) async {
        print(response);
        loading.value = false;
        Get.toNamed(Routes.REGISTER_OTP);
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
            .confirmRegisterOTP(emailController.text.toLowerCase(),
                int.parse(otpController.text))
            .then((response) async {
          loading.value = false;
          otpValid.value = true;
          Get.toNamed(Routes.CREATE_PASS);
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


  bool isValid() {
    return emailValid.value && emailController.text.isNotEmpty;
  }

  bool isValidatePass() {
    return passValid.value && passwordController.text.isNotEmpty;
  }

  toggleShowPassword() {
    isShowPassword.value = !isShowPassword.value;
  }

  toggleShowRePassword() {
    isShowRePassword.value = !isShowRePassword.value;
  }

// bool isValid() {
//   return emailValid.value &&
//       passwordValid.value &&
//       emailController.text.isNotEmpty &&
//       passwordController.text.isNotEmpty;
// }

}

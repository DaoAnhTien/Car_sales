import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:pinput/pinput.dart';

class VerifyFormWidget extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        child: Pinput(
          showCursor: true,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          length: 4,
          onCompleted: (String pin) {
            controller.onVerifyOTP();
          },
          onClipboardFound: (value) {
            if (value.length == 4 && value.isNumericOnly) {
              controller.otpController.setText(value);
            }
          },
          androidSmsAutofillMethod:
          AndroidSmsAutofillMethod.smsUserConsentApi,
          hapticFeedbackType: HapticFeedbackType.lightImpact,
          focusNode: controller.otpFocus,
          controller: controller.otpController,
          defaultPinTheme: PinTheme(
            width: 60.w,
            height: 60.w,
            textStyle: Style().bodyStyle1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                width: 2.0,
                color: context.theme.primaryColor,
              ),
              color: context.theme.backgroundColor,
            ),
          ),
          focusedPinTheme: PinTheme(
            width: 68.w,
            height: 68.w,
            textStyle: Style().titleStyle1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                width: 2.0,
                color: context.theme.colorScheme.secondary,
              ),
              color: context.theme.backgroundColor,
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 60.w,
            height: 60.w,
            textStyle: Style().titleStyle1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                width: 2.0,
                color: context.theme.primaryColor,
              ),
              color: context.theme.backgroundColor,
            ),
          ),
          followingPinTheme: PinTheme(
            width: 60.w,
            height: 60.w,
            textStyle: Style().bodyStyle1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              color: context.theme.cardColor,
            ),
          ),
          cursor: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.w),
                width: 22.w,
                height: 2.w,
                color: context.theme.primaryColor,
              ),
            ],
          ),
          autofocus: true,
          pinAnimationType: PinAnimationType.scale,
        ),
      ),
    );
  }
}

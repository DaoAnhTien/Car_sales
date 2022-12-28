import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:oke_car_flutter/pages/auth/login/controller/login_controller.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_default_header.dart';

import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

class VerifyLoginOTP extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: context.theme.backgroundColor,
          appBar: CustomAppBar(),
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          DefaultHeader(
                            padding: EdgeInsets.only(top: 50.w, bottom: 32.w),
                            title: 'verify_otp_title'.tr,
                            description: 'verify_otp_content'.trArgs([
                              'email_address'.tr.toLowerCase(),
                              controller.emailController.text
                            ]),
                          ),
                          // PinPut(
                          //   withCursor: true,
                          //   fieldsAlignment: MainAxisAlignment.spaceEvenly,
                          //   fieldsCount: 4,
                          //   eachFieldWidth: 50.0,
                          //   eachFieldHeight: 50.0,
                          //   onSubmit: (String pin) {
                          //     controller.onVerifyOTP();
                          //   },
                          //   focusNode: controller.otpFocus,
                          //   controller: controller.otpController,
                          //   textStyle: Style().titleStyle1,
                          //   submittedFieldDecoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.w),
                          //     border: Border.all(
                          //       width: 2.0,
                          //       color: context.theme.primaryColor,
                          //     ),
                          //     color: context.theme.backgroundColor,
                          //   ),
                          //   selectedFieldDecoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.w),
                          //     border: Border.all(
                          //       width: 2.0,
                          //       color: context.theme.colorScheme.secondary,
                          //     ),
                          //     color: context.theme.backgroundColor,
                          //   ),
                          //   followingFieldDecoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(10.w),
                          //     // border: Border.all(
                          //     //   width: 2.0,
                          //     //   color: Get.theme.hintColor,
                          //     // ),
                          //     color: context.theme.cardColor,
                          //   ),
                          //   autofocus: true,
                          //   // pinAnimationType: PinAnimationType.scale,
                          // ),
                          SizedBox(
                            height: 48.w,
                          ),
                          Obx(
                            () => RadiusButton(
                              isFullWidth: true,
                              maxWidth: double.infinity,
                              radius: 10,
                              outsidePadding: EdgeInsets.only(
                                top: 23.w,
                                bottom: 20.w,
                              ),
                              innerPadding: controller.loading.value
                                  ? EdgeInsets.only(
                                      top: 14.w,
                                      bottom: 14.w,
                                      left: 20.w,
                                      right: 20.w)
                                  : EdgeInsets.only(
                                      top: 16.w,
                                      bottom: 16.w,
                                      left: 5.w,
                                      right: 5.w,
                                    ),
                              isLoading: controller.loading.value,
                              indicatorSize: 24.w,
                              text: 'btn_login'.tr,
                              fontFamily: Style.fontBold,
                              fontSize: 16.sp,
                              backgroundColor: context.theme.primaryColor,
                              textColor: context.textTheme.button!.color,
                              onTap: controller.onVerifyOTP,
                            ),
                          ),
                          Obx(() => CountdownTimer(
                                endTime: controller.verifyTime.value,
                                widgetBuilder: (_, CurrentRemainingTime? time) {
                                  return GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 10.w),
                                      padding: EdgeInsets.all(30.w),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'resend_otp'.tr,
                                              style: Style().hintStyleDemoBold,
                                            ),
                                            TextSpan(
                                              text:
                                                  ' (${time == null ? 0 : ((time.min ?? 0) * 60 + (time.sec ?? 0))}s)'
                                                      .tr,
                                              style: Style().hintStyleDemoBold,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      controller.onResendOTP(time == null);
                                    },
                                  );
                                },
                                onEnd: () {},
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onTap: controller.resetFocus,
          ),
        ),
      ),
    );
  }
}

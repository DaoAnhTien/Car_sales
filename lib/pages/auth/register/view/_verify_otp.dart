import 'package:flutter/material.dart';
import 'package:oke_car_flutter/pages/auth/register/controller/register_controller.dart';
import 'package:oke_car_flutter/pages/auth/register/widget/verify_form.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_default_header.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

class VerifyRegisterOTP extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            appBar: CustomAppBar(),
            resizeToAvoidBottomInset: false,
            backgroundColor: context.theme.backgroundColor,
            body: GestureDetector(
              onTap: controller.resetFocus,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.w),
                      bottomRight: Radius.circular(50.w)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLogo(context),
                    DefaultHeader(
                      padding:
                          EdgeInsets.only(top: 5.w, bottom: 32.w),
                      title: 'verification'.tr,
                      description: "verification_desc".tr,
                    ),
                    VerifyFormWidget(),
                    buildFooter(context),
                  ],
                ),
                // onTap: controller.resetFocus,
              ),
            )),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        AppSetting.imgLogo,
        width: 150.w,
        height: 150.w,
      ),
    );
  }

  Widget buildFooter(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      SizedBox(height: 16.w),
      Obx(
        () => RadiusButton(
          isFullWidth: true,
          // isDisable: !controller.isValidBtnOtp(),
          maxWidth: double.infinity,
          radius: 24.w,
          outsidePadding: EdgeInsets.only(
            top: 23.w,
            bottom: 20.w,
          ),
          innerPadding: controller.loading.value
              ? EdgeInsets.only(
                  top: 14.w, bottom: 14.w, left: 20.w, right: 20.w)
              : EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
          isLoading: controller.loading.value,
          indicatorSize: 24.w,
          text: 'btn_verify'.tr,
          fontFamily: Style.fontDemiBold,
          fontSize: 17.sp,
          backgroundColor: context.theme.primaryColor,
          textColor: context.textTheme.button!.color,
          onTap: controller.onVerifyOTP
        ),
      ),
    ]);
  }
}

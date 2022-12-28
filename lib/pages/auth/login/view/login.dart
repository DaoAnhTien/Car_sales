import 'package:flutter/material.dart';
import 'package:oke_car_flutter/pages/auth/login/controller/login_controller.dart';
import 'package:oke_car_flutter/pages/auth/login/widget/login_form.dart';
import 'package:oke_car_flutter/routes/app_pages.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_default_header.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            // bottomNavigationBar: Container(color: context.theme.ac,),
            backgroundColor: context.theme.backgroundColor,
            body: GestureDetector(
              onTap: controller.resetFocus,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: context.theme.backgroundColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50.w),
                          bottomRight: Radius.circular(50.w)),
                    ),
                    child: Container(
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLogo(context),
                            DefaultHeader(
                              padding: EdgeInsets.only(top: 24.w, bottom: 4.w),
                              title: 'login_title'.tr,
                              description:
                                  'Chào mừng quý khách! Bạn chưa có tài khoản ?'
                                      .tr,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.toNamed(Routes.REGISTER);
                              },
                              child: Text(
                                'Đăng kí ngay',
                                style: Style()
                                    .subtitleStyle2
                                    .copyWith(color: context.theme.primaryColor),
                              ),
                            ),
                            SizedBox(
                              height: 24.w,
                            ),
                            LoginFormWidget(),
                            buildFooter(context),
                          ],
                        ),
                      ),
                    ),
                    // onTap: controller.resetFocus,
                  ),
                ],
              ),
            )
            // body: GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            //   child: Container(
            //     width: double.infinity,
            //     margin: EdgeInsets.symmetric(horizontal: 16.w),
            //     child: SingleChildScrollView(
            //       physics: ClampingScrollPhysics(),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           DefaultHeader(
            //             padding: EdgeInsets.only(top: 24.w, bottom: 32.w),
            //             title: 'login_title'.tr,
            //             description: 'login_content'.tr,
            //           ),
            //           LoginFormWidget(),
            //           buildFooter(context),
            //         ],
            //       ),
            //     ),
            //   ),
            //   onTap: controller.resetFocus,
            // ),
            ),
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
      Obx(
        () => RadiusButton(
          isFullWidth: true,
          isDisable: !controller.isValid(),
          maxWidth: double.infinity,
          radius: 10.w,
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
          text: 'btn_login'.tr,
          fontFamily: Style.fontDemiBold,
          fontSize: 17.sp,
          backgroundColor: context.theme.primaryColor,
          textColor: context.textTheme.button!.color,
          onTap: controller.onSubmitLogin,
        ),
      ),
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: Text(
          'forget_pass'.tr,
          style: Style().bodyStyle1.copyWith(color: context.theme.primaryColor),
        ),
        onTap: controller.onForgotPass,
      ),
    ]);
  }

  Widget _buildRegister(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'login_note'.tr,
                style: Style()
                    .bodyStyle1
                    .copyWith(color: context.theme.backgroundColor),
              ),
            ),
            SizedBox(
              width: 16.w,
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: controller.onGoToRegister,
              child: Container(
                child: Text(
                  'register'.tr,
                  style: Style()
                      .bodyStyle2
                      .copyWith(color: context.theme.backgroundColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

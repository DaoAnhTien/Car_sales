import 'dart:convert';

import 'package:im_stepper/stepper.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/car_description.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/info_user_widget.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/news_content.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/upload_image.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class PostCreatePage extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Obx(
        () => Scaffold(
          resizeToAvoidBottomInset:
              controller.activeStep.value == 2 ? true : false,
          appBar: CustomHeaderWidget(
            onBackPress: () {
              if (controller.activeStep.value > 0) {
                controller.activeStep.value--;
              } else
                Get.back();
            },
            bgColor: Style.toastErrorBgColor,
            title: buildHeaderTitle(controller.activeStep.value),
            titleColor: context.theme.backgroundColor,
          ),
          backgroundColor: Style.whiteColor,
          body: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: controller.resetFocus,
            child: Column(
              children: [
                NumberStepper(
                  enableStepTapping: false,
                  enableNextPreviousButtons: false,
                  steppingEnabled: true,
                  numbers: [1, 2, 3, 4],
                  activeStep: controller.activeStep.value,
                ),
                Expanded(child: buildBody(controller.activeStep.value)),
                RadiusButton(
                  isFullWidth: true,
                  isDisable: !controller.isValid(),
                  maxWidth: double.infinity,
                  radius: 10.w,
                  outsidePadding: EdgeInsets.only(
                      top: 23.w, bottom: 35.w, left: 16.w, right: 16.w),

                  innerPadding: EdgeInsets.only(
                    top: 16.w,
                    bottom: 16.w,
                    left: 5.w,
                    right: 5.w,
                  ),
                  isLoading: controller.loading.value,
                  indicatorSize: 24.w,
                  text: controller.activeStep.value == 3
                      ? "Đăng tin"
                      : 'Tiếp tục'.tr,
                  fontFamily: Style.fontBold,
                  fontSize: 17.sp,
                  backgroundColor: context.theme.primaryColor,
                  textColor: context.textTheme.headline4!.color,
                  onTap: () {
                    if (controller.activeStep.value < 2) {
                      controller.nextScreen();
                    } else if (controller.activeStep.value == 2) {
                      controller.checkValid();
                    }
                    else if (controller.activeStep.value == 3) {
                      controller.postNews();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(int index) {
    switch (index) {
      case 0:
        return UploadImage();
      case 1:
        return CarDescription();
      case 2:
        return NewContent();
      case 3:
        return InfoUserWidget();
      default:
        return Container();
    }
  }

  String buildHeaderTitle(int index) {
    switch (index) {
      case 0:
        return 'Hình ảnh';
      case 1:
        return 'Thông tin xe';
      case 2:
        return 'Nội dung tin rao';
      case 3:
        return 'Thông tin liên hệ';
      default:
        return '';
    }
  }
}

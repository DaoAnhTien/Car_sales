import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/pages/auth/register/controller/register_controller.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_default_header.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';

class CreatePass extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.theme.backgroundColor,
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: context.theme.backgroundColor,
        body: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultHeader(
                          padding: EdgeInsets.only(bottom: 32.w),
                          title: 'Hoàn thành đăng kí'.tr,
                          description: 'Vui lòng điền form'.tr,
                        ),
                        Obx(() => TittleDefaultTextField(
                              width: double.infinity,
                              radius: 12,
                              controller: controller.nameController,
                              focusNode: controller.nameFocus,
                              maxLength: 30,
                              title: 'username'.tr,
                              hintText: 'Tên đăng nhập'.tr,
                              inputFormatter: [
                                FilteringTextInputFormatter.deny(' '),
                              ],
                              errorMsg: controller.nameValid.value
                                  ? null
                                  : controller.nameError.value,
                              innerPadding: EdgeInsets.only(
                                  top: 16.w,
                                  bottom: 16.w,
                                  left: 20.w,
                                  right: 20.w),
                              outsidePadding: EdgeInsets.only(bottom: 16.w),
                              onChanged: (text) {
                                controller.onChangeName(text);
                              },
                            )),
                        Obx(() => TittleDefaultTextField(
                              width: double.infinity,
                              radius: 12,
                              controller: controller.phoneController,
                              focusNode: controller.phoneFocus,
                              maxLength: 30,
                              title: 'username'.tr,
                              hintText: 'Số điện thoại'.tr,
                              inputFormatter: [
                                FilteringTextInputFormatter.deny(' '),
                              ],
                              errorMsg: controller.nameValid.value
                                  ? null
                                  : controller.nameError.value,
                              innerPadding: EdgeInsets.only(
                                  top: 16.w,
                                  bottom: 16.w,
                                  left: 20.w,
                                  right: 20.w),
                              outsidePadding: EdgeInsets.only(bottom: 16.w),
                              onChanged: (text) {
                                controller.onChangePhone(text);
                              },
                            )),
                        Obx(() => TittleDefaultTextField(
                              width: double.infinity,
                              radius: 12,
                              controller: controller.passwordController,
                              focusNode: controller.passFocus,
                              title: 'password'.tr,
                              hintText: 'password_placeholder'.tr,
                              obscureText: !controller.isShowPassword.value,
                              maxLength: 16,
                              autoFillHints: const [AutofillHints.password],
                              errorMsg: controller.passValid.value
                                  ? null
                                  : controller.passErrorMsg.value,
                              innerPadding: EdgeInsets.only(
                                  top: 16.w,
                                  bottom: 16.w,
                                  left: 20.w,
                                  right: 20.w),
                              outsidePadding: EdgeInsets.only(bottom: 16.w),
                              suffix: Icon(
                                controller.isShowPassword.value
                                    ? Icons.remove_red_eye
                                    : Icons.remove_red_eye_outlined,
                                color: context.theme.iconTheme.color!
                                    .withOpacity(0.5),
                              ),
                              onTabSuffix: controller.toggleShowPassword,
                              onChanged: (text) {
                                controller.onChangePass(text);
                              },
                            )),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AnimatedOpacity(
                                  opacity:
                                      controller.hasUppercase.value ? 1.0 : 0.4,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: controller.hasUppercase.value
                                            ? context.theme.primaryColorLight
                                            : context.theme.hintColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Có kí tự in hoa'.tr,
                                        style: Style().noteStyleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AnimatedOpacity(
                                  opacity:
                                      controller.hasDigit.value ? 1.0 : 0.4,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: controller.hasDigit.value
                                            ? context.theme.primaryColorLight
                                            : context.theme.hintColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Có kí tự số'.tr,
                                        style: Style().noteStyleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AnimatedOpacity(
                                  opacity:
                                      controller.hasLowercase.value ? 1.0 : 0.4,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: controller.hasLowercase.value
                                            ? context.theme.primaryColorLight
                                            : context.theme.hintColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Có kí tự in thường'.tr,
                                        style: Style().noteStyleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Obx(
                                () => AnimatedOpacity(
                                  opacity:
                                      controller.hasMinLength.value ? 1.0 : 0.4,
                                  duration: const Duration(milliseconds: 200),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: controller.hasMinLength.value
                                            ? context.theme.primaryColorLight
                                            : context.theme.hintColor,
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        'Đủ 8 kí tự'.tr,
                                        style: Style().noteStyleRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 53.w,
                        ),
                        Obx(() => RadiusButton(
                              isFullWidth: true,
                              maxWidth: double.infinity,
                              isDisable: !controller.passValid.value ||
                                  controller.passwordController.text.isEmpty ||
                                  !controller.hasUppercase.value ||
                                  !controller.hasLowercase.value ||
                                  !controller.hasDigit.value ||
                                  !controller.hasMinLength.value ||
                                  !controller.nameValid.value ||
                                  controller.nameController.text.isEmpty ,
                              radius: 12,
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
                              text: 'Hoàn thành'.tr,
                              fontFamily: Style.fontBold,
                              fontSize: 16.sp,
                              backgroundColor: context.theme.primaryColor,
                              textColor: context.textTheme.button!.color,
                              onTap: controller.onSubmitRegister,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: controller.resetFocus,
          ),
        ),
      ),
    );
  }
}

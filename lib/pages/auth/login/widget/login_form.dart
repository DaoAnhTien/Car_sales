import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/login/controller/login_controller.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
import 'package:oke_car_flutter/widgets/custom_text_field.dart';

class LoginFormWidget extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(() => TittleDefaultTextField(
                width: double.infinity,
                radius: 10,
                controller: controller.emailController,
                focusNode: controller.emailFocus,
                hintText: 'Tên đăng nhập'.tr,
                inputFormatter: [FilteringTextInputFormatter.deny(' ')],
                textInputType: TextInputType.emailAddress,
                autoFillHints: [AutofillHints.email],
                errorMsg: controller.emailValid.value
                    ? null
                    : controller.emailErrorMsg.value,
                innerPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                onChanged: (text) {
                  controller.onChangeText(text);
                },
              )),
          SizedBox(height: 16.w,),
          Obx(
            () => TittleDefaultTextField(
              width: double.infinity,
              radius: 10,
              hintText: 'Mật khẩu',
              controller: controller.passwordController,
              focusNode: controller.passwordFocus,
              obscureText: !controller.isShowPassword.value,
              autoFillHints: [AutofillHints.password],
              textInputType: TextInputType.text,
              errorMsg: controller.passwordValid.value
                  ? null
                  : controller.passErrorMsg.value,
              innerPadding: EdgeInsets.only(left: 20.w, right: 20.w),
              outsidePadding: EdgeInsets.only(bottom: 16.w),
              suffix: Icon(
                controller.isShowPassword.value
                    ? Icons.remove_red_eye
                    : Icons.remove_red_eye_outlined,
                color: context.theme.iconTheme.color!.withOpacity(0.5),
              ),
              onTabSuffix: controller.toggleShowPassword,
              onChanged: (text) {
                controller.onChangePass(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

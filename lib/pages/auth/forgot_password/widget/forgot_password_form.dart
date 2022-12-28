import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/forgot_password/controller/forgot_password_controller.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
import 'package:oke_car_flutter/widgets/custom_text_field.dart';

class ForgotPasswordFormWidget extends GetView<ForgotPasswordController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Obx(
            () => TittleDefaultTextField(
              width: double.infinity,
              hintText: 'Nhập địa chỉ email',
              radius: 10,
              controller: controller.emailController,
              focusNode: controller.emailFocus,
              inputFormatter: [FilteringTextInputFormatter.deny(' ')],
              textInputType: TextInputType.emailAddress,
              autoFillHints: [AutofillHints.email],
              errorMsg: controller.emailValid.value
                  ? null
                  : controller.emailErrorMsg.value,
              innerPadding: EdgeInsets.only(
                  top: 20.w, bottom: 20.w, left: 20.w, right: 20.w),
              outsidePadding: EdgeInsets.only(bottom: 10.w),
              onChanged: (text) {
                controller.onChangeText(text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

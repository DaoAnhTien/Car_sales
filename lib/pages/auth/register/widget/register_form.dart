import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/auth/register/controller/register_controller.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_suggestion_text_field.dart';
import 'package:oke_car_flutter/widgets/_title_default_text_field.dart';
import 'package:oke_car_flutter/widgets/custom_text_field.dart';

class RegisterFormWidget extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Obx(
        () => TittleDefaultTextField(
          width: double.infinity,
          radius: 10,
          hintText: 'Nhập địa chỉ email',
          controller: controller.emailController,
          focusNode: controller.emailFocus,
          textInputType: TextInputType.emailAddress,
          autoFillHints: [AutofillHints.email],
          inputFormatter: [FilteringTextInputFormatter.deny(' ')],
          errorMsg: controller.emailValid.value
              ? null
              : controller.emailErrorMsg.value,
          innerPadding: EdgeInsets.only(
              top: 8.w, bottom: 8.w, left: 20.w, right: 20.w),
          outsidePadding: EdgeInsets.only(bottom: 16.w),
          onChanged: (text) {
            controller.onChangeEmail(text);
          },
        ),
      ),
    );
  }
}

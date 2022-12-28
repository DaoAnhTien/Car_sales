import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/text_warning.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_default_text_field.dart';

class InfoUserWidget extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWarning(
            title: 'Họ tên người bán',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.nameController,
            focusNode: controller.nameFocus,
            textInputType: TextInputType.text,
            autoFillHints: [AutofillHints.email],
            hintText: 'vd : Nguyễn Văn A',
            isAutoFocus: false,
            onChanged: (text) {},
          ),
          TextWarning(
            title: 'Điện thoại',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.phoneController,
            focusNode: controller.phoneFocus,
            textInputType: TextInputType.phone,
            autoFillHints: [AutofillHints.email],
            hintText: 'vd : 098888xxxx',
            isAutoFocus: false,
            onChanged: (text) {
              controller.onDesChange(text);
              // controller.onChangeReferral(text);
            },
          ),
          TextWarning(
            title: 'Địa chỉ',
          ),
          DefaultTextField(
            width: double.infinity,
            radius: 10,
            maxLines: null,
            controller: controller.addressController,
            focusNode: controller.addressFocus,
            textInputType: TextInputType.streetAddress,
            autoFillHints: [AutofillHints.addressCity],
            hintText: 'Nhập địa chỉ',
            isAutoFocus: false,
            onChanged: (text) {
              controller.onDesChange(text);
              // controller.onChangeReferral(text);
            },
          ),

        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/detailCar/detail-car-controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_default_text_field.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';


class AddVehicle extends GetView<DetailCarAdminController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.resetFocus,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeaderFilter(
                    title: 'Quản lí dòng xe',
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  // SizedBox(height: 16.0.w),
                  Divider(),
                  DefaultTextField(
                    width: double.infinity,
                    radius: 10,
                    maxLines: null,
                    maxLength: 100,
                    controller: controller.titleCarController,
                    focusNode: controller.titleCarFocus,
                    textInputType: TextInputType.text,
                    autoFillHints: [AutofillHints.email],
                    hintText: 'Nhập tên dòng xe',
                    isAutoFocus: false,
                    onChanged: (text) {
                      // controller.onChangeTitle(text);
                      // controller.onChangeReferral(text);
                    },
                  ),
                ],
              ),
              RadiusButton(
                isFullWidth: true,
                maxWidth: double.infinity,
                radius: 10.w,
                outsidePadding: EdgeInsets.only(top: 23.w, bottom: 35.w),
                innerPadding: EdgeInsets.only(
                  top: 16.w,
                  bottom: 16.w,
                  left: 5.w,
                  right: 5.w,
                ),
                indicatorSize: 24.w,
                text: controller.isEdit == false ? 'Thêm dòng xe' : "Cập nhật",
                fontFamily: Style.fontBold,
                fontSize: 17.sp,
                backgroundColor: context.theme.primaryColor,
                textColor: context.textTheme.headline4!.color,
                onTap: () {
                  controller.isEdit == false
                      ? controller.add()
                      : controller.edit(controller.idVehicle.value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

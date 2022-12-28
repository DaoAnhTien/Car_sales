import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/pages/admin/carCompany/carCompany-controller.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_radius_text_field.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

import '../../../widgets/_default_text_field.dart';
import '../../../widgets/_radius_button.dart';

class AddCar extends GetView<CarCompanyController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.resetFocus,
      child: Container(
        height: context.height - 50,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  CustomHeaderFilter(
                    title: 'Hãng xe',
                  ),
                  SizedBox(
                    height: 16.w,
                  ),
                  Obx(
                    () => AspectRatio(
                      aspectRatio: 1.5,
                      child: controller.imageCar.value.url.isEmpty
                          ? GestureDetector(
                              onTap: controller.uploadMedia,
                              behavior: HitTestBehavior.translucent,
                              child: Container(
                                alignment: Alignment.center,
                                width: context.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: context.theme.cardColor,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_rounded,
                                      size: 64.w,
                                    ),
                                    Text(
                                      'Tải ảnh lên'.tr,
                                      style: Style().bodyStyle3,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: controller.uploadMedia,
                              child: CachedImage(
                                AppUtil().getImage(
                                    key: controller.imageCar.value.url ?? ''),
                                defaultUrl: AppSetting.imgLogo,
                                fit: BoxFit.cover,
                                radius: 16,
                              ),
                            ),
                    ),
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
                    hintText: 'Nhập tên hãng xe',
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
                text: controller.isEdit == false ? 'Thêm hãng xe' : "Cập nhật",
                fontFamily: Style.fontBold,
                fontSize: 17.sp,
                backgroundColor: context.theme.primaryColor,
                textColor: context.textTheme.headline4!.color,
                onTap: () {
                  controller.isEdit == false
                      ? controller.addNewCarCompany()
                      : controller.edit(controller.idCar.value);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

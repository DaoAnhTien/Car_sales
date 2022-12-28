import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/color_model.dart';
import 'package:oke_car_flutter/pages/dashboard/model/car_company_model.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_cachedImage.dart';
import 'package:oke_car_flutter/widgets/_radius_text_field.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class ColorFilter extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          SizedBox(height: 8.0.w),
          _buildHeader(context),
          // SizedBox(height: 16.0.w),
          Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.listColor
                    .map<Widget>((carModel) => cityItem(context, carModel))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Get.back()),
        Expanded(
          child: Text('color_select'.tr,
              textAlign: TextAlign.center, style: Style().subtitleStyle1),
        ),
        SizedBox(width: 10.0.w),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.colorValue.value = ColorModel();
            Get.back();
          },
          child: Text(
            'all'.tr,
            style: Style()
                .normalStyle1
                .copyWith(color: context.theme.highlightColor),
          ),
        )
      ],
    );
  }

  Widget cityItem(BuildContext context, ColorModel model) {
    return Container(
      child: GestureDetector(
        onTap: () {
          controller.selectColor(model);
        },
        child: Container(
          // padding: EdgeInsets.all(8.0.w),

          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 24.w,
                    width: 24.w,
                    decoration: BoxDecoration(
                        color: Color(model.color),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Style.blackColor, width: 1)),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Expanded(
                    child: Text(
                      model.name.tr,
                      style: TextStyle(
                          color: context.textTheme.headline1!.color,
                          fontSize: 17.sp,
                          fontFamily: Style.fontDemiBold),
                    ),
                  ),
                  model == controller.colorValue.value
                      ? Icon(
                          Icons.check_sharp,
                          color: context.theme.primaryColorLight,
                          size: 22.w,
                        )
                      : SizedBox.shrink(),
                ],
              ),
              Container(
                height: 0.5.w,
                color: context.textTheme.caption!.color,
                margin: EdgeInsets.only(top: 16.w, bottom: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}

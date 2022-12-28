import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/models/vehicle_model.dart';
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

class CarLineWidget extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          CustomHeaderFilter(
            title: 'Dòng xe',
          ),
          // SizedBox(height: 16.0.w),
          Divider(),
          SizedBox(
            height: 16.w,
          ),
          Obx(() {
            final keyword = controller.carLineSearchValue.value;
            List<VehicleModel> branch = controller.listCarLine;

            if (keyword.isNotEmpty || keyword != '') {
              branch = branch
                  .where((element) =>
                      TiengViet.parse(element.title)
                          .toUpperCase()
                          .indexOf(TiengViet.parse(keyword).toUpperCase()) >
                      -1)
                  .toList();
            }
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: branch
                      .map<Widget>((carModel) => item(context, carModel))
                      .toList(),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget item(BuildContext context, VehicleModel model) {
    return Container(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          controller.setCarline(model);
        },
        child: Container(
          // padding: EdgeInsets.all(8.0.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(model.name, style: Style().noteStyleRegular),
                  model.name == controller.carLine.value.name
                      ? Icon(
                          Icons.check_circle_outline_sharp,
                          color: context.theme.primaryColorLight,
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

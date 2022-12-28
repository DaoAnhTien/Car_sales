import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:tiengviet/tiengviet.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/product/product_dashboard/controller/product_controller.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_custom_header.dart';
import 'package:oke_car_flutter/widgets/_radius_text_field.dart';
import 'package:oke_car_flutter/widgets/custom/customAppBar/custom_app_bar.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class ListYear extends GetView<ProductController> {
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
          SizedBox(height: 16.0.w),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                color: context.theme.backgroundColor,
                child: GridView.count(
                    crossAxisCount: context.width ~/ 130.w,
                    mainAxisSpacing: 12.w,
                    crossAxisSpacing: 8.w,
                    childAspectRatio: 4.25.w,
                    controller: ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: LIST_YEAR
                        .map<Widget>((e) => items(
                      e,
                      context,
                      isSelected: e == controller.year.value,
                    ))
                        .toList()),
              ),
            ),
          ),
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
          child: Text('year_sx'.tr,
              textAlign: TextAlign.center, style: Style().subtitleStyle1),
        ),
        SizedBox(width: 10.0.w),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            controller.year.value = '';
            Navigator.of(context).pop();
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

  Widget items(String year, BuildContext context, {bool? isSelected}) {
    return GestureDetector(
      onTap: () {
        controller.setYear(year);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        decoration: BoxDecoration(
            color: isSelected != false
                ? context.theme.colorScheme.secondary
                : context.theme.cardColor,
            borderRadius: BorderRadius.circular(16.w)),
        child: Text(
          year,
          textAlign: TextAlign.center,
          style: Style().noteStyleRegular,
        ),
      ),
    );
  }
}

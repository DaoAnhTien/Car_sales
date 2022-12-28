import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/controller/post_controller.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class SelectYearWidget extends GetView<PostController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          CustomHeaderFilter(
            title: 'Năm sản xuất',
          ),
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

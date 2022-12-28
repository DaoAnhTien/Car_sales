import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/pages/post/post_dashboard/widget/custom_hearder_filter.dart';
import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/utils/auth_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class CarCategoryValue extends StatelessWidget {
  final int value;
  final Function(int value) onTap;

  CarCategoryValue({required this.value, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.w,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          CustomHeaderFilter(),
          SizedBox(
            height: 16.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: LIST_CAR_CATEGORY
                .map<Widget>((filter) => buildItem(filter,
                    context: context, isSelected: filter == value))
                .toList(),
          ),
          // SizedBox(height: 16.0.w),
        ],
      ),
    );
  }

  Widget buildItem(int index,
      {required BuildContext context, bool? isSelected}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap(index);
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  AppUtil().carCategory(index),
                  style: isSelected!
                      ? Style().noteStyleRegular
                      : Style()
                          .noteStyleRegular
                          .copyWith(color: context.theme.hintColor),
                ),
              ),
              isSelected
                  ? Icon(
                      Icons.check_circle_outline_sharp,
                      color: context.theme.primaryColorLight,
                    )
                  : const SizedBox(),
            ],
          ),
          SizedBox(
            height: 12.w,
          )
        ],
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final String? sub;
  final Widget? image;

  final GestureTapCallback? onTap;

  TitleWidget({this.title, this.onTap, this.sub, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  title ?? '',
                  style: Style().titleStyle1,
                ),
                SizedBox(
                  width: 8.w,
                ),
                image ?? SizedBox()
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                Text(sub ?? '',
                    style: Style().primaryStyle.copyWith(
                        fontFamily: Style.fontMedium, fontSize: 13.sp)),
                // SizedBox(
                //   width: 8.w,
                // ),
                // Image.asset(
                //   AppSetting.icChevronRight,
                //   color: Get.context!.theme.primaryColor,
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:get/get.dart';

class CustomHeaderWidget extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Color? bgColor;
  final Color? titleColor;
  final VoidCallback? onBackPress;

  CustomHeaderWidget({this.title, this.onBackPress, this.bgColor = Style.transparent, this.titleColor});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0.0,
      centerTitle: true,
      leading: Container(
        margin: EdgeInsets.only(left: 0.w),
        child: IconButton(
            icon: Icon(Icons.arrow_back, color: titleColor ?? Colors.black,),
            onPressed: () {
              if (onBackPress == null) {
                Get.back();
              } else {
                onBackPress!();
              }
            }),
      ),
      title: Text(
        title ?? '',
        style: Style().subtitleStyle1.copyWith(color: titleColor ?? Colors.black),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

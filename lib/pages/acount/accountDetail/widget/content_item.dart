import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/style.dart';

import 'package:oke_car_flutter/helpers/responsive.dart';

class ContentItem extends StatelessWidget {
  final String? title;
  final String subtitle;
  final String? imageIcon;
  final GestureTapCallback? onTap;

  const ContentItem({
    Key? key,
    this.title,
    required this.subtitle,
    this.imageIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 18.w),
      child: ListTile(
        title: Text(
          title!.tr,
          style: TextStyle(
            fontFamily: Style.fontDemiBold,
            fontSize: 15.sp,
            color: context.textTheme.caption!.color,
          ),
        ),
        subtitle: Container(
          margin: EdgeInsets.only(top: 10.w),
          decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(10.w)),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.w),
          child: Text(subtitle != ''? subtitle : 'Chưa có thông tin', style: Style().subtitleStyle1),
        ),
        onTap: onTap,
      ),
    );
  }
}

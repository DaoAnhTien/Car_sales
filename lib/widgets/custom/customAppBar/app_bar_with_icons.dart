import 'package:flutter/material.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:get/get.dart';

class CustomAppBarWithIcon extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? actionButton;
  final Color? titleColor;
  final VoidCallback? onTitleClick;
  final VoidCallback? onBackPress;
  final Widget? titleWidget;
  final bool? enableBack;
  final bool? centerTitle;
  final double height;

  CustomAppBarWithIcon({
    Key? key,
    this.title,
    this.actionButton,
    this.titleColor,
    this.onTitleClick,
    this.onBackPress,
    this.titleWidget,
    this.enableBack = true,
    this.centerTitle = false,
    this.height = kToolbarHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: height,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      centerTitle: centerTitle!,
      leading: enableBack!
          ? IconButton(
          icon:Icon(
            Icons.arrow_back_ios,

          ),
          onPressed: () {
            if (onBackPress == null) {
              Get.back();
            } else {
              onBackPress!();
            }
          })
          : null,
      title: GestureDetector(
        onTap: onTitleClick ?? () {},
        child: Image.asset(AppSetting.imgLogo),
        // child: Text(
        //   title ?? '',
        //   textAlign: centerTitle! ? TextAlign.center : TextAlign.left,
        //   style: Style().subtitleStyle1,
        //   maxLines: 2,
        // ),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: 0.w),
          child: actionButton ?? SizedBox(),
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

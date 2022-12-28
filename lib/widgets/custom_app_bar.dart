import 'package:oke_car_flutter/values/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/responsive.dart';
class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String? title;
  final Widget? actionButton;
  final Color? titleColor;
  final VoidCallback? onTitleClick;
  final VoidCallback? onBackPress;
  final Widget? titleWidget;
  final bool? enableBack;
  final bool? centerTitle;
  final Color? bgColor;

  CustomAppBar({
    Key? key,
    this.title,
    this.actionButton,
    this.titleColor,
    this.onTitleClick,
    this.onBackPress,
    this.titleWidget,
    this.enableBack = true,
    this.centerTitle = false,
    this.bgColor = Style.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0.0,
      centerTitle: centerTitle!,
      leading: enableBack!
          ? IconButton(
              icon: Icon(Icons.arrow_back,color: titleColor ?? Colors.black,),
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
        child: Row(
          children: [
            Expanded(
                child: Text(
              title ?? '',
              textAlign: centerTitle! ? TextAlign.center : TextAlign.left,
              style: Style().subtitleStyle1.copyWith(color: titleColor ?? Colors.black,),
              maxLines: 2,
            )),
            SizedBox(width: 10.w),
            titleWidget != null ? titleWidget! : SizedBox(),
          ],
        ),
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
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

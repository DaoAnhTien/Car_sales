import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

class AccountItem extends StatelessWidget {
  final BuildContext context;
  final String title;
  final Widget icon;
  final GestureTapCallback? onClick;
  final bool? isHighlight;

  const AccountItem({
    Key? key,
    required this.context,
    required this.title,
    required this.icon,
    this.onClick,
    this.isHighlight = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 16.w),
        color: context.theme.backgroundColor,
        child: Row(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            SizedBox(
              width: 12.w,
            ),
            Expanded(
              child: Text(
                title.tr,
                style: Style().bodyStyle3,
              ),
            ),
            isHighlight == true
                ? Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: CircleAvatar(
                backgroundColor: context.theme.primaryColorDark,
                radius: 6.0.w,
              ),
            )
                : const SizedBox(),
            Image.asset(
              AppSetting.ic_arrow_right,
              color: context.textTheme.caption!.color,
            ),
          ],
        ),
      ),
      onTap: onClick,
    );
  }
}

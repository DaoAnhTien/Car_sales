import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/values/style.dart';

class CustomButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final GestureTapCallback onTap;

  CustomButton({this.isSelected = false, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.w)),
            border: Border.all(
              color: isSelected
                  ? context.theme.primaryColorDark
                  : context.theme.hintColor,
            ),
            color: isSelected
                ? context.theme.colorScheme.secondary
                : context.theme.hintColor.withOpacity(0.5)),
        child: Text(
          text.tr,
          textAlign: TextAlign.center,
          style: Style().bodyStyle1,
        ),
      ),
    );
  }
}

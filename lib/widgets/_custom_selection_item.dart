import 'package:flutter/material.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/widgets/_padding_text.dart';

class CustomSelectionItem extends StatelessWidget {
  final String? title;
  final bool? isForList;
  final double? height;
  final AlignmentGeometry? alignment;
  final String? fontFamily;
  final double? fontSize;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final MainAxisAlignment? mainAxisAlignment;
  final BoxDecoration? decoration;

  const CustomSelectionItem({
    Key? key,
    this.title,
    this.isForList = true,
    this.height = 60,
    this.alignment = Alignment.center,
    this.fontFamily = Style.fontRegular,
    this.fontSize = 14,
    this.textColor = Style.textWhiteColor,
    this.backgroundColor = Style.appBackgroundColor,
    this.padding = const EdgeInsets.all(10),
    this.margin = EdgeInsets.zero,
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.decoration = const BoxDecoration(color: Style.appBackgroundColor),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: isForList!
          ? Padding(
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: alignment,
                child: PaddingText(
                  text: title,
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
              padding: padding!,
            )
          : Container(
              margin: margin,
              padding: padding,
              decoration: decoration,
              child: Row(
                mainAxisAlignment: mainAxisAlignment!,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      alignment: alignment,
                      child: PaddingText(
                        text: title,
                        fontFamily: fontFamily,
                        fontSize: fontSize,
                        color: textColor,
                      ),
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Image.asset(
                  //     AppSetting.icChevronDown,
                  //     width: 11.w,
                  //     height: 5.w,
                  //     fit: BoxFit.scaleDown,
                  //     color: textColor,
                  //   ),
                  // )
                ],
              ),
            ),
    );
  }
}

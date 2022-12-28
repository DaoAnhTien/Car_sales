import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/constants/app_constant.dart';
import 'package:oke_car_flutter/values/style.dart';

import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import '_padding_text.dart';

class RadiusButton extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final String? fontFamily;
  final Color? textColor;
  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Image? preIcon;
  final EdgeInsetsGeometry? preIconPadding;
  final Image? postIcon;
  final EdgeInsetsGeometry? innerPadding;
  final EdgeInsetsGeometry? outsidePadding;
  final String? soundPath;
  final bool? isLocal;
  final GestureTapCallback? onTap;
  final double? radius;
  final String? borderRadiusEdge;
  final bool? isFullWidth;
  final bool? avoidMax;
  final MainAxisAlignment? mainAxisAlignment;
  final List<BoxShadow>? shadow;
  final Border? border;
  final double? maxWidth;
  final bool? isDisable;
  final bool? isLoading;
  final double? indicatorSize;
  final int? maxLines;
  final int? fixedLines;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final double? opacity;

  RadiusButton(
      {this.text,
      this.fontSize,
      this.fontFamily = Style.fontRegular,
      this.textColor = Style.btnDefaultTextColor,
      this.backgroundColor = Style.btnDefaultBgColor,
      this.backgroundGradient,
      this.shadow,
      this.border,
      this.radius = 25,
      this.borderRadiusEdge = '',
      this.preIcon,
      this.preIconPadding = const EdgeInsets.only(right: 3),
      this.postIcon,
      this.soundPath,
      this.isLocal = false,
      this.isFullWidth = false,
      this.avoidMax = false,
      this.isDisable = false,
      this.isLoading = false,
      this.indicatorSize = 24,
      this.onTap,
      this.maxWidth = 300,
      this.maxLines = 1,
      this.fixedLines,
      this.overflow,
      this.letterSpacing,
      this.opacity = 1.0,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.innerPadding =
          const EdgeInsets.only(top: 18, bottom: 18, left: 20, right: 20),
      this.outsidePadding =
          const EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0)});

  @override
  Widget build(BuildContext context) {
    return soundPath != null
        ? IgnorePointer(
            ignoring: isLoading!,
            child: Opacity(
              opacity: isDisable! ? 0.25 : 1.0,
              child: GestureDetector(
                child: Padding(
                  padding: outsidePadding!,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        constraints: avoidMax!
                            ? BoxConstraints()
                            : BoxConstraints(maxWidth: maxWidth!),
                        decoration: BoxDecoration(
                            borderRadius: borderRadiusEdge == BORDER_LEFT
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(radius!),
                                    bottomLeft: Radius.circular(radius!))
                                : borderRadiusEdge == BORDER_RIGHT
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(radius!),
                                        bottomRight: Radius.circular(radius!))
                                    : BorderRadius.circular(radius!),
                            border: border,
                            boxShadow: shadow,
                            gradient: isDisable! ? null : backgroundGradient,
                            color: isDisable! ? Colors.white : backgroundColor),
                        child: Padding(
                          padding: innerPadding!,
                          child: Row(
                            mainAxisSize: isFullWidth!
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            mainAxisAlignment: mainAxisAlignment!,
                            children: <Widget>[
                              preIcon == null
                                  ? SizedBox()
                                  : Padding(
                                      padding: preIconPadding!,
                                      child: preIcon,
                                    ),
                              Flexible(
                                child: PaddingText(
                                  maxLines: maxLines,
                                  overflow: overflow,
                                  text: text,
                                  fontFamily: fontFamily,
                                  fontSize: fontSize == null ? 13.sp : fontSize,
                                  color: isDisable! ? Colors.black : textColor,
                                  textAlign: TextAlign.center,
                                  letterSpacing: letterSpacing == null
                                      ? -0.41.sp
                                      : letterSpacing,
                                ),
                              ),
                              postIcon == null
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: postIcon,
                                    )
                            ].where((o) => o != SizedBox()).toList(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                onTap: isDisable! ? null : onTap,
              ),
            ),
          )
        : IgnorePointer(
            ignoring: isLoading!,
            child: Opacity(
              opacity: isDisable! ? 0.56 : 1.0,
              child: GestureDetector(
                child: Padding(
                  padding: outsidePadding!,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        constraints: avoidMax!
                            ? BoxConstraints()
                            : BoxConstraints(maxWidth: maxWidth!),
                        decoration: BoxDecoration(
                            borderRadius: borderRadiusEdge == BORDER_LEFT
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(radius!),
                                    bottomLeft: Radius.circular(radius!))
                                : borderRadiusEdge == BORDER_RIGHT
                                    ? BorderRadius.only(
                                        topRight: Radius.circular(radius!),
                                        bottomRight: Radius.circular(radius!))
                                    : BorderRadius.circular(radius!),
                            border: border,
                            boxShadow: shadow,
                            gradient: isDisable! ? null : backgroundGradient,
                            color: isDisable!
                                ? backgroundColor!.withOpacity(0.5)
                                : backgroundColor),
                        child: Padding(
                          padding: innerPadding!,
                          child: Row(
                            mainAxisSize: isFullWidth!
                                ? MainAxisSize.max
                                : MainAxisSize.min,
                            mainAxisAlignment: mainAxisAlignment!,
                            children: <Widget>[
                              preIcon == null
                                  ? SizedBox()
                                  : Padding(
                                      padding: preIconPadding!,
                                      child: preIcon,
                                    ),
                              Flexible(
                                child: isLoading!
                                    ? Container(
                                        child: SpinKitThreeBounce(
                                          color: textColor,
                                          size: indicatorSize!,
                                        ),
                                      )
                                    : PaddingText(
                                        maxLines: maxLines,
                                        overflow: overflow,
                                        text: text,
                                        fontFamily: fontFamily,
                                        fontSize:
                                            fontSize == null ? 13.sp : fontSize,
                                        color: isDisable!
                                            ? Colors.black
                                            : textColor,
                                        textAlign: TextAlign.center,
                                        letterSpacing: letterSpacing == null
                                            ? -0.41.sp
                                            : letterSpacing,
                                      ),
                              ),
                              postIcon == null
                                  ? SizedBox()
                                  : Padding(
                                      padding: EdgeInsets.only(
                                          left: 3.w, right: 13.w),
                                      child: postIcon,
                                    )
                            ].where((o) => o != SizedBox()).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  if (onTap != null && !isDisable!) {
                    onTap!();
                  }
                },
              ),
            ),
          );
  }
}

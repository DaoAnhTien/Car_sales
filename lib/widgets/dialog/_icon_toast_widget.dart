import 'package:flutter/material.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';

import '../_padding_text.dart';

class IconToastWidget extends StatefulWidget {
  final Key? key;
  final Color? backgroundColor;
  final Color? color;
  final Widget? icon;
  final String? message;
  final String? fontFamily;
  final double? fontSize;
  final double? height;
  final double? width;
  final String? assetName;
  final EdgeInsetsGeometry? padding;

  IconToastWidget({
    this.key,
    this.backgroundColor,
    this.color,
    this.icon,
    this.message,
    this.fontFamily,
    this.fontSize,
    this.height,
    this.width,
    @required this.assetName,
    this.padding,
  }) : super(key: key);

  factory IconToastWidget.fail(
          {String? msg, EdgeInsetsGeometry? contentPadding}) =>
      IconToastWidget(
        message: msg,
        assetName: 'assets/ic_fail.png',
        backgroundColor: Color(0xf0f5222d),
        color: Style.textWhiteColor,
        icon: Icon(
          Icons.info_outline,
          size: 16.w,
          color: Style.textWhiteColor,
        ),
        padding: contentPadding,
      );

  factory IconToastWidget.warning(
          {String? msg, EdgeInsetsGeometry? contentPadding}) =>
      IconToastWidget(
        message: msg,
        assetName: 'assets/ic_fail.png',
        backgroundColor: Color(0xf0ffec3d),
        color: Style.blackColor,
        icon: Icon(
          Icons.info_outline,
          size: 16.w,
          color: Style.blackColor,
        ),
        padding: contentPadding,
      );

  factory IconToastWidget.success(
          {String? msg, EdgeInsetsGeometry? contentPadding}) =>
      IconToastWidget(
        message: msg,
        assetName: 'assets/ic_success.png',
        backgroundColor: Color(0xf0a0d911),
        color: Style.textWhiteColor,
        icon: Icon(
          Icons.check_circle_outline,
          size: 16.w,
          color: Style.textWhiteColor,
        ),
        padding: contentPadding,
      );

  @override
  State<StatefulWidget> createState() {
    return _IconToastWidgetState();
  }
}

class _IconToastWidgetState extends State<IconToastWidget>
    with TickerProviderStateMixin<IconToastWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Material(
      color: Colors.transparent,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.w),
          padding: widget.padding ??
              EdgeInsets.symmetric(vertical: 15.w, horizontal: 15.w),
          decoration: ShapeDecoration(
            color: widget.backgroundColor ?? const Color(0x9F000000),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 0.0),
                child: widget.icon,
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: PaddingText(
                    text: widget.message,
                    fontFamily: widget.fontFamily,
                    fontSize: widget.fontSize,
                    color: widget.color,
                  ),
                ),
              ),
            ],
          )),
    );

    return content;
  }
}

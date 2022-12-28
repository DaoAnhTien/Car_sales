import 'package:oke_car_flutter/utils/object_util.dart';
import 'package:oke_car_flutter/utils/screen_util.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:flutter/material.dart';
import 'package:oke_car_flutter/utils/screen_util.dart';

import '../_padding_text.dart';
import '../_radius_button.dart';

class CustomDialog extends StatelessWidget {
  final String? title, subTitle, description, buttonText;
  final Widget? image;
  final Function? onButtonClick;
  final ScreenUtil sI = ScreenUtil.instance;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.subTitle,
    this.onButtonClick,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.only(
            top: sI.setScale(20),
            bottom: sI.setScale(20),
            right: sI.setScale(30),
            left: sI.setScale(30)),
        margin: EdgeInsets.only(),
        decoration: new BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: const Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // To make the card compact
          children: <Widget>[
            ObjectUtil.isNotEmpty(title)
                ? PaddingText(
                    text: title!.toUpperCase(),
                    fontSize: sI.setSp(20),
                    color: Style.dialogDescriptionTextColor,
                    textAlign: TextAlign.center,
                    fontFamily: Style.fontBold,
                  )
                : Container(),
            image == null
                ? Container()
                : Container(
                    padding: EdgeInsets.only(top: sI.setScale(10)),
                    child: image,
                  ),
            ObjectUtil.isNotEmpty(subTitle)
                ? PaddingText(
                    padding: EdgeInsets.only(top: sI.setScale(10)),
                    text: subTitle,
                    fontSize: sI.setSp(20),
                    color: Style.dialogDescriptionTextColor,
                    textAlign: TextAlign.center,
                    fontFamily: Style.fontDemiBold,
                  )
                : Container(),
            PaddingText(
              padding: EdgeInsets.only(top: sI.setScale(5)),
              text: description,
              fontSize: sI.setSp(14),
              color: Style.dialogDescriptionTextColor,
              textAlign: TextAlign.center,
              fontFamily: Style.fontRegular,
            ),
            Align(
              alignment: Alignment.center,
              child: RadiusButton(
                isFullWidth: true,
                maxWidth: sI.setScale(160),
                innerPadding: EdgeInsets.only(
                    top: sI.setScale(12), bottom: sI.setScale(12)),
                outsidePadding: EdgeInsets.only(top: sI.setScale(20)),
                text: buttonText,
                fontSize: sI.setSp(14),
                fontFamily: Style.fontDemiBold,
                backgroundColor: Style.dialogButtonYesBgColor,
                shadow: <BoxShadow>[
                  BoxShadow(
                      color: Style.dialogButtonShadowColor,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 20),
                ],
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  if (onButtonClick != null) {
                    onButtonClick!();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

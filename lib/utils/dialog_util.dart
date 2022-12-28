import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

import 'package:oke_car_flutter/utils/app_util.dart';
import 'package:oke_car_flutter/values/setting.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';
import 'package:oke_car_flutter/widgets/_padding_text.dart';
import 'package:oke_car_flutter/widgets/_radius_button.dart';
import 'package:oke_car_flutter/widgets/custom/animation/custom_animation_toast.dart';
import 'package:oke_car_flutter/widgets/dialog/_custom_dialog.dart';
import 'package:oke_car_flutter/widgets/dialog/_error_toast.dart';
import 'package:oke_car_flutter/widgets/dialog/_icon_toast_widget.dart';
import 'package:oke_car_flutter/widgets/dialog/_success_toast.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';

import 'date_util.dart';


class DialogUtil {
  static DialogUtil instance = new DialogUtil();

  DialogUtil();

  static showProgressDialog(BuildContext context) {
    showDialog<dynamic>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: SizedBox(
                child: new CircularProgressIndicator(),
                height: 30.0,
                width: 30.0,
              ),
            ),
          );
        });
  }

  static showToastMessage(String description,
      {VoidCallback? onDismiss, bool isTop = true, int duration = 5}) {
    showToast(
      description,
      context: Get.overlayContext,
      textStyle: TextStyle(
        fontFamily: Style.fontMedium,
        fontSize: 14.w,
        color: Style.textWhiteColor,
      ),
      toastHorizontalMargin: 30.w,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration),
      //Animation duration   animDuration * 2 <= duration
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      onDismiss: onDismiss,
    );
  }

  static showSuccessMessage(String description,
      {VoidCallback? onDismiss, bool isTop = true, int duration = 5}) {
    showToastWidget(
      IconToastWidget.success(msg: description),
      context: Get.overlayContext,
      position: isTop ? StyledToastPosition.top : StyledToastPosition.bottom,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      onDismiss: onDismiss,
    );
  }

  static showErrorMessage(String description,
      {VoidCallback? onDismiss, bool isTop = true, int duration = 5}) {
    showToastWidget(
      IconToastWidget.fail(msg: description),
      context: Get.overlayContext,
      position: isTop ? StyledToastPosition.top : StyledToastPosition.bottom,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      onDismiss: onDismiss,
    );
  }

  static showWarningMessage(String description,
      {VoidCallback? onDismiss, bool isTop = true, int duration = 5}) {
    showToastWidget(
      IconToastWidget.warning(msg: description),
      context: Get.overlayContext,
      position: isTop ? StyledToastPosition.top : StyledToastPosition.bottom,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
      onDismiss: onDismiss,
    );
  }

  static showSuccessToast(String description) {
    showOverlay((context, t) {
      return CustomAnimationToast(value: t, content: SuccessToast(description));
    }, key: ValueKey('successfully'), curve: Curves.decelerate);
  }

  static void showErrorToast(String description) {
    showOverlay((context, t) {
      return CustomAnimationToast(value: t, content: ErrorToast(description));
    }, key: ValueKey('error'), curve: Curves.decelerate);
  }

  static showAnimatedDialogBase(
      BuildContext context,
      String? title,
      String? description,
      String? buttonText,
      Function? onClick,
      bool clickOutside,
      String? image,
      double? imageWidth,
      double? imageHeight,
      String? subTitle,
      Function? onDismiss) async {
    await showDialog(
      barrierDismissible: clickOutside,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        subTitle: subTitle,
        description: description,
        buttonText: buttonText,
        onButtonClick: onClick,
        image: image == null
            ? null
            : Lottie.asset(
          image,
          width: imageWidth,
          height: imageHeight,
          fit: BoxFit.cover,
          repeat: false,
        ),
      ),
    );
    if (onDismiss != null) {
      onDismiss();
    }
  }

  static showAnimatedSuccessDialog(BuildContext context, String description,
      {String? subTitle,
        double? imageWidth,
        double? imageHeight,
        Function? onDismiss}) {
    showAnimatedDialogBase(
        context,
        'dialog_title_success'.tr,
        description,
        'dialog_btn_ok'.tr,
        null,
        true,
        'assets/lotties/success_green.json',
        imageWidth,
        imageHeight,
        subTitle,
        onDismiss);
  }

  static showConfirmDialog(
      BuildContext context, {
        bool isForeUpdate = false,
        String? title,
        String? description,
        String? image,
        String? button,
        Function? action,
        Function? laterAction,
      }) {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Material(
                    color: Style.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          child: image == null
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: true,
                          )
                              : image == AppSetting.icAccountFilled
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: false,
                          )
                              : Image.asset(
                            image,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16.w, bottom: 24.w, left: 16.w, right: 16.w),
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Style().titleStyle1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.w, left: 25.w, right: 25.w),
                          child: Text(
                            description ?? '',
                            textAlign: TextAlign.center,
                            style: Style().noteStyle1,
                          ),
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 5.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: button ?? 'dialog_btn_ok'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.colorScheme.secondary,
                          textColor: Style.textPrimaryColor,
                          onTap: () {
                            if (!isForeUpdate) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            if (action != null) {
                              action();
                            }
                          },
                        ),
                        isForeUpdate
                            ? SizedBox(height: 20.w)
                            : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              'later'.tr,
                              textAlign: TextAlign.center,
                              style: Style().hintStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }

  static showConfirmDualActionDialog(
      BuildContext context, {
        bool isRequired = false,
        String? title,
        String? description,
        String? image,
        String? mainButton,
        String? subButton,
        Function? mainAction,
        Function? subAction,
      }) {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Material(
                    color: Style.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          child: image == null
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: true,
                          )
                              : image == AppSetting.icAccountFilled
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: false,
                          )
                              : Image.asset(
                            image,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16.w, bottom: 24.w, left: 16.w, right: 16.w),
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Style().titleStyle1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.w, left: 25.w, right: 25.w),
                          child: Text(
                            description ?? '',
                            textAlign: TextAlign.center,
                            style: Style().noteStyle1,
                          ),
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 5.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: mainButton ?? 'dialog_btn_ok'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.colorScheme.secondary,
                          textColor: Style.textPrimaryColor,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            if (mainAction != null) {
                              mainAction();
                            }
                          },
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 32.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: subButton ?? 'later'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.cardColor,
                          textColor: context.textTheme.headline1!.color,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pop();
                            if (subAction != null) {
                              subAction();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: !isRequired,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }



  static showHelpDialog(Widget child) {
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.6),
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Container(
                    padding: EdgeInsets.all(20.0.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0.w)),
                        color: Color.fromRGBO(0, 0, 0, 0.6)),
                    child: child,
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: true,
        context: Get.context!,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }

  static showAnimatedMaintainDialog(
      BuildContext context, StreamController<DateTime> event,
      {int? expectedTime, Function? action}) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => WillPopScope(
          onWillPop: () {
            DialogUtil.showConfirmDialog(Get.context!,
                title: 'confirm'.tr,
                description: 'maintain_exit_app'.tr, action: () async {
                  if (action != null) {
                    action();
                  }
                });
            return Future.value(false);
          },
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.only(
                  top: 20.w, bottom: 20.w, right: 30.w, left: 30.w),
              margin: EdgeInsets.only(),
              decoration: new BoxDecoration(
                color: context.theme.backgroundColor,
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
                  Text(
                    'maintain_title'.tr,
                    style: Style().titleStyle2,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10.w),
                    child: Lottie.asset(
                      'assets/lotties/maintain.json',
                      fit: BoxFit.cover,
                      repeat: true,
                    ),
                  ),
                  StreamBuilder<DateTime>(
                      stream: event.stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<DateTime> snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                            alignment: Alignment.center,
                            child: RadiusButton(
                              isFullWidth: true,
                              maxWidth: double.infinity,
                              innerPadding:
                              EdgeInsets.only(top: 12.w, bottom: 12.w),
                              outsidePadding: EdgeInsets.only(top: 20.w),
                              text:
                              '${DateUtil.countingTime(snapshot.data!.millisecondsSinceEpoch, expectedTime!)}',
                              fontSize: 14.sp,
                              fontFamily: Style.fontDemiBold,
                              backgroundColor: Style.dialogButtonYesBgColor,
                              shadow: <BoxShadow>[
                                BoxShadow(
                                    color: Style.dialogButtonShadowColor,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 20),
                              ],
                              onTap: () {},
                            ),
                          );
                        }
                        return SizedBox();
                      }),
                ],
              ),
            ),
          ),
        ));
  }

  static showConfirmRef(BuildContext context,
      {String? code, String? image, Function? action}) {
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(20.w),
                          child: Image.asset(
                            AppSetting.icAccountFilled,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                      Container(
                        child: Image.asset(
                          AppSetting.icAccountFilled,
                          width: 150.w,
                          height: 150.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      PaddingText(
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                        text: 'accept_ref_title'.tr,
                        fontSize: 18.sp,
                        fontFamily: Style.fontDemiBold,
                        color: context.textTheme.headline1!.color,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.w,
                          horizontal: 20.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: context.theme.cardColor,
                        ),
                        child: PaddingText(
                          textAlign: TextAlign.center,
                          text: code,
                          fontSize: 18.sp,
                          fontFamily: Style.fontDemiBold,
                          color: context.theme.primaryColor,
                        ),
                      ),
                      PaddingText(
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(
                            top: 10.w, bottom: 20.w, left: 25.w, right: 25.w),
                        text: 'accept_ref_content'.tr,
                        fontSize: 14.sp,
                        fontFamily: Style.fontRegular,
                        color: Theme.of(context).textTheme.bodyText2!.color,
                      ),
                      RadiusButton(
                        isFullWidth: true,
                        maxWidth: double.infinity,
                        radius: 16,
                        outsidePadding: EdgeInsets.only(
                          top: 14.w,
                          bottom: 5.w,
                          left: 25.w,
                          right: 25.w,
                        ),
                        innerPadding: EdgeInsets.only(
                          top: 18.w,
                          bottom: 18.w,
                          left: 5.w,
                          right: 5.w,
                        ),
                        indicatorSize: 24.w,
                        text: 'dialog_btn_ok'.tr,
                        fontFamily: Style.fontBold,
                        fontSize: 16.sp,
                        backgroundColor: context.theme.primaryColor,
                        textColor: context.textTheme.button!.color,
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                          if (action != null) {
                            action();
                          }
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        child: Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          padding: EdgeInsets.all(25.w),
                          child: PaddingText(
                            textAlign: TextAlign.center,
                            text: 'dialog_btn_cancel'.tr,
                            color: context.theme.primaryColor,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        context: context,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }



  static dialogRateAndReviewApp(BuildContext buildContext) {
    TextFormField(
      autofocus: true,
      onFieldSubmitted: (_) =>
          Navigator.of(buildContext, rootNavigator: true).pop(),
      maxLines: 3,
      decoration: InputDecoration(
        hintText: 'Write Comment...',
        border: OutlineInputBorder(),
      ),
      // onChanged: (comment) => setState(() => this.comment = comment),
    );
  }

  static showSuccessDialog(
      BuildContext context, {
        bool isForeUpdate = false,
        bool isBackHome = false,
        String? title,
        String? description,
        String? image,
        String? backText,
        Function? action,
        Function? backAction,
      }) {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20.w,
                ),
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Material(
                    color: Style.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          child: image == null
                              ? Lottie.asset(
                            AppSetting.lottieSuccess,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: false,
                          )
                              : Image.asset(
                            image,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Style().titleStyle1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 20.w, left: 25.w, right: 25.w),
                          child: Text(
                            description ?? '',
                            textAlign: TextAlign.center,
                            style: Style().hintStyle,
                          ),
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 16.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: 'start_deposit'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.primaryColor,
                          textColor: context.textTheme.button!.color,
                          onTap: () {
                            if (!isForeUpdate) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            if (action != null) {
                              action();
                            }
                          },
                        ),
                        isBackHome
                            ? RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            bottom: 16.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: backText ?? 'back'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.cardColor,
                          textColor: context.textTheme.headline1!.color,
                          onTap: () {
                            if (!isForeUpdate) {
                              Navigator.of(context, rootNavigator: true)
                                  .pop();
                            }
                            if (backAction != null) {
                              backAction();
                            }
                          },
                        )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }



  static showAlertDialog(BuildContext context,
      {bool isForeUpdate = false,
        String? title,
        String? description,
        String? penaltyFee,
        String? image,
        Widget? child,
        Function? action}) {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 40.w, horizontal: 24.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Material(
                    color: Style.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          child: image == null
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: true,
                          )
                              : image == AppSetting.icAccountFilled
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: false,
                          )
                              : Image.asset(
                            image,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 16.w, left: 35.w, right: 35.w),
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Style().titleStyle1,
                          ),
                        ),
                        SizedBox(height: 20.w),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: 8.w, bottom: 16.w, left: 16.w, right: 16.w),
                        //   child: Text(
                        //     'warning_cancel_earn'.tr,
                        //     textAlign: TextAlign.center,
                        //     style: Style().textStyle(
                        //       color: context.textTheme.caption!.color,
                        //       fontFamily: Style.fontRegular,
                        //       fontSize: 17.sp,
                        //       letterSpacing: -0.41.sp,
                        //     ),
                        //   ),
                        // ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 16.w),
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.w, vertical: 12.w),
                            decoration: BoxDecoration(
                                color: context.theme.hoverColor,
                                borderRadius: BorderRadius.circular(10.w)),
                            child: child),
                        SizedBox(
                          height: 30.w,
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 5.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: 'dialog_btn_ok'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.primaryColor,
                          textColor: context.textTheme.button!.color,
                          onTap: () {
                            if (!isForeUpdate) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            if (action != null) {
                              action();
                            }
                          },
                        ),
                        isForeUpdate
                            ? SizedBox(height: 20.w)
                            : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              'later'.tr,
                              textAlign: TextAlign.center,
                              style: Style().hintStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }

  static showConfirmDialogSaving(BuildContext context,
      {bool isForeUpdate = false,
        String? title,
        String? description,
        String? image,
        double? rateYear,
        Function? action}) {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Center(
              child: Container(
                margin: EdgeInsets.all(40.w),
                decoration: BoxDecoration(
                  color: context.theme.backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Opacity(
                  opacity: a1.value,
                  child: Material(
                    color: Style.transparent,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 20.w),
                          child: image == null
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: true,
                          )
                              : image == AppSetting.icAccountFilled
                              ? Lottie.asset(
                            AppSetting.lottieConfirm,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.scaleDown,
                            repeat: false,
                          )
                              : Image.asset(
                            image,
                            width: 72.w,
                            height: 72.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 24.w, bottom: 10.w),
                          child: Text(
                            title ?? '',
                            textAlign: TextAlign.center,
                            style: Style().titleStyle1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 20,
                            left: 8,
                            right: 8,
                          ),
                          child: Text(
                            '$description'.trArgs([
                              AppUtil.formatNumber(rateYear ?? 0,
                                  fractionDigits: 2) +
                                  'rate_year'.tr
                            ]),
                            textAlign: TextAlign.center,
                            style: Style().subtitleStyle2,
                          ),
                        ),
                        RadiusButton(
                          isFullWidth: true,
                          maxWidth: double.infinity,
                          radius: 10,
                          outsidePadding: EdgeInsets.only(
                            top: 14.w,
                            bottom: 5.w,
                            left: 25.w,
                            right: 25.w,
                          ),
                          innerPadding: EdgeInsets.only(
                            top: 16.w,
                            bottom: 16.w,
                            left: 5.w,
                            right: 5.w,
                          ),
                          indicatorSize: 24.w,
                          text: 'dialog_btn_ok'.tr,
                          fontFamily: Style.fontBold,
                          fontSize: 17.sp,
                          backgroundColor: context.theme.primaryColor,
                          textColor: context.textTheme.button!.color,
                          onTap: () {
                            if (!isForeUpdate) {
                              Navigator.of(context, rootNavigator: true).pop();
                            }
                            if (action != null) {
                              action();
                            }
                          },
                        ),
                        isForeUpdate
                            ? SizedBox(height: 20.w)
                            : GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            alignment: Alignment.center,
                            width: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              'later'.tr,
                              textAlign: TextAlign.center,
                              style: Style().hintStyle,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }

  static showErrorNetworkDialog({Function? action}) async {
    Get.generalDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return WillPopScope(
            onWillPop: () {
              DialogUtil.showConfirmDialog(Get.context!,
                  title: 'confirm'.tr,
                  description: 'maintain_exit_app'.tr, action: () async {
                    if (action != null) {
                      action();
                    }
                  });
              return Future.value(false);
            },
            child: Transform.scale(
              scale: a1.value,
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(40.w),
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: context.theme.backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Opacity(
                    opacity: a1.value,
                    child: Material(
                      color: Style.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'error_network'.tr,
                            textAlign: TextAlign.center,
                            style: Style().subtitleStyle1,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10.w),
                            child: Lottie.asset(
                              'assets/lotties/maintain.json',
                              fit: BoxFit.cover,
                              repeat: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierLabel: '',
        barrierDismissible: false,
        pageBuilder: (context, animation1, animation2) => SizedBox());
  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oke_car_flutter/helpers/responsive.dart';

class Style {
  Style();

  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColorLight: const  Color.fromRGBO(24, 90, 219, 1.0),
    primaryColorDark: const Color(0xfffd0000),
    primaryColor: const Color(0xff0DA54B),
    colorScheme: ColorScheme.highContrastLight().copyWith(
      secondary: const Color(0xffffc947),
      onSecondary: const Color(0xff000000).withOpacity(0.35),
    ),
    backgroundColor: const Color(0xffffffff),
    scaffoldBackgroundColor: const Color(0xffffffff),
    bottomAppBarColor: const Color.fromRGBO(247, 247, 247, 0.8),
    secondaryHeaderColor: const Color(0xfff2f2f2),
    dividerColor: const Color(0xffD9D9D9).withOpacity(0.2),
    focusColor: const Color(0xffFFC947),
    cardColor: const Color(0xffF5F8FD),
    indicatorColor: const Color(0xff000000),
    hoverColor: const Color.fromRGBO(253, 244, 236, 1.0),
    selectedRowColor: ThemeData.light().selectedRowColor,
    unselectedWidgetColor: const Color(0xff9DA3AC),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: ThemeData.light().textSelectionTheme.selectionColor,
      cursorColor: ThemeData.light().textSelectionTheme.cursorColor,
      selectionHandleColor:
          ThemeData.light().textSelectionTheme.selectionHandleColor,
    ),
    dialogBackgroundColor: ThemeData.dark().dialogBackgroundColor,
    highlightColor: const Color.fromRGBO(240, 148, 72, 1.0),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xff0A1931)),
      headline2: TextStyle(color: const Color(0xff185ADB)),
      headline3: TextStyle(color: const Color(0xffc2c2c2)),
      headline4: TextStyle(color: const Color.fromRGBO(254, 237, 237, 1.0)),
      headline5: TextStyle(color: Colors.black),
      headline6: TextStyle(color: Colors.black),
      subtitle2: TextStyle(color: const Color.fromRGBO(7, 6, 41, 1.0)),
      subtitle1: TextStyle(color: const Color(0xff08142D)),
      button: TextStyle(color: const Color(0xffF7F7FA)),
      caption: TextStyle(color: const Color(0xff9DA3AC)),
      bodyText1: TextStyle(color: const Color(0xff0A1931)),
      bodyText2: TextStyle(color: const Color(0xff6e6e6e)),
      overline: TextStyle(color: const Color(0xffF5F8FD)),
    ),
    buttonTheme: ButtonThemeData().copyWith(
      buttonColor: const Color(0xfffa6400),
      highlightColor: const Color(0xff000000).withOpacity(0.25),
    ),
    iconTheme: IconThemeData.fallback().copyWith(
      color: const Color(0xff0a1931),
    ),
    appBarTheme: AppBarTheme(
      color: const Color(0xff0a1931),
      iconTheme: const IconThemeData.fallback().copyWith(
        color: const Color(0xff0a1931),
      ),
      actionsIconTheme: const IconThemeData.fallback().copyWith(
        color: const Color.fromRGBO(247, 247, 247, 1.0),
      ),
    ),
    dialogTheme: DialogTheme().copyWith(
      backgroundColor: const Color(0xffffffff),
      titleTextStyle: TextStyle(color: const Color(0xff0A1931)),
      contentTextStyle: TextStyle(color: const Color(0xff0A1931)),
    ),
    shadowColor: const Color.fromRGBO(13, 63, 103, 0.1),
    disabledColor: const Color(0xff9DA3AC).withOpacity(0.3),
    hintColor: const Color(0xff9DA3AC),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromRGBO(24, 90, 219, 1.0),
    primaryColorLight: const Color.fromRGBO(68, 198, 98, 1.0),
    primaryColorDark: const Color.fromRGBO(242, 58, 58, 1.0),
    colorScheme: ColorScheme.highContrastDark().copyWith(
      secondary: const Color(0xffffc947),
      onSecondary: const Color.fromRGBO(179, 179, 179, 1.0),
    ),
    backgroundColor: Color(0xff0A1931),
    bottomAppBarColor: const Color.fromRGBO(10, 25, 49, 0.8),
    cardColor: const Color.fromRGBO(14, 34, 68, 1.0),
    disabledColor: const Color(0xff455a82),
    indicatorColor: const Color.fromRGBO(255, 255, 255, 1.0),
    hoverColor: const Color.fromRGBO(64, 53, 44, 1.0),
    selectedRowColor: ThemeData.dark().selectedRowColor,
    unselectedWidgetColor: const Color.fromRGBO(110, 135, 172, 1.0),
    secondaryHeaderColor: ThemeData.dark().secondaryHeaderColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: ThemeData.dark().textSelectionTheme.selectionColor,
      cursorColor: ThemeData.dark().textSelectionTheme.cursorColor,
      selectionHandleColor:
          ThemeData.dark().textSelectionTheme.selectionHandleColor,
    ),
    dialogBackgroundColor: ThemeData.dark().dialogBackgroundColor,
    hintColor: const Color(0xff9DA3AC),
    errorColor: ThemeData.dark().errorColor,
    toggleableActiveColor: ThemeData.dark().toggleableActiveColor,
    highlightColor: Color.fromRGBO(240, 148, 72, 1.0),
    textTheme: TextTheme(
      headline1: TextStyle(color: const Color(0xffF7F7FA)),
      headline2: TextStyle(color: const Color.fromRGBO(255, 255, 255, 1.0)),
      headline3: TextStyle(color: const Color.fromRGBO(19, 52, 35, 1.0)),
      headline4: TextStyle(color: const Color.fromRGBO(79, 43, 43, 1.0)),
      headline5: TextStyle(color: const Color.fromRGBO(72, 80, 159, 1.0)),
      headline6: TextStyle(
        color: Colors.white,
        fontFamily: fontDemiBold,
      ),
      subtitle2: TextStyle(color: const Color.fromRGBO(247, 247, 247, 1.0)),
      subtitle1: TextStyle(color: const Color.fromRGBO(254, 254, 254, 1.0)),
      button: TextStyle(color: const Color.fromRGBO(247, 247, 254, 1.0)),
      caption: TextStyle(color: const Color(0xff9DA3AC)),
      bodyText1: TextStyle(color: const Color.fromRGBO(247, 247, 247, 1.0)),
      bodyText2: TextStyle(color: const Color.fromRGBO(216, 216, 216, 1.0)),
      overline: TextStyle(color: const Color.fromRGBO(7, 17, 34, 1.0)),
    ),
    buttonTheme: ButtonThemeData().copyWith(
      buttonColor: const Color.fromRGBO(24, 90, 219, 1.0),
      highlightColor: const Color(0xff000000).withOpacity(0.25),
      disabledColor: const Color.fromRGBO(30, 31, 32, 1.0),
    ),
    iconTheme: IconThemeData.fallback().copyWith(
      color: const Color.fromRGBO(255, 255, 255, 1.0),
    ),
    appBarTheme: AppBarTheme(
      color: const Color(0xffededed),
      iconTheme: const IconThemeData.fallback().copyWith(
        color: const Color.fromRGBO(247, 247, 247, 1.0),
      ),
      actionsIconTheme: const IconThemeData.fallback().copyWith(
        color: const Color.fromRGBO(247, 247, 247, 1.0),
      ),
    ),
    dialogTheme: DialogTheme().copyWith(
      backgroundColor: const Color.fromRGBO(24, 24, 26, 1.0),
    ),
    shadowColor: const Color.fromRGBO(255, 255, 255, 0.16),
  );

  //Colors
  static const Color textHighLightColor = const Color(0xff0A1931);
  static const Color appBackgroundColor = const Color.fromRGBO(47, 52, 98, 1.0);
  static const Color appSecondBackgroundColor =
      const Color.fromRGBO(30, 31, 32, 0.4);
  static const Color transparent = const Color.fromRGBO(0, 0, 0, 0);
  static const Color transitionBackgroundColor = const Color(0xff000000);
  static const Color pendingColor = const Color.fromRGBO(255, 159, 67, 1.0);
  static const Color failedColor = const Color.fromRGBO(255, 90, 117, 1.0);
  static const Color orangeColor = const Color.fromRGBO(240, 148, 72, 1.0);

  static const Color shareTitleColor = const Color.fromRGBO(255, 191, 0, 1);

  //Loading
  static const Color loadingBgColor = const Color(0xFFFAFBFC);
  static const Color loadingIndicatorColor = const Color(0xFFFFCB2A);

  //Widget
  static const Color btnDefaultTextColor = Colors.white;
  static const Color btnDefaultBgColor = const Color.fromRGBO(0, 159, 212, 1.0);
  static const Color textDefaultColor = Colors.white;
  static const Color textPrimaryColor = const Color(0xff0A1931);
  static const Color textWhiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color whiteColor = Colors.white;
  static const Color lineDivideColor =
      const Color.fromRGBO(117, 117, 117, 0.08);

  static const Color textFieldDefaultTextColor = Colors.white;
  static const Color textFieldPlaceholderDefaultTextColor =
      const Color.fromRGBO(117, 117, 117, 1.0);
  static const Color textFieldDefaultBgColor =
      const Color.fromRGBO(30, 31, 32, 0.5);
  static const Color textFieldUnderLineDefaultColor = const Color(0xFFD8D8D8);
  static const Color textFieldUnderLineFocusColor = const Color(0xFF232223);

  static Color indicatorInactiveBgColor = Colors.white.withOpacity(0.3);
  static const Color indicatorActiveBgColor = Colors.white;

  static const Color bottomNavigationBgColor = Colors.white;
  static const Color bottomNavigationSelectedColor =
      const Color.fromRGBO(0, 159, 212, 1.0);
  static const Color bottomNavigationUnSelectedColor = Colors.white;

  //Dialog
  static const Color dialogButtonYesBgColor = const Color(0xfffa6400);
  static const Color dialogButtonNoBgColor = Colors.white;
  static const Color dialogButtonYesTextColor = Colors.white;
  static const Color dialogButtonNoTextColor = const Color(0xfffa6400);
  static const Color dialogButtonBorderColor = const Color(0xfffa6400);
  static const Color dialogButtonShadowColor =
      const Color.fromRGBO(109, 110, 237, 0.15);
  static const Color dialogDescriptionTextColor = const Color(0xFF59649e);
  static const Color dialogTitleTextColor = const Color(0xFF59649e);
  static const Color shadowPurpleColor =
      const Color.fromRGBO(109, 110, 237, 0.3);
  static const Color toastWarningBgColor = const Color(0xf0ffec3d);
  static const Color toastErrorBgColor = const Color(0xf0f5222d);
  static const Color toastSuccessBgColor = const Color(0xf0a0d911);

  //Gradient
  static const gradientPremium = [
    const Color(0xffF858A2),
    const Color(0xffED1C24),
  ];
  static const gradientInvite = [
    const Color.fromRGBO(250, 100, 0, 1.0),
    const Color.fromRGBO(255, 126, 0, 1.0)
  ];
  final gradientMiniChartIncrease = [
    Get.context!.theme.primaryColorLight.withOpacity(0.3),
    const Color.fromRGBO(52, 169, 255, 0.01)
  ];
  final gradientMiniChartDecrease = [
    Get.context!.theme.primaryColorDark.withOpacity(0.3),
    const Color.fromRGBO(255, 90, 117, 0.01)
  ];
  final gradientMiniChartIncreaseClose = [
    Get.context!.theme.disabledColor,
    const Color.fromRGBO(52, 169, 255, 0.01)
  ];
  final gradientMiniChartDecreaseClose = [
    Get.context!.theme.disabledColor,
    const Color.fromRGBO(255, 90, 117, 0.01)
  ];
  static final gradientMainChartIncrease = [
    const Color.fromRGBO(100, 212, 255, 0.5),
    const Color.fromRGBO(52, 169, 255, 0.05)
  ];
  static final gradientMainChartDecrease = [
    const Color.fromRGBO(255, 90, 117, 0.5),
    const Color.fromRGBO(255, 90, 117, 0.05)
  ];
  static final gradientMainChart = [
    const Color(0xf0ffec3d).withOpacity(0.5),
    const Color(0xf0ffec3d).withOpacity(0.05)
  ];

  //Border
  static final borderMainChartIncrease =
      const Color.fromRGBO(100, 212, 255, 1.0);
  static final borderMainChartDecrease =
      const Color.fromRGBO(255, 90, 117, 1.0);
  static final borderMainChart = const Color(0xf0ffec3d);

  //Shadow
  static Color shadowBtnDefaultColor = Color(0xFF000000).withOpacity(0.1);
  static Color shadowSplashBgColor = Color(0xFFffffff).withOpacity(0.11);
  static Color shadowNewSignalColor = Color(0xFF848484).withOpacity(0.5);
  static Color shadowModalColor = Color(0xFF000000).withOpacity(0.5);
  static Color shadowPremium = const Color.fromRGBO(255, 107, 0, 0.4);

  //Text style
  static const String fontMedium = "SFPro-Medium";
  static const String fontDemiBold = "SFPro-SemiBold";
  static const String fontUltraLight = "SFPro-Ultralight";
  static const String fontItalic = "SFPro-Italic";
  static const String fontRegular = "SFPro-Regular";
  static const String fontBold = "SFPro-Bold";
  static const String fontDisplayDemiBold = "SFProDisplay-SemiBold";
  static const String fontDisplayBold = "SFProDisplay-Bold";

  TextStyle textStyle({
    double? height,
    double? letterSpacing,
    double? fontSize,
    String? fontFamily,
    Color? color,
  }) =>
      TextStyle(
        color: color ?? Get.context?.textTheme.headline1!.color,
        fontFamily: fontFamily ?? fontDemiBold,
        fontSize: fontSize ?? 20.sp,
        letterSpacing: letterSpacing ?? -0.38.sp,
      );

  TextStyle titleStyle1 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontDisplayBold,
    fontSize: 22.sp,
    letterSpacing: 0.35.sp,
  );

  TextStyle titleStyle2 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontDisplayDemiBold,
    fontSize: 20.sp,
    letterSpacing: 0.38.sp,
  );

  TextStyle subtitleStyle1 = TextStyle(
    color: Get.context!.textTheme.headline1?.color,
    fontFamily: fontDemiBold,
    fontSize: 17.sp,
    letterSpacing: -0.41.sp,
  );

  TextStyle subtitleStyle2 = TextStyle(
    color: Get.context?.textTheme.headline1?.color,
    fontFamily: fontRegular,
    fontSize: 17.sp,
    letterSpacing: -0.41.sp,
  );

  TextStyle bodyStyle1 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontRegular,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle hintStyle = TextStyle(
    color: Get.context?.theme.hintColor,
    fontFamily: fontRegular,
    fontSize: 17.sp,
    letterSpacing: -0.41.sp,
  );

  TextStyle highlightStyle = TextStyle(
    color: Get.context?.theme.colorScheme.secondary,
    fontFamily: fontRegular,
    fontSize: 17.sp,
    letterSpacing: -0.41.sp,
  );

  TextStyle primaryStyle = TextStyle(
    color: Get.context?.theme.primaryColorDark,
    fontFamily: fontDemiBold,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle noteStyle1 = TextStyle(
    color: Get.context?.theme.hintColor,
    fontFamily: fontDemiBold,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle normalStyle1 = TextStyle(
    color: Get.context?.textTheme.bodyText1!.color,
    fontFamily: fontDemiBold,
    fontSize: 13.sp,
    letterSpacing: -0.08.sp,
  );

  TextStyle hintStyleDemoBold = TextStyle(
    color: Get.context?.theme.hintColor,
    fontFamily: fontDemiBold,
    fontSize: 17.sp,
    letterSpacing: -0.24.sp,
    height: 20.sp / 15.sp,
  );

  TextStyle bodyStyle2 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontDemiBold,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle bodyStyle3 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontMedium,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle bodyStyle4 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontDemiBold,
    fontSize: 15.sp,
    letterSpacing: -0.24.sp,
  );

  TextStyle normalStyle2 = TextStyle(
    color: Get.context?.theme.hintColor,
    fontFamily: fontDemiBold,
    fontSize: 13.sp,
    letterSpacing: -0.08.sp,
  );

  TextStyle titleStyle5 = TextStyle(
    color: Get.context?.textTheme.caption!.color,
    fontFamily: fontDemiBold,
    fontSize: 17.sp,
    letterSpacing: -0.41.sp,
  );

  TextStyle normalStyle3 = TextStyle(
    color: Get.context?.textTheme.headline1!.color,
    fontFamily: fontRegular,
    fontSize: 10.sp,
    letterSpacing: -0.08.sp,
  );

  TextStyle normalStyle4 = TextStyle(
    color: Get.context?.textTheme.bodyText1!.color,
    fontFamily: fontDemiBold,
    fontSize: 13.sp,
    letterSpacing: -0.31.sp,
    height: 20.sp / 13.sp,
  );
  TextStyle noteStyleRegular = TextStyle(
    color: Get.context?.textTheme.bodyText1!.color,
    fontFamily: fontDemiBold,
    fontSize: 13.sp,
    letterSpacing: -0.31.sp,
    height: 20.sp / 13.sp,
  );

  TextStyle normalStyle5 = TextStyle(
    color: Get.context?.textTheme.bodyText1!.color,
    fontFamily: fontDemiBold,
    fontSize: 13.sp,
    letterSpacing: -0.31.sp,
    height: 20.sp / 13.sp,
  );

  TextStyle cardStyle = TextStyle(
    color: Get.context?.textTheme.bodyText1!.color,
    fontFamily: fontRegular,
    fontSize: 11.sp,
    letterSpacing: -0.18.sp,
    height: 20.sp / 13.sp,
  );
}

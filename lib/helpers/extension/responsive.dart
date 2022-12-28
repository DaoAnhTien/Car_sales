import 'package:oke_car_flutter/utils/screen_util.dart';

extension ResponsiveExtension on num {
  ///[ScreenUtil.setWidth]
  double get w => ScreenUtil().setScale(this.toDouble());

  ///[ScreenUtil.setHeight]
  double get h => ScreenUtil().setScale(this.toDouble());

  ///[ScreenUtil.setSp]
  double get sp => ScreenUtil().setSp(this.toDouble());
}
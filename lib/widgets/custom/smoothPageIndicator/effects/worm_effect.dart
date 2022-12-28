import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/indicator_painter.dart';
import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/worm_painter.dart';
import 'package:flutter/material.dart';

import 'indicator_effect.dart';

class WormEffect extends IndicatorEffect {
  const WormEffect({
    double? offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
    bool activeAfterNext = false,
    List<int> listActive = const [0],
  }) : super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
          activeAfterNext: activeAfterNext,
          listActive: listActive,
        );

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return WormPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}

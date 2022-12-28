import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/expanding_dots_painter.dart';
import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/indicator_painter.dart';
import 'package:flutter/material.dart';

import 'indicator_effect.dart';

class ExpandingDotsEffect extends IndicatorEffect {
  /// [expansionFactor] is multiplied by [dotWidth] to resolve
  /// the width of the expanded dot.
  final double expansionFactor;

  const ExpandingDotsEffect({
    this.expansionFactor = 3,
    double? offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16.0,
    Color activeDotColor = Colors.indigo,
    Color dotColor = Colors.grey,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
    bool activeAfterNext = false,
    List<int> listActive = const [0],
  })  : assert(expansionFactor > 1),
        super(
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
  Size calculateSize(int count) {
    // Add the expanded dot width to our size calculation
    return Size(
        ((dotWidth + spacing) * (count - 1)) + (expansionFactor * dotWidth),
        dotHeight);
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return ExpandingDotsPainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}

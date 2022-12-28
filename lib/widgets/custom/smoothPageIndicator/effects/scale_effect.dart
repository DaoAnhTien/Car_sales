import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/effects/indicator_effect.dart';
import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/indicator_painter.dart';
import 'package:oke_car_flutter/widgets/custom/smoothPageIndicator/painters/scale_painter.dart';
import 'package:flutter/material.dart';

class ScaleEffect extends IndicatorEffect {
  // Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle activePaintStyle;

  /// This is ignored if [activePaintStyle] is PaintStyle.fill
  final double activeStrokeWidth;

  /// [scale] is multiplied by [dotWidth] to resolve
  /// active dot scaling
  final double scale;

  const ScaleEffect({
    Color activeDotColor = Colors.indigo,
    this.activePaintStyle = PaintingStyle.fill,
    this.scale = 0.3,
    this.activeStrokeWidth = 1.0,
    double? offset,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 16.0,
    double radius = 16,
    Color dotColor = Colors.grey,
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
  Size calculateSize(int count) {
    // Add the scaled dot width to our size calculation
    final scaledWidth = (dotWidth + (dotWidth * scale)) - dotWidth;
    return Size((dotWidth * count) + (spacing * (count - 1)) + scaledWidth,
        (dotHeight + scaledWidth));
  }

  @override
  IndicatorPainter buildPainter(int count, double offset, bool isRTL) {
    return ScalePainter(
        count: count, offset: offset, effect: this, isRTL: isRTL);
  }
}

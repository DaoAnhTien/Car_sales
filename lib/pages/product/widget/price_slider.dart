import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceRangeSlider extends StatelessWidget {
  final double max;
  final double min;
  final double selectedMin;
  final double selectedMax;
  final String label;
  final Function(RangeValues value) onChanged;

  PriceRangeSlider(
      {required this.max,
      required this.min,
      required this.selectedMin,
      required this.selectedMax,
      required this.label,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: <Widget>[
                  Container(
                      width: Get.width / 2,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$' + selectedMin.toStringAsFixed(0),
                      )),
                  Container(
                      width: Get.width / 2,
                      alignment: Alignment.centerRight,
                      child: Text(
                        '\$' + selectedMax.toStringAsFixed(0),
                      ))
                ],
              ),
            ),
            RangeSlider(
              divisions: max.toInt() - min.toInt(),
              activeColor: context.theme.primaryColor,
              inactiveColor: context.theme.cardColor,
              max: max,
              min: min,
              onChangeStart: onChanged,
              onChangeEnd: onChanged,
              values: RangeValues(selectedMin, selectedMax),
              onChanged: onChanged,
            )
          ]))
    ]);
  }
}

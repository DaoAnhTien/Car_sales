import 'package:flutter/material.dart';

class CustomAnimationToast extends StatelessWidget {
  final double? value;
  final Widget? content;

  static final Tween<Offset> tweenOffset = Tween<Offset>(begin: Offset(0, 40), end: Offset(0, 0));

  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);

  const CustomAnimationToast({this.value, this.content});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: tweenOffset.transform(value!),
      child: Opacity(
        child: content,
        opacity: tweenOpacity.transform(value!),
      ),
    );
  }
}
import 'dart:core';

import 'package:flutter/material.dart';

class CustomMessageClipper extends CustomClipper<Path> {
  CustomMessageClipper({this.borderRadius = 0, this.roundHeight = 20});

  final double borderRadius;
  final double roundHeight;

  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - roundHeight;
    double oneThird = width / 3;

    final path = Path()
      ..lineTo(0, rheight - borderRadius)
      ..cubicTo(0, rheight - borderRadius, 0, rheight, borderRadius, rheight)
      ..lineTo(oneThird, rheight)
      ..lineTo(width / 2 - borderRadius, height - borderRadius)
      ..cubicTo(width / 2 - borderRadius, height - borderRadius, width / 2,
          height, width / 2 + borderRadius, height - borderRadius)
      ..lineTo(2 * oneThird, rheight)
      ..lineTo(width - borderRadius, rheight)
      ..cubicTo(width - borderRadius, rheight, width, rheight, width,
          rheight - borderRadius)
      ..lineTo(width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

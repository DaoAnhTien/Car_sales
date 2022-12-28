import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    this.onClosed,
    this.nextScreen,
    this.openColor,
    this.closedColor,
    this.openShape,
    this.closedShape,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?>? onClosed;
  final Widget? nextScreen;
  final Color? openColor;
  final Color? closedColor;
  final ShapeBorder? openShape;
  final ShapeBorder? closedShape;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      openColor: openColor!,
      closedColor: closedColor!,
      closedShape: openShape!,
      openShape: closedShape!,
      closedElevation: 0.0,
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return nextScreen!;
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

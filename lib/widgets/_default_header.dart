import 'package:flutter/material.dart';
import 'package:oke_car_flutter/values/style.dart';
import 'package:oke_car_flutter/helpers/extension/responsive.dart';


class DefaultHeader extends StatelessWidget {
  final String title;
  final String description;
  final EdgeInsetsGeometry padding;

  const DefaultHeader({
    Key? key,
    this.title = '',
    this.description = '',
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: Style().titleStyle1,
          ),
          SizedBox(
            height: 6.w,
          ),
          Text(
            description,
            textAlign: TextAlign.left,
            style: Style().bodyStyle1,
          ),
        ],
      ),
    );
  }
}

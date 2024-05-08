import 'package:flutter/material.dart';

import 'package:monipleapp/constants.dart';

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
    this.size = 5,
    this.radius = 10,
  }) : super(key: key);

  final Color? color;
  final int? percentage;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: size,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
          ),
        ),
      ],
    );
  }
}

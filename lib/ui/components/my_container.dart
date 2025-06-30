import 'package:flutter/material.dart';

import '../../constants.dart';

class MyContainer extends StatelessWidget {
  final Widget child;
  final bool border;
  final double? width;
  final Color? color;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? horizontalMargin;
  final double? verticalMargin;

  const MyContainer({
    super.key,
    required this.child,
    this.color,
    this.border = false,
    this.width,
    this.horizontalPadding = defaultPadding,
    this.verticalPadding = defaultPadding / 2,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding!,
        vertical: verticalPadding!,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin!,
        vertical: verticalMargin!,
      ),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).colorScheme.secondary,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: (border)
            ? Border.all(color: Theme.of(context).colorScheme.outline)
            : null,
      ),
      width: (width != null) ? width : null,
      child: child,
    );
  }
}

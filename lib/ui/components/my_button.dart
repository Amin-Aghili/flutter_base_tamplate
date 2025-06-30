import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.disable = false,
    this.onTap,
    required this.text,
    this.marginHorizontal = 20,
    this.paddingHorizontal = 20,
    this.paddingVertical = 20,
    this.radius = 10,
    this.fontSize,
    this.color,
    this.textColor,
    this.leftIcon,
    this.rightIcon,
  });

  final VoidCallback? onTap;
  final String text;
  final double marginHorizontal;
  final double paddingHorizontal;
  final double paddingVertical;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double radius;
  final bool disable;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable ? null : onTap,
      child: Opacity(
        opacity: disable ? 0.5 : 1,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
          padding: EdgeInsets.symmetric(
            horizontal: paddingHorizontal,
            vertical: paddingVertical,
          ),
          decoration: BoxDecoration(
            color: disable
                ? Colors.grey[400]
                : (color != null)
                    ? color
                    : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (rightIcon != null)
                  Icon(
                    rightIcon,
                    color: textColor,
                  ),
                if (rightIcon != null) SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(fontSize: fontSize, color: textColor),
                ),
                if (leftIcon != null) SizedBox(width: 8),
                if (leftIcon != null)
                  Icon(
                    leftIcon,
                    color: textColor,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

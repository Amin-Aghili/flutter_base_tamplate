import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySwitch extends StatelessWidget {
  const MySwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    this.marginHorizontal = 25,
    this.marginVertical = 0,
    this.paddingHorizontal = 10,
    this.paddingVertical = 0,
    this.borderCircular = 4,
    this.borderColor = Colors.transparent,
  });
  final String title;
  final bool value;
  final double? marginHorizontal;
  final double? marginVertical;
  final double? paddingHorizontal;
  final double? paddingVertical;
  final double? borderCircular;
  final Color? borderColor;
  final void Function(bool value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: marginHorizontal!, vertical: marginVertical!),
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal!, vertical: paddingVertical!),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderCircular!),
        border: Border.all(color: borderColor!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style:
                TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

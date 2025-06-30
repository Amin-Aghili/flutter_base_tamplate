import 'package:flutter/material.dart';

class MyDialog extends StatelessWidget {
  const MyDialog({
    super.key,
    required this.confirmFunction,
    required this.widget,
  });

  final VoidCallback confirmFunction;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Basic dialog title'),
      content: widget,
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: const Text('Disable'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Enable'),
          onPressed: () {
            Navigator.of(context).pop();
            confirmFunction();
          },
        ),
      ],
    );
  }
}

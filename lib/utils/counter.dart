import 'package:flutter/material.dart';

class ProductCounter extends StatefulWidget {
  final int initialCount;
  final Function(int) onCountChanged;

  const ProductCounter({
    super.key,
    required this.initialCount,
    required this.onCountChanged,
  });

  @override
  State<ProductCounter> createState() => _ProductCounterState();
}

class _ProductCounterState extends State<ProductCounter> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialCount;
  }

  void _increment() {
    setState(() {
      _count++;
      widget.onCountChanged(_count);
    });
  }

  void _decrement() {
    if (_count > 1) {
      setState(() {
        _count--;
        widget.onCountChanged(_count);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          color: Theme.of(context).colorScheme.inversePrimary,
          icon: Icon(
            Icons.remove,
          ),
          onPressed: _decrement,
        ),
        Text(
          '$_count',
          style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        IconButton(
          color: Theme.of(context).colorScheme.inversePrimary,
          icon: Icon(Icons.add),
          onPressed: _increment,
        ),
      ],
    );
  }
}

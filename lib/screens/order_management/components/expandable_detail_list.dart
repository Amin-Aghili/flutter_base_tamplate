import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/components/my_container.dart';

import 'build_detail_row.dart';

class ExpandableDetailList extends StatefulWidget {
  final List<Map<String, String>> details;

  const ExpandableDetailList({super.key, required this.details});

  @override
  State<ExpandableDetailList> createState() => _ExpandableDetailListState();
}

class _ExpandableDetailListState extends State<ExpandableDetailList>
    with SingleTickerProviderStateMixin {
  bool showAll = false;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  double rotationTurns = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    )..repeat(reverse: true, period: Duration(seconds: 1));

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.3).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> detailsToShow = showAll
        ? widget.details
        : widget.details.reversed.take(4).toList().reversed.toList();

    return GestureDetector(
      onTap: () {
        setState(() {
          showAll = !showAll;
          showAll ? _controller.forward() : _controller.reverse();
          rotationTurns += 0.5;
        });
      },
      child: MyContainer(
        child: Column(
          children: [
            ...detailsToShow.map(
              (detail) => BuildDetailRow(
                  title: detail.keys.first, value: detail.values.first),
            ),
            SizedBox(
              height: 10,
            ),
            if (widget.details.length > 4)
              AnimatedOpacity(
                opacity: _opacityAnimation.value,
                duration: Duration(milliseconds: 800),
                child: AnimatedRotation(
                  turns: rotationTurns,
                  duration: Duration(milliseconds: 800),
                  child: Icon(Icons.keyboard_arrow_down),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

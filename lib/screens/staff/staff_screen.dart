import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/layout/header_scroll_screen.dart';
import 'components/header.dart';
import 'components/example.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderScrollScreen(
      header: const Header(),
      child: Column(
        children: [
          ...List.generate(
            100,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('$index'),
                  SizedBox(width: 10),
                  ExampleWidget(),
                ],
              ),
            ),
          ),
          ExampleWidget(),
          SizedBox(height: 1000),
        ],
      ),
    );
  }
}

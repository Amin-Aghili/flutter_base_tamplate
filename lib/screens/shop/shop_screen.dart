import 'package:flutter_base_template/responsive.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
// import 'components/header.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        "Shop",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

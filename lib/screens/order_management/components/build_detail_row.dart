import 'package:flutter/material.dart';

class BuildDetailRow extends StatelessWidget {
  const BuildDetailRow({
    super.key,
    this.title = "",
    this.value = "",
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: 200,
            ),
            child: Text(
              '$title : ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: 300,
            ),
            child: Text(value),
          ),
        ],
      ),
    );
  }
}

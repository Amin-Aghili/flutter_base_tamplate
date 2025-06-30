import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/member_model.dart';

import '../../../ui/components/my_container.dart';

class MyMemberTile extends StatelessWidget {
  const MyMemberTile({
    super.key,
    required this.member,
    required this.onTap,
  });
  final VoidCallback onTap;
  final MemberModel member;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: MyContainer(
            verticalMargin: 3,
            horizontalMargin: 5,
            verticalPadding: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  child: Text(member.name?[0] ?? 'N/A'),
                ),
                Text(member.name!),
                Text(member.phone.toString()),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

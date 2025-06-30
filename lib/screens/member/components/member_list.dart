import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/member_model.dart';
import 'package:flutter_base_template/screens/member/components/member_bottom_sheet.dart';
import 'package:flutter_base_template/screens/member/components/my_member_tile.dart';

class MemberList extends StatelessWidget {
  final List<MemberModel> memberList;
  final bool isLoading;

  const MemberList({
    super.key,
    required this.memberList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: memberList.length,
            (context, index) {
              if (isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (index == memberList.length - 1) {
                return const SizedBox(height: 100);
              }
              final member = memberList[index];
              return MyMemberTile(
                member: member,
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 5 / 6,
                    ),
                    child: MemberBottomSheet(member: member),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

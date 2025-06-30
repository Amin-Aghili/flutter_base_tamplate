import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/member_model.dart';
import 'package:flutter_base_template/screens/order_management/components/expandable_detail_list.dart';
import 'package:flutter_base_template/services/member_service.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:provider/provider.dart';

class MemberBottomSheet extends StatefulWidget {
  const MemberBottomSheet({
    super.key,
    required this.member,
  });
  final MemberModel member;

  @override
  State<MemberBottomSheet> createState() => _MemberBottomSheetState();
}

class _MemberBottomSheetState extends State<MemberBottomSheet> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountDeposited = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    descriptionController.dispose();
    amountDeposited.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemberService>(
      builder: (context, service, child) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.8, // حداکثر 80% ارتفاع صفحه
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0, top: 3, left: 10, right: 10),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // اندازه به محتوای داخل بستگی داره
              children: [
                Text(
                  widget.member.name!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Divider(),
                Flexible(
                  fit: FlexFit.loose, // اجازه میده اندازه داینامیک باشه
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 16.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandableDetailList(
                                    details: [
                                      {
                                        'نام ': widget.member.name!,
                                      },
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyButton(
                              text: "نمیدونم",
                              radius: 30,
                              paddingVertical: 10,
                              color: Colors.green,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

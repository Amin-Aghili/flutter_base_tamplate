import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/components/my_container.dart';

import '../../../models/payment_model.dart';
import '../../../utils/format.dart';

class MyPaymentTile extends StatelessWidget {
  const MyPaymentTile({
    super.key,
    required this.endItem,
    required this.payment,
    required this.onTap,
    this.onSelect,
  });
  final VoidCallback onTap;
  final PaymentModel payment;
  final bool endItem;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    // final int lastDay = calculateDaysDifference(payment.updatedAt!);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: MyContainer(
            verticalMargin: 3,
            horizontalMargin: 5,
            verticalPadding: 20,
            // horizontalPadding: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('${formatNumber(payment.amount!)} تومان'),
                Text(payment.referenceCode.toString()),
                Text(payment.name?.isNotEmpty == true
                    ? payment.name!
                    : 'اسم مشتری'),
                // Print all payment data as JSON
              ],
            ),
          ),
        ),
        if (endItem)
          SizedBox(
            height: 100,
          )
      ],
    );
  }
}

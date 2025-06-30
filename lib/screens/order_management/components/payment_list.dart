import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/payment_model.dart';
import 'package:flutter_base_template/screens/order_management/components/payment_tile.dart';
import 'package:flutter_base_template/screens/order_management/components/payment_details_bottom_sheet.dart';

class PaymentList extends StatelessWidget {
  final List<PaymentModel> payments;
  final int step;

  const PaymentList({
    super.key,
    required this.payments,
    required this.step,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == 0) {
                return const SizedBox(height: 6);
              }

              if (index == payments.length) return const SizedBox(height: 100);
              final payment = payments[index];
              return MyPaymentTile(
                endItem: index == payments.length - 1,
                payment: payment,
                onTap: () => showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 5 / 6,
                    ),
                    child:
                        PaymentDetailsBottomSheet(payment: payment, step: step),
                  ),
                ),
              );
            },
            childCount: payments.length,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/models/payment_model.dart';
import 'package:flutter_base_template/models/shop.dart';
import 'order_list.dart';
import 'payment_list.dart';

class TabContent extends StatelessWidget {
  final TabController tabController;
  final List<PaymentModel> payments;
  final List<OrderModel> orders;
  final bool isPaymentLoading;
  final bool isOrderLoading;
  final Set<int> selectedIds;
  final void Function(int) onToggleSelection;

  const TabContent({
    super.key,
    required this.tabController,
    required this.payments,
    required this.orders,
    required this.isPaymentLoading,
    required this.isOrderLoading,
    required this.selectedIds,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: List.generate(
        ShippingSteps.values.length,
        (index) => index == 0
            ? payments.isEmpty
                ? _buildEmptyState(isPaymentLoading)
                : PaymentList(payments: payments, step: index)
            : orders.isEmpty
                ? _buildEmptyState(isOrderLoading)
                : OrderList(
                    orders: orders,
                    step: index,
                    selectedIds: selectedIds,
                    onToggleSelection: onToggleSelection,
                  ),
      ),
    );
  }

  Widget _buildEmptyState(bool isLoading) => CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const Text(
                      'سفارشی برای نمایش وجود ندارد',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      );
}

import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/screens/order_management/components/my_order_tile.dart';
import 'package:flutter_base_template/screens/order_management/components/order_details_bottom_sheet.dart';

class OrderList extends StatelessWidget {
  final List<OrderModel> orders;
  final int step;
  final Set<int> selectedIds;
  final void Function(int) onToggleSelection;

  const OrderList({
    super.key,
    required this.orders,
    required this.step,
    required this.selectedIds,
    required this.onToggleSelection,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              if (index == orders.length) return const SizedBox(height: 100);
              final order = orders[index];
              final isSelected = selectedIds.contains(order.orderDetailId);
              return MyOrderTile(
                endItem: index == orders.length - 1,
                order: order,
                isSelected: isSelected,
                onSelect: (step == 3)
                    ? () => onToggleSelection(order.orderDetailId!)
                    : null,
                onTap: () => selectedIds.isNotEmpty
                    ? onToggleSelection(order.orderDetailId!)
                    : showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 5 / 6,
                          ),
                          child:
                              OrderDetailsBottomSheet(order: order, step: step),
                        ),
                      ),
              );
            },
            childCount: orders.length + 1,
          ),
        ),
      ],
    );
  }
}

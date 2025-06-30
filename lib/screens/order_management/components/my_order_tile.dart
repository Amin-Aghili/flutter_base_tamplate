import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/screens/order_management/components/build_detail_row.dart';
import 'package:flutter_base_template/ui/components/my_container.dart';
import 'package:flutter_base_template/utils/format.dart';

class MyOrderTile extends StatelessWidget {
  const MyOrderTile({
    super.key,
    required this.endItem,
    required this.order,
    required this.onTap,
    this.isSelected = false,
    this.onSelect,
  });
  final VoidCallback onTap;
  final OrderModel order;
  final bool endItem;
  final bool isSelected;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    final int lastDay = calculateDaysDifference(order.updatedAt!);

    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          onLongPress: onSelect,
          child: MyContainer(
            verticalMargin: 3,
            horizontalMargin: 5,
            verticalPadding: 20,
            // color: lastDay > 5
            //     ? Colors.red
            //     : isSelected
            //         ? Theme.of(context).colorScheme.primary
            //         : Colors.transparent,
            // padding: EdgeInsets.all(isSelected ? 15 : 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isSelected)
                  Checkbox(
                    value: isSelected,
                    onChanged: onSelect != null ? (_) => onSelect!() : null,
                  ),
                if (order.productImage != null)
                  Image.network(
                    order.productImage!,
                    height: 100,
                  ),
                SizedBox(
                  // width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (order.size!.isNotEmpty)
                        BuildDetailRow(
                          title: "سایز",
                          value: order.size!,
                        ),
                      if (order.color!.isNotEmpty)
                        BuildDetailRow(
                          title: "رنگ",
                          value: order.color!,
                        ),
                      BuildDetailRow(
                        title: "تعداد",
                        value: order.quantity!.toString(),
                      ),
                      if (order.weight! > 0)
                        BuildDetailRow(
                          title: "وزن",
                          value: order.weight!.toString(),
                        ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(order.createdAt!.substring(0, 10)),
                    Text(' ${lastDay.toString()} روز پیش'),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        (endItem)
            ? SizedBox(
                height: 100,
              )
            : Divider(
                endIndent: 20,
                indent: 20,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
      ],
    );
  }
}

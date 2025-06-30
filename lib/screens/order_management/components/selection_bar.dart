import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/services/order_service.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';
import 'package:provider/provider.dart';

class SelectionBar extends StatelessWidget {
  final Set<int> selectedId;
  final List<OrderModel> orderList;
  final int currentStep;
  final int totalSteps;
  final VoidCallback onSelectAll;
  final VoidCallback onDeselectAll;
  final VoidCallback onMovePrevious;
  final VoidCallback onMoveNext;

  const SelectionBar({
    super.key,
    required this.selectedId,
    required this.orderList,
    required this.currentStep,
    required this.totalSteps,
    required this.onSelectAll,
    required this.onDeselectAll,
    required this.onMovePrevious,
    required this.onMoveNext,
  });

  void _showDialog(BuildContext context, {bool isNext = false}) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: isNext
            ? const Text('نام باربر و توضیحات')
            : const Text('رفتن به مرحله قبل'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        content: isNext
            ? MyTextField(
                controller: controller, hintText: 'نام باربر و توضیحات')
            : const Text('آیا اطمینان دارید؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لغو'),
          ),
          TextButton(
            onPressed: () {
              final service = Provider.of<OrderService>(context, listen: false);
              for (final id in selectedId) {
                service.updateOrderStep(
                  orderDetailId: id,
                  updateStep: isNext ? currentStep + 1 : currentStep - 1,
                  description: isNext ? controller.text : null,
                );
              }
              isNext ? onMoveNext() : onMovePrevious();
              Navigator.pop(context);
            },
            child: const Text('تأیید'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'آیتم‌ها: ${selectedId.length}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              if (currentStep > 0)
                TextButton(
                  onPressed: () => _showDialog(context),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('مرحله قبل'),
                ),
              if (currentStep < totalSteps - 1)
                TextButton(
                  onPressed: () => _showDialog(context, isNext: true),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                  child: const Text('ارسال بار'),
                ),
              IconButton(
                icon: Icon(
                  orderList.length != selectedId.length
                      ? Icons.select_all_outlined
                      : Icons.deselect,
                  color: Colors.white,
                ),
                onPressed: orderList.length != selectedId.length
                    ? onSelectAll
                    : onDeselectAll,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/order_model.dart';
import 'package:flutter_base_template/models/shop.dart';
import 'package:flutter_base_template/screens/order_management/components/expandable_detail_list.dart';
import 'package:flutter_base_template/services/order_service.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../utils/format.dart';
import 'copy_able_link.dart';
import 'full_screen_image.dart';
import 'shipping_steps_extension.dart';

class OrderDetailsBottomSheet extends StatefulWidget {
  const OrderDetailsBottomSheet({
    super.key,
    required this.order,
    required this.step,
  });
  final OrderModel order;
  final int step;

  @override
  State<OrderDetailsBottomSheet> createState() =>
      _OrderDetailsBottomSheetState();
}

class _OrderDetailsBottomSheetState extends State<OrderDetailsBottomSheet> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController trackingCodeController = TextEditingController();
  final TextEditingController amountDeposited = TextEditingController();
  final FocusNode focusNode = FocusNode();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    weightController.text =
        (widget.order.weight! > 0) ? widget.order.weight.toString() : "";
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNode);
    });

    weightController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    weightController.dispose();
    focusNode.dispose();
    descriptionController.dispose();
    trackingCodeController.dispose();
    amountDeposited.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final ShippingSteps currentStep = ShippingSteps.values[widget.step];

    return Consumer<OrderService>(
      builder: (context, orderService, child) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height *
                0.85, // حداکثر 80% ارتفاع صفحه
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 20.0, top: 3, left: 10, right: 10),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // اندازه به محتوای داخل بستگی داره
              children: [
                Text(
                  currentStep.localizedStep(l10n),
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
                            // Product Image
                            if (currentStep !=
                                ShippingSteps.paymentConfirmation)
                              FullScreenImage(
                                imageUrl: widget.order.productImage ??
                                    "https://cdn.dsmcdn.com/ty1317/product/media/images/prod/QC/20240516/17/34be9935-13f9-3ce7-93e5-75ca472a3bbf/1_org_zoom.jpg",
                              ),
                            const SizedBox(width: 16.0),
                            // Product Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandableDetailList(
                                    details: [
                                      {
                                        'فاکتور':
                                            widget.order.orderId.toString()
                                      },
                                      {
                                        'سفارش': widget.order.orderDetailId
                                            .toString()
                                      },
                                      {'نام مشتری': widget.order.memberName!},
                                      {
                                        'تاریخ': widget.order.createdAt!
                                            .substring(0, 10)
                                      },
                                      {
                                        'ساعت': widget.order.createdAt!
                                            .substring(11)
                                      },
                                      {
                                        'قیمت':
                                            formatNumber(widget.order.price!)
                                      },
                                      {'سایز': widget.order.size!},
                                      {'رنگ': widget.order.color!},
                                      {
                                        'تعداد':
                                            widget.order.quantity.toString()
                                      },
                                      if (widget.order.weight! > 0)
                                        {'وزن': widget.order.weight.toString()},
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        // Product Link
                        if (currentStep != ShippingSteps.paymentConfirmation)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (currentStep == ShippingSteps.orderPlacement)
                                  CopyableLink(
                                    productUrl: widget.order.productUrl!,
                                  )
                                else
                                  Row(
                                    children: [
                                      if (currentStep ==
                                          ShippingSteps.receiving)
                                        Expanded(
                                          flex: 1,
                                          child: MyTextField(
                                              type: TextInputType.number,
                                              focusNode: focusNode,
                                              paddingHorizontal: 2,
                                              controller: weightController,
                                              hintText: 'وزن کالا'),
                                        ),
                                      if (currentStep == ShippingSteps.iranPost)
                                        Expanded(
                                          flex: 2,
                                          child: MyTextField(
                                              type: TextInputType.number,
                                              focusNode: focusNode,
                                              paddingHorizontal: 2,
                                              controller:
                                                  trackingCodeController,
                                              hintText: 'کد پیگیری'),
                                        ),
                                      Expanded(
                                        flex: 3,
                                        child: MyTextField(
                                          paddingHorizontal: 2,
                                          controller: descriptionController,
                                          hintText: 'توضیحات',
                                        ),
                                      ),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        const SizedBox(height: 16.0),
                        // Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            if (currentStep != ShippingSteps.orderPlacement)
                              MyButton(
                                radius: 30,
                                paddingVertical: 10,
                                color: Colors.red,
                                onTap: () {
                                  orderService.updateOrderStep(
                                    updateStep: widget.step - 1,
                                    orderDetailId: widget.order.orderDetailId!,
                                  );
                                  Navigator.pop(context);
                                },
                                text: 'قبل',
                              ),
                            if (currentStep !=
                                ShippingSteps.paymentConfirmation)
                              MyButton(
                                text: "ثبت خطا",
                                radius: 30,
                                paddingVertical: 10,
                                color: Colors.green,
                                onTap: () {
                                  cancelOrder(context, widget.order);
                                },
                              ),
                            MyButton(
                              disable:
                                  (currentStep == ShippingSteps.orderPlacement)
                                      ? false
                                      : (currentStep != ShippingSteps.iranPost)
                                          ? weightController.text.isEmpty
                                          : trackingCodeController.text.isEmpty,
                              text: "بعد",
                              radius: 30,
                              paddingVertical: 10,
                              color: Colors.green,
                              onTap: () {
                                orderService.updateOrderStep(
                                  updateStep: widget.step + 1,
                                  orderDetailId: widget.order.orderDetailId!,
                                  description: descriptionController.text,
                                  trackingCode: trackingCodeController.text,
                                  weight: parsedNumber(weightController.text),
                                );
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

  void cancelOrder(context, OrderModel order) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text("آیا از حذف سفارش مطمئن هستید؟"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                    "در صورت حذف مبلغ ${formatNumber(order.price! * order.quantity!)} لیر به ولت اضافه میشود"),
                const SizedBox(height: 10),
                MyTextField(
                  controller: descriptionController,
                  hintText: "توضیحات",
                  minLines: 3,
                  maxLines: 3,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('لغو'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<OrderService>(context, listen: false).cancelOrder(
                    orderDetailId: order.orderDetailId!,
                    description: descriptionController.text);

                Navigator.of(context)
                  ..pop()
                  ..pop();
              },
              child: const Text('تایید'),
            ),
          ],
        );
      },
    );
  }

  void addError(context, TextEditingController amountDeposited) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: const Text('ثبت مبلغ دقیق واریز شده'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                MyTextField(
                  controller: amountDeposited,
                  hintText: "مبلغ واریز شده",
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

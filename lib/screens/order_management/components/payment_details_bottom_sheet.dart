import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/shop.dart';
import 'package:flutter_base_template/screens/order_management/components/expandable_detail_list.dart';
import 'package:flutter_base_template/services/payment_service.dart';
import 'package:flutter_base_template/ui/components/my_button.dart';
import 'package:flutter_base_template/ui/components/my_text_field.dart';
import 'package:provider/provider.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/payment_model.dart';
import '../../../utils/format.dart';
import 'shipping_steps_extension.dart';

class PaymentDetailsBottomSheet extends StatefulWidget {
  const PaymentDetailsBottomSheet({
    super.key,
    required this.payment,
    required this.step,
  });
  final PaymentModel payment;
  final int step;

  @override
  State<PaymentDetailsBottomSheet> createState() =>
      _PaymentDetailsBottomSheetState();
}

class _PaymentDetailsBottomSheetState extends State<PaymentDetailsBottomSheet> {
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
    final l10n = AppLocalizations.of(context)!;
    final ShippingSteps currentStep = ShippingSteps.values[widget.step];

    return Consumer<PaymentService>(
      builder: (context, service, child) {
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
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ExpandableDetailList(
                                    details: [
                                      {
                                        'شماره سند':
                                            widget.payment.paymentId.toString()
                                      },
                                      {
                                        'کد': widget.payment.referenceCode
                                            .toString()
                                      },
                                      {
                                        'مبلغ ':
                                            formatNumber(widget.payment.amount!)
                                      },
                                      {'تاریخ': "نداره چرا؟"},
                                      {'ساعت': 'نداره چرا ؟'},
                                    ],
                                  )
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
                              radius: 30,
                              paddingVertical: 10,
                              color: Colors.red,
                              onTap: () {
                                addError(context, amountDeposited);
                              },
                              text: 'ثبت خطا',
                            ),
                            MyButton(
                              text: "تایید پرداخت",
                              radius: 30,
                              paddingVertical: 10,
                              color: Colors.green,
                              onTap: () {
                                service
                                    .confirmPayment(widget.payment.paymentId!);
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
                Provider.of<PaymentService>(context, listen: false)
                    .paymentError(amountDeposited.text);
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

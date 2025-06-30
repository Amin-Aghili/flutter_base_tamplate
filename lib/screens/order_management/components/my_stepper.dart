// import 'package:flutter/material.dart';
// import 'package:flutter_base_template/models/shop.dart';
// import 'package:flutter_base_template/services/api_services.dart';
// import 'package:flutter_base_template/ui/my_text_form_field.dart';
// import 'package:flutter_base_template/utils/format.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'shipping_steps_extension.dart';

// class MyStepper extends StatefulWidget {
//   final Order order;
//   final int step;

//   const MyStepper({
//     required this.order,
//     required this.step,
//     super.key,
//   });

//   @override
//   State<MyStepper> createState() => _MyStepperState();
// }

// class _MyStepperState extends State<MyStepper> {
//   final TextEditingController _weightController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _trackingCodeController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;

//     return Consumer<ApiServices>(builder: (context, service, child) {
//       int currentStep = widget.step - 1;

//       return Column(
//         children: [
//           Stack(
//             children: [
//               // White line
//               Positioned(
//                 top: 28,
//                 left: 0,
//                 right: 0,
//                 child: Container(
//                   height: 1,
//                   color: Colors.white,
//                 ),
//               ),
//               // Green line
//               Positioned(
//                 top: 28,
//                 left: 0,
//                 width: MediaQuery.of(context).size.width *
//                     ((currentStep) / ShippingSteps.values.length),
//                 child: Container(
//                   height: 2,
//                   color: Colors.green,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: ShippingSteps.values
//                     .map((step) {
//                       int stepIndex = ShippingSteps.values.indexOf(step);
//                       return Column(
//                         children: [
//                           Icon(
//                             stepIndex <= currentStep - 1
//                                 ? Icons.check_circle
//                                 : Icons.radio_button_unchecked,
//                             color: stepIndex <= currentStep - 1
//                                 ? Colors.green
//                                 : Color.fromARGB(255, 133, 117, 117),
//                           ),
//                           SizedBox(height: 8),
//                           Text(
//                             step.localizedStep(l10n),
//                             style: TextStyle(
//                               fontWeight: stepIndex == currentStep
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                             ),
//                           ),
//                         ],
//                       );
//                     })
//                     .toList()
//                     .sublist(0, 4),
//               ),
//             ],
//           ),
//           SizedBox(height: 20), // Adding space after the step icons
//           ...ShippingSteps.values.asMap().entries.map((entry) {
//             int index = entry.key;
//             ShippingSteps step = entry.value;
//             return _buildStep(step, index, currentStep);
//           }),
//           SizedBox(height: 20), // Adding some space between steps and buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ElevatedButton(
//                 onPressed: currentStep > 0
//                     ? () {
//                         Navigator.pop(context);
//                         service.previousOrderStep(
//                             widget.order.orderId!, currentStep);
//                       }
//                     : null,
//                 child: Text('مرحله قبلی'),
//               ),
//               ElevatedButton(
//                 onPressed: currentStep < ShippingSteps.values.length - 1
//                     ? () {
//                         if (_formKey.currentState!.validate()) {
//                           service.nextOrderStep(
//                             currentStep,
//                             widget.order.orderId!,
//                             _descriptionController.text,
//                             0,
//                             _trackingCodeController.text,
//                           );
//                           Navigator.pop(context);
//                         }
//                       }
//                     : null,
//                 child: Text('مرحله بعدی'),
//               ),
//             ],
//           ),
//         ],
//       );
//     });
//   }

//   Widget _buildStep(
//     ShippingSteps step,
//     int index,
//     int currentStep,
//   ) {
//     if (currentStep == index) {
//       return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               if (currentStep == 0)
//                 MyTextFormField(
//                   controller: _weightController
//                     ..text = widget.order.weight?.toString() ?? "",
//                   hintText: 'weight',
//                   validator: (value) {
//                     if (value == null ||
//                         value.isEmpty ||
//                         parsedNumber(value) <= 0) {
//                       return 'Please enter Weight';
//                     }
//                     return null;
//                   },
//                 ),
//               if (currentStep == 3)
//                 MyTextFormField(
//                   controller: _trackingCodeController,
//                   hintText: 'Tracking Code',
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter Tracking Code';
//                     }
//                     return null;
//                   },
//                 ),
//               SizedBox(height: 10),
//               MyTextFormField(
//                 controller: _descriptionController
//                   ..text = widget.order.description ?? '',
//                 hintText: _getStepContent(step),
//                 // expands: true,

//                 maxLines: 5,
//                 // type: TextInputType.multiline,
//               ),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return SizedBox.shrink();
//     }
//   }

//   String _getStepTitle(ShippingSteps step) {
//     switch (step) {
//       case ShippingSteps.paymentConfirmation:
//         return 'تایید پرداخت';
//       case ShippingSteps.orderPlacement:
//         return 'سفارش';
//       case ShippingSteps.receiving:
//         return 'دریافت';
//       case ShippingSteps.shipping:
//         return 'ارسال';
//       case ShippingSteps.iranPost:
//         return 'پست داخلی';
//       default:
//         return '';
//     }
//   }

//   String _getStepContent(ShippingSteps step) {
//     switch (step) {
//       case ShippingSteps.paymentConfirmation:
//         return 'توضیحات مربوط به فیش پرداختی';
//       case ShippingSteps.orderPlacement:
//         return 'توضیحات مربوط به ثبت سفارش';
//       case ShippingSteps.receiving:
//         return 'توضیحات مربوط به دریافت کالا';
//       case ShippingSteps.shipping:
//         return 'توضیحات مربوط به ارسال کالا';
//       case ShippingSteps.iranPost:
//         return 'توضیحات مربوط به پست داخلی';
//       default:
//         return '';
//     }
//   }
// }

// //to do get wight in preparing

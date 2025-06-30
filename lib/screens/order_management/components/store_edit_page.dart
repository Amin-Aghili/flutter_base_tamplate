// import 'package:flutter/material.dart';
// import 'package:flutter_base_template/models/shop.dart';
// import 'package:flutter_base_template/screens/store/components/my_stepper.dart';
// import 'package:flutter_base_template/services/api_services.dart';
// import 'package:flutter_base_template/ui/my_button.dart';
// import 'package:flutter_base_template/ui/my_container.dart';
// import 'package:flutter_base_template/utils/format.dart';
// import 'package:provider/provider.dart';

// class StoreEditPage extends StatelessWidget {
//   const StoreEditPage({super.key, required this.member, required this.order});
//   final Order order;
//   final Member member;

//   void delete(context) async {
//     return showDialog<void>(
//       context: context,
//       // barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Theme.of(context).colorScheme.secondary,
//           title: const Text('حذف سفارش'),
//           content: SingleChildScrollView(child: Text("آیا اطمینان دارید؟‌")),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Provider.of<ApiServices>(context, listen: false)
//                     .cancelOrder( orderDetailId:  order.orderDetailId!, description: );

//                 Navigator.of(context)
//                   ..pop()
//                   ..pop();
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ApiServices>(builder: (context, service, child) {
//       // TO DO what is this? (is admin?)
//       // service.isAdmin;
//       return SafeArea(
//         child: Stack(
//           children: [
//             Scaffold(
//               backgroundColor: Theme.of(context).colorScheme.surface,
//               body: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Image.network(order.productImage ??
//                             "https://cdn.dsmcdn.com/ty1317/product/media/images/prod/QC/20240516/17/34be9935-13f9-3ce7-93e5-75ca472a3bbf/1_org_zoom.jpg"),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: MyContainer(
//                             color: Theme.of(context).colorScheme.surface,
//                             child: Column(
//                               children: [
//                                 MyContainer(
//                                   border: true,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         member.name!,
//                                         style: TextStyle(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .inversePrimary,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                       Text(
//                                         member.phone!,
//                                         style: TextStyle(
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .inversePrimary,
//                                           fontSize: 16,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 MyContainer(
//                                   color: Theme.of(context).colorScheme.surface,
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             'Size: ${(order.size ?? 'No Size')}',
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .inversePrimary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Color : ${(order.color!.isEmpty) ? 'No Color' : order.color}',
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .inversePrimary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Quantity : ${order.quantity}',
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .inversePrimary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           Text(
//                                             'Weight : ${order.weight ?? "No Weight"}',
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .inversePrimary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           // Text(
//                                           //   formatGregorianDate(
//                                           //       order.dateTime!),
//                                           //   style: TextStyle(
//                                           //     color: Theme.of(context)
//                                           //         .colorScheme
//                                           //         .inversePrimary,
//                                           //     fontSize: 16,
//                                           //   ),
//                                           // ),
//                                           Text(
//                                             formatNumber(order.price!),
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .inversePrimary,
//                                               fontSize: 16,
//                                             ),
//                                           ),
//                                           // Text(
//                                           // formatNumber(
//                                           //     order.orderDetails!.priceIr!),
//                                           // style: TextStyle(
//                                           //   color: Theme.of(context)
//                                           //       .colorScheme
//                                           //       .inversePrimary,
//                                           //   fontSize: 16,
//                                           // ),
//                                           // ),
//                                           // Text(
//                                           //   'Off: ${(order.orderDetails!.off != null) ? formatNumber(order.orderDetails!.off!) : '0'}',
//                                           //   style: TextStyle(
//                                           //     color: Theme.of(context)
//                                           //         .colorScheme
//                                           //         .inversePrimary,
//                                           //     fontSize: 16,
//                                           //   ),
//                                           // ),
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 20),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         'Total Price',
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           color: Theme.of(context)
//                                               .colorScheme
//                                               .primary,
//                                         ),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.end,
//                                         children: [
//                                           Text(
//                                             'TL ${formatNumber(order.price! * order.quantity!)}',
//                                             style: TextStyle(
//                                               color: Theme.of(context)
//                                                   .colorScheme
//                                                   .primary,
//                                             ),
//                                           ),
//                                           // Text(
//                                           //   'Toman ${formatNumber((order.orderDetails!.priceIr! * order.orderDetails!.quantity!) - order.orderDetails!.off!)}',
//                                           //   style: TextStyle(
//                                           //     color: Theme.of(context)
//                                           //         .colorScheme
//                                           //         .primary,
//                                           //   ),
//                                           // ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 // MyContainer(
//                                 //   color: Theme.of(context).colorScheme.surface,
//                                 //   // child: MyStepper(order: order),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                       ],
//                     ),
//                     MyButton(
//                       text: "Delete",
//                       color: Colors.red,
//                       paddingHorizontal: 10,
//                       paddingVertical: 10,
//                       marginHorizontal: 40,
//                       onTap: () => delete(context),
//                     ),
//                     const SizedBox(height: 100),
//                   ],
//                 ),
//               ),
//             ),
//             SafeArea(
//               child: Opacity(
//                 opacity: 0.9,
//                 child: Container(
//                   margin: EdgeInsets.only(
//                     left: Directionality.of(context) == TextDirection.ltr
//                         ? 25
//                         : 0,
//                     right: Directionality.of(context) == TextDirection.rtl
//                         ? 25
//                         : 0,
//                     top: 20,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).colorScheme.secondary,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back_ios_new),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

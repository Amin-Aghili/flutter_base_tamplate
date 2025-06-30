// import 'package:flutter/material.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_base_template/services/shop_info_service.dart';
// import 'package:provider/provider.dart';

// class ColorPickerDialog {
//   static void show(BuildContext context,
//       {Color initialColor = const Color.fromARGB(255, 49, 47, 47)}) async {
//     Color selectedColor = initialColor;
//     final service = Provider.of<ShopInfoService>(context, listen: false);

//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: SingleChildScrollView(
//             child: HueRingPicker(
//               pickerColor: selectedColor,
//               onColorChanged: (color) {
//                 selectedColor = color;
//               },
//               enableAlpha: false,
//               displayThumbColor: false,
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(),
//               child: Text("لغو"),
//             ),
//             TextButton(
//               onPressed: () async {
//                 service.updateShopInfo(
//                     fieldName: 'custom_color',
//                     newValue: '#${colorToHex(selectedColor).substring(2)}');
//                 Navigator.of(context).pop();
//               },
//               child: Text("تایید"),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

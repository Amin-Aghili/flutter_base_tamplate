// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:html' as html;

// class CopyableLink extends StatefulWidget {
//   final String productUrl;

//   const CopyableLink({super.key, required this.productUrl});

//   @override
//   State<CopyableLink> createState() => _CopyableLinkState();
// }

// class _CopyableLinkState extends State<CopyableLink> {
//   bool isCopied = false;

//   void copyToClipboard() {
//     Clipboard.setData(ClipboardData(text: widget.productUrl));
//     setState(() {
//       isCopied = true;
//     });

//     // بعد از چند ثانیه متن "کپی شد" را مخفی کن
//     Future.delayed(Duration(seconds: 2), () {
//       setState(() {
//         isCopied = false;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Text(
//           'لینک محصول:',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14.0,
//           ),
//         ),
//         SizedBox(width: 8), // فاصله بین متن و لینک
//         InkWell(
//           onTap: () {
//             html.window.open(widget.productUrl, 'url');
//           },
//           onLongPress: copyToClipboard, // هنگام نگه داشتن، لینک کپی می‌شود
//           child: Directionality(
//             textDirection: TextDirection.ltr,
//             child: Text(
//               '${widget.productUrl.substring(0, 24)}...',
//               style: TextStyle(
//                 color: Colors.blue,
//                 decoration: TextDecoration.underline,
//               ),
//             ),
//           ),
//         ),
//         if (isCopied) // اگر لینک کپی شد، متن "کپی شد" نمایش داده شود
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0),
//             child: Text(
//               "کپی شد!",
//               style: TextStyle(color: Colors.green, fontSize: 12.0),
//             ),
//           ),
//       ],
//     );
//   }
// }

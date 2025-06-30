import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;

class CopyableLink extends StatefulWidget {
  final String productUrl;

  const CopyableLink({super.key, required this.productUrl});

  @override
  State<CopyableLink> createState() => _CopyableLinkState();
}

class _CopyableLinkState extends State<CopyableLink> {
  bool isCopied = false;

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.productUrl));
    setState(() {
      isCopied = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isCopied = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'لینک محصول:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        // SizedBox(width: 8),
        InkWell(
          onTap: () {
            html.window.open(widget.productUrl, 'url');
          },
          onLongPress: copyToClipboard,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${widget.productUrl.substring(0, 24)}...',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        if (isCopied)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              "کپی شد!",
              style: TextStyle(color: Colors.green, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}

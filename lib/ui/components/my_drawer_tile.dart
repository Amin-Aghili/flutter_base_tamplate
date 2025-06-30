import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;
  final String? svgSrc;
  final Color textColor, iconColor;
  const MyDrawerTile({
    super.key,
    required this.title,
    this.icon,
    this.svgSrc,
    required this.onTap,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      iconColor: iconColor,
      textColor: textColor,
      title: Text(
        title,
        // style: TextStyle(color: Colors.white54),
      ),
      leading: (svgSrc) != null
          ? SvgPicture.asset(
              svgSrc!,
              colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
              height: 16,
            )
          : Icon(icon),
      onTap: onTap,
    );
  }
}

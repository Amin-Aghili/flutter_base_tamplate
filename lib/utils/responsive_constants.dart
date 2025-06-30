import 'package:flutter/material.dart';

class Responsive {
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }
}

class AppConstants {
  // Default Padding
  static double defaultPadding(BuildContext context) {
    if (Responsive.isDesktop(context)) return 32.0;
    if (Responsive.isTablet(context)) return 16.0;
    return 8.0; // Mobile
  }

  // Default Margin
  static double defaultMargin(BuildContext context) {
    if (Responsive.isDesktop(context)) return 24.0;
    if (Responsive.isTablet(context)) return 12.0;
    return 8.0; // Mobile
  }

  // Font Sizes
  static double defaultFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) return 18.0;
    if (Responsive.isTablet(context)) return 16.0;
    return 14.0; // Mobile
  }

  static double smallFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) return 14.0;
    if (Responsive.isTablet(context)) return 12.0;
    return 10.0; // Mobile
  }

  static double largeFontSize(BuildContext context) {
    if (Responsive.isDesktop(context)) return 24.0;
    if (Responsive.isTablet(context)) return 20.0;
    return 18.0; // Mobile
  }

  // Widget Sizes
  static double buttonHeight(BuildContext context) {
    if (Responsive.isDesktop(context)) return 56.0;
    if (Responsive.isTablet(context)) return 48.0;
    return 40.0; // Mobile
  }

  static double iconSize(BuildContext context) {
    if (Responsive.isDesktop(context)) return 32.0;
    if (Responsive.isTablet(context)) return 24.0;
    return 20.0; // Mobile
  }

  // Spacing between elements
  static double spacing(BuildContext context) {
    if (Responsive.isDesktop(context)) return 20.0;
    if (Responsive.isTablet(context)) return 16.0;
    return 12.0; // Mobile
  }

  // Border Radius
  static double borderRadius(BuildContext context) {
    if (Responsive.isDesktop(context)) return 12.0;
    if (Responsive.isTablet(context)) return 10.0;
    return 8.0; // Mobile
  }
}

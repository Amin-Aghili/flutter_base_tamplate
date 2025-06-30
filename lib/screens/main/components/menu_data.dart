import 'package:flutter/material.dart';
import 'package:flutter_base_template/screens/member/member_screen.dart';
import 'package:flutter_base_template/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_base_template/screens/order_management/order_management_screen.dart';
import 'package:flutter_base_template/l10n/app_localizations.dart';
import 'package:flutter_base_template/screens/shop/shop_screen.dart';
import 'package:flutter_base_template/screens/staff/staff_screen.dart';

// list of navigation pages
final List<Widget> navigationPages = [
  const DashboardScreen(),
  const OrderManagementScreen(),
  const ShopScreen(),
  const ContactScreen(),
  const StaffScreen(),
];

// list of navigation icons
final List<IconData> navigationIcons = [
  Icons.dashboard,
  Icons.storefront_sharp,
  Icons.attach_money_outlined,
  Icons.contacts_outlined,
  Icons.person_outline,
];

// function to get navigation titles based on the current locale
List<String> getNavigationTitles(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;
  return [
    l10n.navigation_dashboard,
    l10n.navigation_store,
    l10n.navigation_pay,
    l10n.navigation_contacts,
    l10n.navigation_staff,
  ];
}

import 'package:flutter/material.dart';
import 'package:flutter_base_template/controllers/menu_app_controller.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/screens/main/components/menu_data.dart';
import 'package:flutter_base_template/screens/settings/settings_screen.dart';
import 'package:flutter_base_template/services/auth_service.dart';
import 'package:flutter_base_template/ui/components/my_drawer_tile.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class SideMenu extends StatelessWidget {
  final void Function(Widget) onMenuItemClicked;

  const SideMenu({
    super.key,
    required this.onMenuItemClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MenuAppController>(
      builder: (context, menuAppController, child) {
        return Responsive.isDesktop(context)
            ? Container(
                color: Theme.of(context).colorScheme.surface,
                child: ListView(
                  children: _buildMenu(context, menuAppController),
                ),
              )
            : Drawer(
                child: ListView(
                  children: _buildMenu(context, menuAppController),
                ),
              );
      },
    );
  }

  List<Widget> _buildMenu(
      BuildContext context, MenuAppController menuAppController) {
    final l10n = AppLocalizations.of(context)!;
    // استفاده از متد getNavigationTitles برای عناوین محلی‌سازی‌شده
    final List<String> navigationTitles = getNavigationTitles(context);

    return [
      DrawerHeader(
        child: Image.asset("assets/images/logo.png"),
      ),
      if (!Responsive.isMobile(context))
        ...List.generate(
          navigationTitles.length,
          (index) => MyDrawerTile(
            iconColor: menuAppController.selectedIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
            textColor: menuAppController.selectedIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.inversePrimary,
            title: navigationTitles[index],
            icon: navigationIcons[index],
            onTap: () {
              onMenuItemClicked(navigationPages[index]);
              menuAppController.setSelectedIndex(index);
              if (Responsive.isMobile(context)) {
                Navigator.pop(context);
              }
            },
          ),
        ),
      MyDrawerTile(
        title: l10n.settings,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsScreen()),
          );
        },
        icon: Icons.settings,
        iconColor: Theme.of(context).colorScheme.inversePrimary,
        textColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      const SizedBox(height: 40),
      const Spacer(),
      MyDrawerTile(
        title: l10n.logout,
        onTap: () async =>
            await Provider.of<AuthService>(context, listen: false).logout(),
        icon: Icons.logout_sharp,
        iconColor: Theme.of(context).colorScheme.inversePrimary,
        textColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      const SizedBox(height: 20),
    ];
  }
}

import 'package:flutter_base_template/controllers/menu_app_controller.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/screens/main/components/bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _currentScreen = DashboardScreen();

  void _updateScreen(Widget newScreen) {
    setState(() {
      _currentScreen = newScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(onMenuItemClicked: _updateScreen),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(onMenuItemClicked: _updateScreen),
              ),

            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Stack(
                children: [
                  _currentScreen,
                  if (Responsive.isMobile(context))
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: BottomNavigation(
                        onMenuItemClicked: _updateScreen,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

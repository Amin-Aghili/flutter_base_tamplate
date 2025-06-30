import 'package:flutter/material.dart';
import 'package:flutter_base_template/controllers/menu_app_controller.dart';
import 'package:flutter_base_template/screens/main/components/menu_data.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatefulWidget {
  final void Function(Widget) onMenuItemClicked;

  const BottomNavigation({
    super.key,
    required this.onMenuItemClicked,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation>
    with WidgetsBindingObserver {
  late bool _showBottomNavBar;
  bool showText = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _showBottomNavBar = View.of(context).viewInsets.bottom == 0;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    setState(() {
      _showBottomNavBar = View.of(context).viewInsets.bottom == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final menuAppController = Provider.of<MenuAppController>(context);
    final navigationTitles = getNavigationTitles(context);

    return _showBottomNavBar
        ? Container(
            height: 60,
            margin: const EdgeInsets.only(bottom: 25, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.shadow,
                  blurRadius: 9,
                  spreadRadius: 0.3,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                navigationIcons.length,
                (index) => Expanded(
                  child: _buildNavBarItem(
                      index, menuAppController, navigationTitles),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildNavBarItem(int index, MenuAppController menuAppController,
      List<String> navigationTitles) {
    final isSelected = menuAppController.selectedIndex == index;

    BorderRadius borderRadius = BorderRadius.zero;

    if (index == 0) {
      borderRadius = const BorderRadius.only(
        topRight: Radius.circular(10),
        bottomRight: Radius.circular(10),
      );
    } else if (index == navigationIcons.length - 1) {
      borderRadius = const BorderRadius.only(
        topLeft: Radius.circular(10),
        bottomLeft: Radius.circular(10),
      );
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () => _onNavItemTapped(index, menuAppController),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                navigationIcons[index],
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.inversePrimary,
              ),
              if (isSelected && showText)
                Text(
                  navigationTitles[index],
                  style: TextStyle(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNavItemTapped(int index, MenuAppController menuAppController) {
    menuAppController.setSelectedIndex(index);
    widget.onMenuItemClicked(navigationPages[index]);
  }
}

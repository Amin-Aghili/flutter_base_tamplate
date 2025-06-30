import 'package:flutter/material.dart';
import 'package:flutter_base_template/models/shop.dart';
import '../../../l10n/app_localizations.dart';
import 'shipping_steps_extension.dart';

class MyTabBar extends StatefulWidget {
  final TabController tabController;
  final List<Color> tabColors;
  final List<IconData> iconData;
  const MyTabBar({
    super.key,
    required this.tabController,
    required this.tabColors,
    required this.iconData,
  });

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.tabController.index;
    widget.tabController.addListener(() {
      setState(() {
        currentIndex = widget.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return TabBar(
      labelPadding: EdgeInsets.all(8),
      labelColor: Colors.amber,
      labelStyle: TextStyle(fontSize: 10),
      unselectedLabelColor: Theme.of(context).colorScheme.surface,
      unselectedLabelStyle: TextStyle(fontSize: 8),
      indicatorColor: Colors.amber,
      dividerColor: Theme.of(context).colorScheme.surface,
      controller: widget.tabController,
      tabs: List.generate(
        ShippingSteps.values.length,
        (index) {
          final ShippingSteps step = ShippingSteps.values[index];

          return Center(
            child: Column(
              children: [
                Icon(
                  widget.iconData[index],
                ),
                Text(
                  step.localizedStep(l10n),
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


// Create Custom Full Color tab bar with '"amin aghili "'


// import 'package:flutter/material.dart';
// import 'package:flutter_base_template/models/shop.dart';
// import '../../../l10n/app_localizations.dart';
// import 'shipping_steps_extension.dart';

// class MyTabBar extends StatefulWidget {
//   final TabController tabController;
//   final List<Color> tabColors;
//   final List<IconData> iconData;
//   const MyTabBar({
//     super.key,
//     required this.tabController,
//     required this.tabColors,
//     required this.iconData,
//   });

//   @override
//   State<MyTabBar> createState() => _MyTabBarState();
// }

// class _MyTabBarState extends State<MyTabBar> {
//   late int currentIndex;
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.tabController.index;
//     widget.tabController.addListener(() {
//       setState(() {
//         currentIndex = widget.tabController.index;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//     return Container(
//       color: Theme.of(context).colorScheme.secondary,
//       child: TabBar(
//         indicator: BoxDecoration(
//             // color: Colors.amber.shade100,
//             // borderRadius: BorderRadius.only(
//             //     topLeft: Radius.circular(8), topRight: Radius.circular(8)),
//             ),
//         // labelColor: Theme.of(context).colorScheme.primary,
//         labelPadding: EdgeInsets.zero,
//         // indicatorColor: Colors.red,
//         // indicatorColor: Theme.of(context).colorScheme.primary,

//         // labelColor: widget.tabColors[widget.tabController.index],
//         labelColor: Theme.of(context).colorScheme.primary,
//         unselectedLabelColor: Colors.amber,

//         // unselectedLabelColor: Theme.of(context).colorScheme.inversePrimary,
//         // dividerColor: widget.tabColors[widget.tabController.index],
//         dividerColor: Theme.of(context).colorScheme.onSecondary,
//         dividerHeight: 5,
//         controller: widget.tabController,
//         tabs: List.generate(
//           ShippingSteps.values.length,
//           (index) {
//             bool isSelected = currentIndex == index;
//             final ShippingSteps step = ShippingSteps.values[index];

//             return Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).colorScheme.onSecondary,
//                 // color: widget.tabColors[index % widget.tabColors.length],

//                 // color: isSelected
//                 //     ? widget.tabColors[index % widget.tabColors.length]
//                 //         .withOpacity(0.8)
//                 //     : Colors.grey.shade300,
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(8.0),
//                   topRight: Radius.circular(8.0),
//                 ),
//               ),
//               margin: const EdgeInsets.only(left: 2.0, right: 2, top: 5),
//               padding: EdgeInsets.only(
//                 top: isSelected ? 12.0 : 9.0,
//                 bottom: isSelected ? 12.0 : 9.0,
//                 left: 12.0,
//                 right: 12.0,
//               ),
//               child: Center(
//                 child: Column(
//                   children: [
//                     Icon(
//                       widget.iconData[index],
//                       color: (isSelected)
//                           ? Theme.of(context).colorScheme.onTertiary
//                           : Theme.of(context).colorScheme.surface,
//                     ),
//                     Text(
//                       step.localizedStep(l10n),
//                       style: TextStyle(
//                         fontSize: isSelected ? 10.0 : 8.0,
//                         fontWeight:
//                             isSelected ? FontWeight.bold : FontWeight.normal,
//                         color: isSelected
//                             ? Theme.of(context).colorScheme.onTertiary
//                             : Theme.of(context).colorScheme.surface,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

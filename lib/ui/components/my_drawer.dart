import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    // final authService = AuthService();
    // authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Icon(
              Icons.lock_open_outlined,
              color: Theme.of(context).colorScheme.primary,
              size: 80,
            ),
            const SizedBox(height: 10),
            // Text(Provider.of<ApiServices>(context)
            //     .employees
            //     .first
            //     .fullName
            //     .toString()),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Divider(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            // Drawer Tiles
            // MyDrawerTile(
            //   title: "H O M E",
            //   icon: Icons.home,
            //   onTap: () {
            //     Navigator.pop(context);
            //   },
            // ),
            const SizedBox(height: 6),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}

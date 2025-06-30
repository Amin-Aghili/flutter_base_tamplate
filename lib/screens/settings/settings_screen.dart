import 'package:flutter/material.dart';
import 'package:flutter_base_template/l10n/app_localizations.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/screens/main/components/language_selector.dart';
import 'package:flutter_base_template/screens/main/components/theme_selector.dart';
import 'package:flutter_base_template/ui/components/my_container.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        title: Text(AppLocalizations.of(context)!.settings),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: MyContainer(
            width: (!Responsive.isMobile(context)) ? 800 : double.infinity,
            child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: (!Responsive.isMobile(context)) ? 2 : 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 2,
                childAspectRatio: 6,
              ),
              shrinkWrap: true,
              physics: ScrollPhysics(),
              children: [
                const LanguageSelector(),
                const ThemeSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

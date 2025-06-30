import 'package:flutter/material.dart';
import 'package:flutter_base_template/screens/dashboard/components/my_switch.dart';
import 'package:flutter_base_template/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return MySwitch(
        marginHorizontal: 2,
        value: Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn,
        onChanged: (bool value) =>
            Provider.of<ThemeProvider>(context, listen: false)
                .toggleTheme(context),
        title: AppLocalizations.of(context)!.darkMode);
  }
}

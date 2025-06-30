import 'package:flutter/material.dart';
import 'package:flutter_base_template/l10n/language_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return DropdownButton<String>(
      isExpanded: true,
      padding: EdgeInsets.symmetric(horizontal: 15),
      focusColor: Theme.of(context).colorScheme.surface,
      underline: Container(),
      value: languageProvider.currentLocale.languageCode,
      dropdownColor: Theme.of(context).colorScheme.surface,
      icon: const Icon(Icons.language),
      items: const [
        DropdownMenuItem(
          value: 'en',
          child: Text('English'),
        ),
        DropdownMenuItem(
          value: 'fa',
          child: Text('فارسی'),
        ),
        DropdownMenuItem(
          value: 'tr',
          child: Text('Türkçe'),
        ),
      ],
      onChanged: (String? value) {
        if (value != null) {
          languageProvider.changeLocale(value);
        }
      },
    );
  }
}

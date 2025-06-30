import 'package:flutter/material.dart';
import 'package:flutter_base_template/constants.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter_base_template/ui/components/search_field.dart';
import '../../../l10n/app_localizations.dart';

class Header extends StatelessWidget {
  final TextEditingController searchController;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanged;

  const Header({
    super.key,
    required this.searchController,
    this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 3),
      child: Row(
        children: [
          const SizedBox(width: 10),
          if (!Responsive.isMobile(context))
            Text(
              AppLocalizations.of(context)!.store,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          if (!Responsive.isMobile(context))
            SizedBox(
              width: Responsive.isDesktop(context) ? 100 : 30,
            ),
          Expanded(
            child: SearchField(
              controller: searchController,
              onChanged: onChanged,
            ),
          ),
          if (!Responsive.isMobile(context))
            SizedBox(
              width: Responsive.isDesktop(context) ? 100 : 30,
            ),
        ],
      ),
    );
  }
}

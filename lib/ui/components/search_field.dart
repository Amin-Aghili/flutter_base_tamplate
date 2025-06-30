import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_base_template/constants.dart';
import '../../l10n/app_localizations.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onSearch;
  final ValueChanged<String>? onChanged;
  const SearchField({
    super.key,
    required this.controller,
    this.onSearch,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.search,
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: (onSearch == null)
            ? Padding(
                padding: const EdgeInsets.all(defaultPadding * 0.75),
                child: SvgPicture.asset("assets/icons/Search.svg"))
            : InkWell(
                onTap: onSearch,
                child: Container(
                  padding: const EdgeInsets.all(defaultPadding * 0.75),
                  margin: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
              ),
      ),
      onSubmitted: (_) => onSearch?.call(),
    );
  }
}

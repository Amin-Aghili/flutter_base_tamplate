import 'package:flutter_base_template/controllers/menu_app_controller.dart';
import 'package:flutter_base_template/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_template/ui/components/profile_card.dart';
// import 'package:flutter_base_template/ui/search_field.dart';

import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Provider.of<MenuAppController>(context, listen: false)
                  .controlMenu();
            },
          ),
        SizedBox(width: 10),
        if (!Responsive.isMobile(context))
          Text(
            AppLocalizations.of(context)!.dashboard,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        if (!Responsive.isMobile(context))
          SizedBox(
            width: Responsive.isDesktop(context) ? 100 : 30,
          ),
        // Expanded(
        //   child: SearchField(controller: TextEditingController(),),
        // ),
        SizedBox(width: 10),
        if (!Responsive.isMobile(context))
          SizedBox(
            width: Responsive.isDesktop(context) ? 100 : 30,
          ),
        const ProfileCard()
      ],
    );
  }
}

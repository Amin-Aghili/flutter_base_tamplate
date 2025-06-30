import 'package:flutter_base_template/models/shop.dart';

import '../../../l10n/app_localizations.dart';

extension ShippingStepsExtension on ShippingSteps {
  String localizedStep(AppLocalizations l10n) {
    switch (this) {
      case ShippingSteps.paymentConfirmation:
        return l10n.paymentConfirmation;
      case ShippingSteps.receiving:
        return l10n.receiving;
      case ShippingSteps.shipping:
        return l10n.shipping;
      case ShippingSteps.orderPlacement:
        return l10n.orderPlacement;
      case ShippingSteps.iranPost:
        return l10n.iranPost;
    }
  }
}

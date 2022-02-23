import 'package:flutter/material.dart';
import 'package:scs_latakia_app/l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;
  set locale(Locale? value) {
    if (!L10n.all.contains(value)) return;

    _locale = value;
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}

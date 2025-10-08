import 'package:flutter/material.dart';
import '../services/preferences_service.dart';

class ThemeNotifier extends ValueNotifier<bool> {
  ThemeNotifier(bool value) : super(value);

  void toggle(bool isDark) async {
    value = isDark;
    await PreferencesService.setDarkMode(isDark);
    notifyListeners();
  }
}

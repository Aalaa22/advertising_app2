import 'package:flutter/material.dart';

class LocaleChangeNotifier extends ChangeNotifier {
  Locale _locale = const Locale('en'); // اللغة الافتراضية

  /// Getter للوصول للّغة الحالية
  Locale get locale => _locale;

  /// تغيير اللغة من عربي ↔ إنجليزي
  void toggleLocale() {
    _locale = _locale.languageCode == 'en'
        ? const Locale('ar')
        : const Locale('en');
    notifyListeners(); // يخبر GoRouter بتحديث الواجهة
  }
}

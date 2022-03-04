import 'package:flutter/cupertino.dart';

class FallbackLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<CupertinoLocalizations> load(Locale locale) async =>
      DefaultCupertinoLocalizations();
  @override
  bool shouldReload(_) => false;
}

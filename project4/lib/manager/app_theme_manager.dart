import 'package:flutter/cupertino.dart';
import 'package:project4/utils/storages.dart';
import 'package:provider/provider.dart';

class AppThemeManager with ChangeNotifier {
  bool isDarkMode = false;
  final Storages _storage = Storages.instance;
  Future<void> setIsDarkMode(bool darkMode) async {
    await _storage.setDarkMode(darkMode);
    isDarkMode = darkMode;
    notifyListeners();
  }
}
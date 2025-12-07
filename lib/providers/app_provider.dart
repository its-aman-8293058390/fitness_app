import 'package:flutter/material.dart';

class AppProvider with ChangeNotifier {
  bool _isDarkMode = false;
  bool _showOnboarding = true;

  bool get isDarkMode => _isDarkMode;
  bool get showOnboarding => _showOnboarding;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void completeOnboarding() {
    _showOnboarding = false;
    notifyListeners();
  }
}
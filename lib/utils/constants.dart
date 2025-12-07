import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF4CAF50);
  static const secondary = Color(0xFF8BC34A);
  static const accent = Color(0xFFFFC107);
  static const backgroundLight = Color(0xFFF5F5F5);
  static const backgroundDark = Color(0xFF121212);
  static const cardLight = Colors.white;
  static const cardDark = Color(0xFF1E1E1E);
  static const textPrimaryLight = Colors.black87;
  static const textSecondaryLight = Colors.black54;
  static const textPrimaryDark = Colors.white;
  static const textSecondaryDark = Colors.white70;
}

class AppGradients {
  static const primaryGradient = LinearGradient(
    colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppDimensions {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 12.0;
  static const double borderRadiusLarge = 16.0;
  static const double cardElevation = 4.0;
}
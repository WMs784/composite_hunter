import 'package:flutter/material.dart';

class UIConstants {
  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXl = 32.0;
  
  // Border radius
  static const double borderRadiusS = 4.0;
  static const double borderRadiusM = 8.0;
  static const double borderRadiusL = 12.0;
  static const double borderRadiusXl = 16.0;
  
  // Grid layout
  static const int primeGridCrossAxisCount = 4;
  static const double primeGridAspectRatio = 1.0;
  static const double primeGridSpacing = 8.0;
  
  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 500);
  static const Duration longAnimation = Duration(milliseconds: 1000);
  
  // Timer colors
  static const Color timerNormalColor = Colors.green;
  static const Color timerWarningColor = Colors.orange;
  static const Color timerCriticalColor = Colors.red;
  static const Color timerExpiredColor = Colors.grey;
  
  // Power enemy colors
  static const List<Color> powerEnemyGradient = [
    Colors.purple,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];
}
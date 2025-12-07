import 'package:flutter/material.dart';

class AppColors {
  static const Color voidBlack = Color(0xFF050505);
  static const Color neonCyan = Color(0xFF00F3FF);
  static const Color neonCrimson = Color(0xFFFF0055);
  static const Color darkGlass = Color(0x99000000); // Transparent black for glass effect
}

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.voidBlack,
    primaryColor: AppColors.neonCyan,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.neonCyan,
      error: AppColors.neonCrimson,
      background: AppColors.voidBlack,
      surface: AppColors.voidBlack,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        fontFamily: 'Courier', // Terminal style
        color: AppColors.neonCyan,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Courier',
        fontWeight: FontWeight.bold,
        color: AppColors.neonCyan,
      ),
    ),
  );
}

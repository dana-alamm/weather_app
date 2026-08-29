import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/core/widgets/app_background.dart';

class AppColors {
  static const Color subtitle=Color.fromARGB(15, 26, 25, 25);
  static const Color GreyColor=Color.fromARGB(255, 128, 131, 133);
  static const Color blueColor=Color(0xff4D81E7);
  static const Color anotherBlue=Color(0xFF2D3561);
  static const Color thirdBlue=Color(0xff3A5A8A);
  static const Color PortGore=Color.fromARGB(26, 4, 18, 110);
  static const Color circleShape1=Color(0xff7FACFA);
  static const Color circleShape2=Color(0xff1A1E3A);
  static const Color shadowColor=Color(0xff90A4AE);
  static const Color DarkText=Color(0xFF1E293B);

  static const Color blueAccent = Color(0xFF4A90E2);
  static const Color skyBlue = Color(0xFF5A98FC);
  static const Color darkCardBg =Color(0xFF232B42);
static const Color darkTextPrimary = Colors.white;
  static const Color darkTextSecondary = Color(0xFF8E9BB5);

  static final ThemeData lightTheme=ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: AppColors.blueColor,
  cardColor: Colors.white,
  textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFF1E293B)),
      bodyMedium: TextStyle(color: AppColors.GreyColor),
    ),
  );
  static final ThemeData darkTheme=ThemeData(
    brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.transparent,
  primaryColor: AppColors.skyBlue,
  cardColor: AppColors.darkCardBg,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
      bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
  )

  );
}

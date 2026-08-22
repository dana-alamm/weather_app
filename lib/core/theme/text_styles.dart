import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/core/theme/app_colors.dart';

abstract class TextStyles {
  static const TextStyle Heading1 = TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.64,
  );
  static const TextStyle subHeading = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.32,
    color: Color(0xff6B7280),
  );
  static const TextStyle label = TextStyle(
    fontFamily: 'Inter',
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.0,
  );
  static const TextStyle dateStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 17,
    height: 1.0,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
    color: AppColors.thirdBlue,
  );
  static const TextStyle cityNameStyle = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.3,
  );
  static const TextStyle firstLetter = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
    color: Colors.white,
    fontSize: 14,
  );
  static const TextStyle temperatureNum = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w300,
    fontSize: 52,
    height: 1.0,
    color: Colors.black,
  );
  static const TextStyle WeatherToday = TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 20,
    height: 1.0,
    color: Colors.black,
  );
  static const TextStyle maxandMinTemperature = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1,
    color: Colors.black,
  );
  static const TextStyle feelsTemp = TextStyle(
    fontFamily: 'Inter',
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1,
    color: Colors.white,
  );

  static final TextStyle staticWord = GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.0,
    letterSpacing: 1.2,
    color: AppColors.circleShape2,
  );
  static final TextStyle savenDaysForcast = GoogleFonts.dmSans(
    fontSize: 12,
    height: 1.0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.circleShape1,
    color: AppColors.circleShape1,
    decorationStyle: TextDecorationStyle.solid,
  );
  static final TextStyle timeStyle = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.0,
    letterSpacing: 0.3,
    //color: AppColors.circleShape2
  );
  static final TextStyle valueStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 24,
    fontWeight: FontWeight.w500,
    height: 1.16,
    color: Colors.black,
  );
  static final TextStyle unitStyle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
  static TextStyle cityName = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 15,
    height: 1,
    color: Color(0xff2D3561),
  );
  static TextStyle countryName=GoogleFonts.dmSans(
   fontWeight: FontWeight.w400,
   fontSize: 12,
   height: 1,
   color: Colors.grey,
  );
  static TextStyle recentTemp=GoogleFonts.dmSans(
  fontWeight: FontWeight.w400,
  fontSize: 22,
  height: 1,
  color:Colors.black,
  );
  static const TextStyle dayName=TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1,
  );
}

import 'package:flutter/material.dart';

abstract class TextStyles {
  static const TextStyle Heading1=TextStyle(
    fontFamily: 'Inter',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.3,
   letterSpacing: -0.64,
  );
  static const TextStyle subHeading=TextStyle(
    fontFamily: 'Inter',
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.32,
    color:Color(0xff6B7280),
  );
  
}
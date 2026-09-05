import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/weather_provider.dart';

class TempText extends StatelessWidget {
  final double? temp;
   final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final double? symbolFontSize;

  const TempText({
    super.key, 
    this.temp, 
     required this.fontSize, 
    this.fontWeight=FontWeight.bold, 
    this.color, 
    this.symbolFontSize});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    final weatherProvider = Provider.of<WeatherProvider>(context);
    final defaultColor=isDark?Colors.white:const Color(0xFF1E293B);
    final effectiveColor=color??defaultColor;

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${weatherProvider.formatTemp(temp)}',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: effectiveColor,
            ),
          ),
          TextSpan(
            text: weatherProvider.tempSymbol,
            style: TextStyle(
              fontSize: symbolFontSize ?? (fontSize * 0.65), 
              fontWeight: FontWeight.w600,
              color: effectiveColor.withOpacity(0.8),
            ),
          )
        ]
        ),
    );
  }
}
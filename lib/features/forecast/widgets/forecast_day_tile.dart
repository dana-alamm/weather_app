import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class DailyForeCast {
  final String dayName;
  final String dateText;
  final String condition;
  final int minTemp;
  final int maxTemp;
  final String iconPath;
  final Color barColor;
  const DailyForeCast({
    required this.dayName,
    required this.dateText,
    required this.condition,
    required this.minTemp,
    required this.maxTemp,
    required this.iconPath,
    this.barColor = const Color(0xFF60A5FA),
  });
}

class ForecastDayTile extends StatelessWidget {
  final DailyForeCast forecast;
  const ForecastDayTile({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(forecast.dayName, style: TextStyles.dayName),
                SizedBox(height: 2),
                Text(forecast.dateText, style: TextStyles.subHeading),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            forecast.iconPath,
            width: 38,
            height: 38,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.wb_sunny_rounded,
              color: Colors.amber,
              size: 32,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              forecast.condition,
              style: TextStyles.subHeading.copyWith(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${forecast.minTemp}°", 
              style: TextStyles.subHeading
              ),
              const SizedBox(width: 8,),
              Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                  color: forecast.barColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${forecast.maxTemp}°",
                style: TextStyles.subHeading,
              )
            ],
          ),
        ],
      ),
    );
  }
}

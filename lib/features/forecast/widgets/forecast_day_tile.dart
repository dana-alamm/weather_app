import 'package:flutter/material.dart';
import 'package:weather_app/core/models/daily_weather_model.dart';

import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';



class ForecastDayTile extends StatelessWidget {

  final DailyWeatherModel forecast;
  const ForecastDayTile({super.key, required this.forecast});

  Color _getBarColor(double temp){
    if(temp<=15){
      return AppColors.circleShape1;
    }else if(temp<=12){
   return Color(0xFF60A5FA);
    }else{
      return const Color(0xFFFBBF24);
    }

  }

  @override
  Widget build(BuildContext context) {
      final isDark=Theme.of(context).brightness==Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        //color: Colors.white,
        color:isDark?AppColors.darkCardBg:Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(forecast.dayName, style: TextStyles.dayName.copyWith(
                  color:isDark?Colors.white:Colors.black,
                )),
                SizedBox(height: 2),
                Text(forecast.FormattedDate, style: TextStyles.subHeading),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Image.asset(
            forecast.assetIcon,
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
              Text("${forecast.minTemp.round()}°", 
              style: TextStyles.subHeading
              ),
              const SizedBox(width: 8,),
              Container(
                width: 36,
                height: 5,
                decoration: BoxDecoration(
                 color:_getBarColor((forecast.minTemp+forecast.maxTemp)/2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "${forecast.maxTemp.round()}°",
                style: TextStyles.subHeading,
              )
            ],
          ),
        ],
      ),
    );
  }
}

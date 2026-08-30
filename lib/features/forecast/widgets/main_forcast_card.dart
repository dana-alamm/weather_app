import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/models/current_weather_model.dart';
import 'package:weather_app/core/models/hourly_weather_model.dart';

import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/widgets/hourly_forecast_card.dart';

class MainForcastCard extends StatelessWidget {
   
   final CurrentWeatherModel weather;
   final List<HourlyWeatherModel>hourly;
   const MainForcastCard({super.key, required this.weather, required this.hourly,});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
  final formattedDate= DateFormat('EEE d MMM').format(DateTime.now());

   final maxTemp=hourly.isNotEmpty
      ? hourly.map((e) => e.temp).reduce((a, b) => a > b ? a : b)
        : weather.temp;

    final minTemp =hourly.isNotEmpty
        ? hourly.map((e) => e.temp).reduce((a, b) => a < b ? a : b)
        : weather.temp;


    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        //color:Colors.white,
        color:isDark?AppColors.darkCardBg:Colors.white,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset(
          weather.assetIcon,
          width: 58,
            height: 58,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.cloud,
              size: 50,
              color: Colors.blueAccent,
            ),
        ),
        const SizedBox(width: 16,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                 '${weather.temp.round()}°',
                style: TextStyles.temperatureNum.copyWith(
                  fontSize: 34,
                  color: isDark?Colors.white:Colors.black
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                weather.condition,
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  const Icon(
                      Icons.arrow_upward,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    Text(
                      ' ${maxTemp.round()}° ',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_downward,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    Text(
                     '${minTemp.round()}°',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                ],
              )
            ],
          )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Today',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 2,),
              Text(
                formattedDate,
                style: TextStyles.subHeading,
              )
            ],
          )
        
        ],
      ),
    );
  }
}
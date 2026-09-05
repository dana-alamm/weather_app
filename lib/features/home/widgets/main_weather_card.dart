import 'package:flutter/material.dart';

import 'package:weather_app/core/models/current_weather_model.dart';
import 'package:weather_app/core/models/hourly_weather_model.dart';

import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/temp_text.dart';


class MainWeatherCard extends StatelessWidget {
  final  CurrentWeatherModel weather;
  final List<HourlyWeatherModel> hourly;
  const MainWeatherCard({super.key, required this.weather, required this.hourly});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
   
    final maxTemp = hourly.isNotEmpty
        ? hourly.map((e) => e.temp).reduce((a, b) => a > b ? a : b)
        : weather.temp;

    final minTemp =hourly.isNotEmpty
        ? hourly.map((e) => e.temp).reduce((a, b) => a < b ? a : b)
        : weather.temp;
    return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
    decoration: BoxDecoration(
      //color:Colors.white,
      color: isDark ? AppColors.darkCardBg : Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: isDark ? Colors.white.withOpacity(0.06) : Colors.transparent,
      ),
    boxShadow: [
      BoxShadow(
        
        color: isDark
                ? Colors.black.withOpacity(0.25)
                : AppColors.shadowColor.withOpacity(0.12),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: SizedBox(
          
            child: Image.asset(
              
             weather.assetIcon,
                width: 80,
                height: 80,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.cloudy_snowing,
                size: 80,
              ),
            ),
          )
          ),
          const SizedBox(width: 8,),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                 
                  TempText(
                    temp: weather.temp,
                    fontSize: 52,
                  ),
                  const SizedBox(height: 4,),
                  Text(
                    weather.condition,
                    style:TextStyles.WeatherToday.copyWith(
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_upward,size: 13,
                      //color:Colors.black
                      color: isDark ? const Color(0xFFCBD5E1) : Colors.black87,
                      ),
                      
                      TempText(
                        temp: maxTemp,
                        fontSize:13
                        ),
                      SizedBox(width: 15,),
                      Icon(Icons.arrow_downward,size: 13,
                      //color: Colors.black,
                      color: isDark ? const Color(0xFFCBD5E1) : Colors.black87,
                      ),
                      
                      TempText(
                        temp: minTemp,
                        fontSize: 13,
                        )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14,vertical: 4),
                    decoration: BoxDecoration(
                      //color:Colors.black,
                      color: isDark
                          ? const Color(0xFF333E5E) 
                          : Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                   
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Feels',
                          style: TextStyles.feelsTemp.copyWith(
          color: Colors.white,
        ),
                        ),
                        TempText(
                     temp: weather.feelsLike,
                    fontSize: 12, 
                 color: Colors.white,
      ),
                      ],
                    ),
                  )
                ],
              ),
              )
          ),
      ],
    ),

    );
  }
}
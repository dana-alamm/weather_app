import 'package:flutter/material.dart';
import 'package:weather_app/core/helpers/weather_icon_helper.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class MainWeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const MainWeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor.withOpacity(0.12),
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
                //'assets/images/rain_cloud.png',
                getWeatherAssetIcon(weather.icon),
                width: 80,
                height: 80,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.cloudy_snowing, size: 80),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${weather.temp.round()}°',
                    style: TextStyles.temperatureNum,
                  ),
                  const SizedBox(height: 4),
                  Text(weather.condition, style: TextStyles.WeatherToday),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.arrow_upward,
                        size: 13,
                        color: Colors.black,
                      ),
                      Text('13.7°', style: TextStyles.maxandMinTemperature),
                      SizedBox(width: 15),
                      Icon(Icons.arrow_downward, size: 13, color: Colors.black),
                      Text('9.9°', style: TextStyles.maxandMinTemperature),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      'Feels ${weather.feelsLike.round()}°',
                      style: TextStyles.feelsTemp,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

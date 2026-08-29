import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/widgets/detail_card.dart';

class WeatherDetailsSection extends StatelessWidget {
  final CurrentWeatherModel weather;
  const WeatherDetailsSection({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    final visibilityKm = (weather.visibility / 1000).toStringAsFixed(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: TextStyles.staticWord.copyWith(
          color:isDark?Colors.grey:Colors.black,
        )),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: [
            DetailCard(
              title: 'HUMIDITY',
              value: '${weather.humidity}',
              unit: '%',
              description: weather.humidity > 60 ? 'High' : 'Moderate',
            ),
            DetailCard(
              title: 'WIND',
              value: "${weather.windSpeed}",
              unit: 'm/s',
              description: 'Gusts ${weather.windSpeed}',
            ),
            DetailCard(
              title: 'PRESSURE',
              value: '${weather.pressure}',
              unit: 'hPa',
              description: weather.pressure > 1020
                  ? 'Sea level · High'
                  : (weather.pressure < 1005
                        ? 'Sea level · Low'
                        : 'Sea level · Normal'),
            ),
            DetailCard(
              title: 'VISIBILITY',
              value: visibilityKm,
              unit: 'km',
              description: weather.visibility >= 10000
                  ? 'Clear sight'
                  : 'Low sight',
            ),
          ],
        ),
      ],
    );
  }
}

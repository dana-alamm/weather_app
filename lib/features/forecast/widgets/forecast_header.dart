import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';

class ForecastHeader extends StatelessWidget {
  const ForecastHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final cityName = context.watch<WeatherProvider>().cityName;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: AppColors.thirdBlue,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    cityName,
                    style: TextStyles.subHeading,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '7-Day Forecast',
                style: TextStyles.Heading1,
              ),
            ],
          ),
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  AppColors.circleShape1,
                  AppColors.circleShape2,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF364F8B),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyles.firstLetter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
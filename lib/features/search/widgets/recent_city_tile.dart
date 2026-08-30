import 'package:flutter/material.dart';
import 'package:weather_app/core/models/search_result_weather_model.dart';

import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class RecentCityTile extends StatelessWidget {
  final SearchResultWeatherModel city;
  final VoidCallback onTap;
  const RecentCityTile({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          //color: Colors.white,
          color:isDark?AppColors.darkCardBg:Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                //color: const Color(0xFFF1F5F9),
                color: isDark?AppColors.darkCardBg:Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.location_on_outlined,
                color: Color(0xFF4A90E2),
                size: 20,
              ),
            ),
            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(city.cityName, style: TextStyles.cityName.copyWith(
                    color:isDark?Colors.white:Color(0xff2D3561),
                  )),
                  const SizedBox(height: 2),
                  Text(city.subtitle, style: TextStyles.subHeading),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${city.temp.round()}°', style: TextStyles.recentTemp.copyWith(
                  color:isDark?Colors.white:Color(0xff2D3561),
                )),
                Text(city.condition, style: TextStyles.countryName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

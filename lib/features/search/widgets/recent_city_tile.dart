import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class RecentCityTile extends StatelessWidget {
  final SearchResultWeatherModel city;
  final VoidCallback onTap;
  const RecentCityTile({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
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
                  Text(city.cityName, style: TextStyles.cityName),
                  const SizedBox(height: 2),
                  Text(city.subtitle, style: TextStyles.subHeading),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${city.temp.round()}°', style: TextStyles.recentTemp),
                Text(city.condition, style: TextStyles.countryName),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

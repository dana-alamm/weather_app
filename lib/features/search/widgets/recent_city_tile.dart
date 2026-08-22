import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class RecentCity{
  final String name;
  final String country;
  final int temperature;
  final String condition;
  final String imageUrl;

  const RecentCity({
  required this.name, 
  required this.country, 
  required this.temperature, 
  required this.condition, 
  required this.imageUrl,
  
});

}


class RecentCityTile extends StatelessWidget {
  final RecentCity city;
  final VoidCallback onTap;
  const RecentCityTile({super.key, required this.city, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
    onTap:onTap,
    borderRadius: BorderRadius.circular(14),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              city.imageUrl,
              width: 52,
              height: 52,
              fit:BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(Icons.location_city, color: Colors.blueGrey),
            ),
          ),
          ),
          const SizedBox(width: 14,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city.name,
                  style: TextStyles.cityName,
                ),
                const SizedBox(height: 3,),
                Text(
                  city.country,
                  style: TextStyles.countryName,
                )
              ],
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${city.temperature}°',
                style: TextStyles.recentTemp,
              ),
              Text(
                city.condition,
                style: TextStyles.countryName,
              ),
            ],
          )
        ],
      ),
      ),

    );
  }
}
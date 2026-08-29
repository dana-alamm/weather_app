import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/helpers/weather_icon_helper.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/app_colors.dart'; 
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/search/providers/search_provider.dart';

class SearchResultCard extends StatelessWidget {
  final SearchResultWeatherModel weather;
  final VoidCallback onTap;
  const SearchResultCard({
    super.key,
    required this.weather,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return GestureDetector(
      onTap: (){
   context.read<SearchProvider>().addToRecent(weather);

   onTap();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          //color: Colors.white,
          color:isDark?AppColors.darkCardBg:Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
               crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${weather.temp.round()}°',
                    style: TextStyles.temperatureNum.copyWith(
                      color:isDark?Colors.white:Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    weather.condition,
                    style:  TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDark?Colors.grey:Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${weather.cityName}, ${weather.country}',
                    style: TextStyle(fontSize: 13, 
                    color: Colors.grey.shade500),
                  ),

                  const SizedBox(height: 2),
                  Text(
                    '${weather.description} · ${weather.humidity}% humidity',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
            Image.asset(
              getWeatherAssetIcon(weather.icon),
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
         Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('EEEE,d MMMM yyyy').format(DateTime.now()),
                  style: TextStyles.dateStyle,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.my_location,
                      size: 16,
                      color: AppColors.anotherBlue,
                    ),
                    const SizedBox(width: 6),
                    // Text(
                    //   'Province of Turin',
                    //   style: TextStyles.cityNameStyle,
                    // )
                    Consumer<WeatherProvider>(
                      builder: (context, weatherProvider, child) {
                        if (weatherProvider.isLoading) {
                          return const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        }
                        return Text(
                          weatherProvider.cityName,
                          style: TextStyles.cityNameStyle,
                        );
                      },
                    ),
                  
                  ],
                ),
              ],
            ),
            
          
         // const SizedBox(height: 12,),
            Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.circleShape1,
                            AppColors.circleShape2,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF364F8B),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child:const Center(
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

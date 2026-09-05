import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/user_avatar.dart';
import 'package:weather_app/core/providers/weather_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    final user=FirebaseAuth.instance.currentUser;
    final String rawEmailName=user?.email?.split('@').first ??'User';
    final String userName=(user?.displayName !=null && user!.displayName!.isNotEmpty)
    ?user!.displayName!
    :rawEmailName;
    

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
                  style: TextStyles.dateStyle.copyWith(
                    color: isDark?
                    Colors.grey
                    :AppColors.thirdBlue,
                  ),
                  
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
                          style: TextStyles.cityNameStyle.copyWith(
                            color: isDark?
                            Colors.white
                            : Colors.black
                          ),
                        );
                      },
                    ),
                  
                  ],
                ),
              ],
            ),
            
          
         // const SizedBox(height: 12,),
          UserAvatar(
            userName: userName,
            size: 50,)
            
        ],
      ),
    );
  }
}

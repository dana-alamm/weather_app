import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/user_avatar.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';

class ForecastHeader extends StatelessWidget {
  const ForecastHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    final cityName = context.watch<WeatherProvider>().cityName;

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
                '9-Day Forecast',
                style: TextStyles.Heading1.copyWith(
                  color:isDark?Colors.white:Colors.black,
                ),
              ),
            ],
          ),
         UserAvatar(
          userName: userName,
          size: 50,
          )
        ],
      ),
    );
  }
}
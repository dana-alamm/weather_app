import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/features/forecast/widgets/forecast_day_tile.dart';
import 'package:weather_app/features/forecast/widgets/forecast_header.dart';
import 'package:weather_app/features/forecast/widgets/main_forcast_card.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';
import 'package:weather_app/features/search/screens/search_screen.dart';

class ForecastScreen extends StatefulWidget {
  const ForecastScreen({super.key});

  @override
  State<ForecastScreen> createState() => _ForecastScreenState();
}

class _ForecastScreenState extends State<ForecastScreen> {
  int _currentNavIndex=2;
  final List<DailyForeCast>_weeklyForcast=const[
    DailyForeCast(
     dayName: 'Thu',
    dateText: 'Sep 19',
    condition: 'Light Showers',
    minTemp: 10,
    maxTemp: 14,
    iconPath: 'assets/images/🌦.png',
    barColor: Color(0xFF60A5FA),
      ),
   DailyForeCast(
    dayName: 'Fri',
    dateText: 'Sep 20',
    condition: 'Partly Cloudy',
    minTemp: 11,
    maxTemp: 17,
    iconPath: 'assets/images/⛅.png',
    barColor: Color(0xFF34D399),
    ),
    DailyForeCast(
     dayName: 'Sat',
    dateText: 'Sep 21',
    condition: 'Sunny',
    minTemp: 12,
    maxTemp: 21,
    iconPath: 'assets/images/☀️.png',
    barColor: Color(0xFFFBBF24),
    ),
 
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.transparent,
   extendBody: true,
   
    body: AppBackground(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
           padding: const EdgeInsets.only(
              top: 20,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ForecastHeader(),
                const SizedBox(height:24 ,),
                const MainForcastCard(),
                const SizedBox(height: 24,),
                Row(
                  children: [
                    Text(
                      'This week',
                      style:TextStyles.subHeading,
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: Divider(
                        color: Colors.blueGrey.shade100.withOpacity(0.6),
                        thickness: 1,
                      )
                      ),
                     
                  ],
                  ),
                   const SizedBox(height: 10,),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context,index){
                          return ForecastDayTile(forecast: _weeklyForcast[index]);
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 10),
                        itemCount: _weeklyForcast.length
                        ),

              ],
            ),
        )
        )
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
    

  }
}
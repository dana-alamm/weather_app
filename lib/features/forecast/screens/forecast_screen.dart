import 'package:flutter/material.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.transparent,
   extendBody: true,
   bottomNavigationBar: CustomBottomNavBar(
    currentIndex: _currentNavIndex, 
    onTap: (index){
      setState(() {
        _currentNavIndex=index;
      });
    }),
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
              ],
            ),
        )
        )
      ),
    );
    

  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/features/forecast/screens/forecast_screen.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';
import 'package:weather_app/features/home/widgets/home_header.dart';
import 'package:weather_app/features/home/widgets/hourly_forecast_section.dart';
import 'package:weather_app/features/home/widgets/main_weather_card.dart';
import 'package:weather_app/features/home/widgets/rain_alert_banner.dart';
import 'package:weather_app/features/home/widgets/weather_details_section.dart';
import 'package:weather_app/features/search/screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int _currentNavIndex=0;
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      context.read<WeatherProvider>().fetchLocationData();
    });
  }
  
  
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
                const HomeHeader(),
                const SizedBox(height: 24),
                const MainWeatherCard(),
                const SizedBox(height: 10,),
                const RainAlertBanner(),
                const SizedBox(height: 20,),
                const HourlyForecastSection(),
               const SizedBox(height: 20,),
               const WeatherDetailsSection(),
               const SizedBox(height: 100,),
                ],

              
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
    
  }
}

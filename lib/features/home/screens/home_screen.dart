import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';
import 'package:weather_app/features/home/widgets/home_header.dart';
import 'package:weather_app/features/home/widgets/main_weather_card.dart';
import 'package:weather_app/features/home/widgets/rain_alert_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
      body: AppBackground(
        child: SafeArea(
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
                ],

              
            ),
          ),
        ),
      ),
    );
  }
}

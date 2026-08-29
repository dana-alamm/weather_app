import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/theme_provider.dart';
import 'package:weather_app/core/services/shared_prefs_service.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/features/auth/screens/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';
import 'package:weather_app/features/onboarding/screens/welcome_screen.dart';
import 'package:weather_app/features/search/providers/search_provider.dart';
import 'firebase_options.dart';

import 'features/home/providers/weather_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  await SharedPrefsService.init();
  final bool isLoggedIn=SharedPrefsService.getData(key: 'isLoggedIn')??false;

  runApp(
   MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ThemeProvider()),
        ChangeNotifierProvider(create: (_) => WeatherProvider()),
        ChangeNotifierProvider(create: (_)=>SearchProvider()),
      ],
   child: MyApp(isLoggedIn: isLoggedIn),
   ),
   );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeProvider=context.watch<ThemeProvider>();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      themeMode: context.watch<ThemeProvider>().currentTheme,
      theme: AppColors.lightTheme,
      darkTheme: AppColors.darkTheme,
      // theme: ThemeData(
       
      //   colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      // ),
      home: isLoggedIn?const HomeScreen() :const WelcomeScreen(),
    );
  }
}


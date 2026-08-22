import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/services/shared_prefs_service.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: isLoggedIn?const HomeScreen() :const WelcomeScreen(),
    );
  }
}


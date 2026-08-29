import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/auth/screens/login_screen.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
   if(snapshot.connectionState==ConnectionState.waiting){
    return const Scaffold(
backgroundColor: Color(0xFF0F172A),
body: Center(
  child: CircularProgressIndicator(color: Colors.white),
),
    );
   }
   if (snapshot.hasData && snapshot.data != null) {
          return const HomeScreen();
      }
      return const LoginScreen();
      }
      );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app/core/widgets/app_background.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   backgroundColor: Colors.transparent,
   extendBody: true,
   body: AppBackground(
    child: SafeArea(
      bottom:  false,
      child: SingleChildScrollView(
           padding: const EdgeInsets.only(
              top: 20,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container()
              ],
            ),
      )
      )
    ),
    );
  }
}
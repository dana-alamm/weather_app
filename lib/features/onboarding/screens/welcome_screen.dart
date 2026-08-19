import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: AppBackground(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              const Spacer(flex: 3,),

              Image.asset(
                'assets/images/div.welcome-icon-wrap_margin.png',
                height: 180,
              ),
              const SizedBox(height: 40,),

              const Text(
                'Welcome!',
                style:  TextStyles.Heading1,
               
              ),
              const SizedBox(height: 12,),
              Text(
                'Precise weather, beautifully presented.',
                style: TextStyles.subHeading,
              ),
              //const Spacer(flex: 3,),
              const SizedBox(height: 20,),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    )
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      height: 1.4,
                      letterSpacing: -0.32,
                      color: Colors.white,
                    ),
                  )
                  ),
              ),
              const Spacer(flex: 3,)


            ],
          ),
          )
        )
      ),
    );
  }
}
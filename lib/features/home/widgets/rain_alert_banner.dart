
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class RainAlertBanner extends StatelessWidget {
  const RainAlertBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
    decoration: BoxDecoration(
      color:Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color:AppColors.circleShape1,
        width: 1.5
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/span.alert-icon.png',
          width: 24,
          height: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.beach_access_rounded,
            size: 22,
          ),
        ),
        const SizedBox(width: 14,),

        Expanded(
          child: RichText(
            text:const TextSpan(
              style: TextStyle(
                fontFamily: 'Inter',
                //fontWeight: FontWeight.w600,
                fontSize: 13,
                height: 1.0,
               // color:Colors.black,
              ),
              children: [
                TextSpan(
                  text:'Grab an umbrella. ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color:Colors.black,

                  ),
                  

                ),
                TextSpan(
                    text: 'Rain expected through the afternoon — 2.73 mm in the last hour.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color:AppColors.circleShape2,
                    )
                  ),
              ]
            ),)
        ),
      ],
    ),
    );
  }
}
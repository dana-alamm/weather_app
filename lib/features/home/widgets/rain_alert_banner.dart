
// import 'package:flutter/material.dart';
// import 'package:weather_app/core/theme/app_colors.dart';

// class RainAlertBanner extends StatelessWidget {
//   final double? rainAmount;
//   const RainAlertBanner({super.key, this.rainAmount});

//   @override
//   Widget build(BuildContext context) {
//     if(rainAmount==null||rainAmount==0){
//       return const SizedBox.shrink();
//     }
//     return Container(
//     width: double.infinity,
//     padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
//     decoration: BoxDecoration(
//       color:Colors.white,
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(
//         color:AppColors.circleShape1,
//         width: 1.5
//       ),
//     ),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset(
//           'assets/images/span.alert-icon.png',
//           width: 24,
//           height: 24,
//           errorBuilder: (context, error, stackTrace) => const Icon(
//             Icons.beach_access_rounded,
//             size: 22,
//           ),
//         ),
//         const SizedBox(width: 14,),

//         Expanded(
//           child: RichText(
//             text:TextSpan(
//               style: const TextStyle(
//                 fontFamily: 'Inter',
//                 //fontWeight: FontWeight.w600,
//                 fontSize: 13,
//                 height: 1.0,
//                // color:Colors.black,
//               ),
//               children: [
//                 const TextSpan(
//                   text:'Grab an umbrella. ',
//                   style: TextStyle(
//                     fontWeight: FontWeight.w600,
//                     color:Colors.black,

//                   ),
                  

//                 ),
//                 TextSpan(
//                     text: 'Rain expected — ${rainAmount!.toStringAsFixed(2)} mm in the last hour.',
//                     style: const TextStyle(
//                       fontFamily: 'Inter',
//                       color:AppColors.circleShape2,
//                     )
//                   ),
//               ]
//             ),)
//         ),
//       ],
//     ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class RainAlertBanner extends StatelessWidget {
  final CurrentWeatherModel? weather;
  const RainAlertBanner({super.key, this.weather});

  @override
  Widget build(BuildContext context) {
    final current = weather;
    if (weather==null) return const SizedBox.shrink();

    String title='';
    String description='';
    IconData iconData = Icons.beach_access_rounded;

    if (weather?.rainAmount != null && weather!.rainAmount! > 0) {
      title = 'Grab an umbrella. ';
      description = 'Rain expected — ${weather!.rainAmount!.toStringAsFixed(2)} mm in the last hour.';
      iconData = Icons.beach_access_rounded;
    } else if (weather!.windSpeed > 8.0) {
      title = 'Windy conditions. ';
      description = 'Strong winds at ${weather!.windSpeed.toStringAsFixed(1)} m/s today.';
      iconData = Icons.air_rounded;
    } else if (weather!.visibility < 2000) {
      title = 'Low visibility. ';
      description = 'Foggy weather — visibility around ${(weather!.visibility / 1000).toStringAsFixed(1)} km.';
      iconData = Icons.visibility_off_rounded;
    } else if (weather!.temp > 35.0) {
      title = 'Extreme heat. ';
      description = 'High temperatures today — stay hydrated.';
      iconData = Icons.wb_sunny_rounded;
    } else if (weather!.temp < 4.0) {
      title = 'Near freezing. ';
      description = 'Cold weather — watch out for icy roads.';
      iconData = Icons.ac_unit_rounded;
    } else {
    
      return const SizedBox.shrink();
    }
    return Container(
     width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.circleShape1,
          width: 1.5,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 22,
            color: Colors.black87,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 13,
                  height: 1.0,
                ),
                children: [
                  TextSpan(
                    text: title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: description,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: AppColors.circleShape2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    
  }
}
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class CurrentLocationButton extends StatelessWidget {
  final VoidCallback onTap;
  const CurrentLocationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.gps_fixed,
            size: 18,
            color:AppColors.thirdBlue.withOpacity(0.85),

          ),
          const SizedBox(width: 8,),
          Text(
            'Use my current location',
            style:TextStyles.subHeading.copyWith(
              decoration: TextDecoration.underline,
              decorationColor: Color(0xff6B7280),
            ),
          )
        ],
      ),
    );
  }
}
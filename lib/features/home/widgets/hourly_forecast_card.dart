import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String imagePath;
  final String temp;
  final String rainProbability;
  final bool isSelected;
  final VoidCallback? onTap;
  const HourlyForecastCard({
    super.key,
    required this.time,
    required this.imagePath,
    required this.temp,
    required this.rainProbability,
    this.isSelected = false, 
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFDCE8FD)
              : Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: const Color(0xFF4A80F0), width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyles.timeStyle.copyWith(
                color:isSelected
                ? AppColors.circleShape2
                : Colors.grey
      
              ),
            ),
            Image.asset(
              imagePath,
              height: 34,
              width: 34,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.cloudy_snowing,
                size: 30,
                color: Color(0xFF64B5F6),
              ),
            ),
            Text(
              temp,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            Text(
              rainProbability,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4A80F0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

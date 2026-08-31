import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/temp_text.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String imagePath;
  final double temp;
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
    final isDark=Theme.of(context).brightness==Brightness.dark;
  
    final Color cardBg=isDark
    ?(isSelected ?const Color(0xFF263352) : AppColors.darkCardBg)
    :(isSelected ? const Color(0xFFDCE8FD) : Colors.white.withOpacity(0.9));

    final Border? cardBorder = isSelected
        ? Border.all(
            color: isDark ? const Color(0xFF4A80F0) : const Color(0xFF4A80F0),
            width: 1.5,
          )
        : (isDark
            ? Border.all(color: Colors.white.withOpacity(0.04), width: 1)
            : null);

            final Color timeColor = isSelected
        ? (isDark ? const Color(0xFF7FACFA) : AppColors.circleShape2)
        : (isDark ? const Color(0xFF8E9BB5) : Colors.grey);
        
        final Color rainColor = isSelected
        ? (isDark ? AppColors.circleShape1 : const Color(0xFF4A80F0))
        : (isDark ? const Color(0xFF8E9BB5) : const Color(0xFF4A80F0));
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          // color: isSelected
          //     ? const Color(0xFFDCE8FD)
          //     : Colors.white.withOpacity(0.9),
          color:cardBg,
          borderRadius: BorderRadius.circular(16),
         border: cardBorder,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time,
              style: TextStyles.timeStyle.copyWith(
               color:timeColor,
               fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
      
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
            // Text(
            //   temp,
            
            //   style:  TextStyle(
            //     fontSize: 15,
            //     fontWeight: FontWeight.bold,
            //     color:isDark?Colors.white :Color(0xFF1E293B),
            //   ),
            // ),
            TempText(
              temp: temp,
              fontSize: 15,
            ),
            Text(
              rainProbability,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: rainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

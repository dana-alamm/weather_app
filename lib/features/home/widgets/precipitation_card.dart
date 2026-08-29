import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';


class PrecipitationCard extends StatelessWidget {
final List<HourlyWeatherModel>hourly;

  const PrecipitationCard({super.key, 
    required this.hourly, });

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
   final items = hourly.take(6).toList();
   if (items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
   decoration: BoxDecoration(
       // color: Colors.white,
       color:isDark?AppColors.darkCardBg:Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: items.map((item)=>_buildBarItem(item)).toList(),
      ),
    );
  }
  Widget _buildBarItem(HourlyWeatherModel item) {
    
    const double maxHeight = 60;
    const double maxVal = 2.5;

    final double displayValue=item.rainAmount>0?item.rainAmount:(item.pop*2.5);
    final double barHeight = (displayValue / maxVal).clamp(0.04, 1.0) * maxHeight;

    final isHigh=displayValue>=2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
     
      children: [
        
        Text(
          item.formattedHour,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
           // color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 38,
          height: barHeight,
          decoration: BoxDecoration(
            color: isHigh ? const Color(0xFF6FABDB) : const Color(0xFF98C5E7),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          item.rainAmount.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
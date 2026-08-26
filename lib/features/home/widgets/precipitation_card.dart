import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/theme/text_styles.dart';
class PrecipitationModel {
  final String time;
  final double value;

  PrecipitationModel({required this.time, required this.value});
}

class PrecipitationCard extends StatelessWidget {
  final List<PrecipitationModel> hourlyPrecipitation;

  const PrecipitationCard({super.key, 
   this.hourlyPrecipitation=const [], });

  @override
  Widget build(BuildContext context) {
    final dummyData = hourlyPrecipitation.isNotEmpty
        ? hourlyPrecipitation
        : [
            PrecipitationModel(time: '3 am', value: 1.43),
            PrecipitationModel(time: '4 am', value: 2.43),
            PrecipitationModel(time: '5 am', value: 1.01),
            PrecipitationModel(time: '6 am', value: 0.05),
            PrecipitationModel(time: '7 am', value: 0.0),
            PrecipitationModel(time: '8 am', value: 0.0),
          ];
    return Container(
   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
   decoration: BoxDecoration(
        color: Colors.white,
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
        children: dummyData.map((item) => _buildBarItem(item)).toList(),
      ),
    );
  }
  Widget _buildBarItem(PrecipitationModel item) {
    
    const double maxHeight = 60;
    const double maxVal = 2.5;
    final double barHeight = (item.value / maxVal).clamp(0.04, 1.0) * maxHeight;

    final isHigh = item.value >= 2.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
     
      children: [
        
        Text(
          item.time,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
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
          item.value.toStringAsFixed(item.value == 0 ? 1 : 2),
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
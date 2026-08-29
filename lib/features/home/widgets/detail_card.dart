import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final String description;
  const DetailCard({
    super.key,
    required this.title,
    required this.value,
    required this.unit,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color:isDark?AppColors.darkCardBg :Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.04) : Colors.transparent,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.circleShape1 : Colors.black87,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(title.toUpperCase(), style: TextStyles.staticWord.copyWith(
                color:isDark?Colors.grey:AppColors.circleShape2
              )),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyles.valueStyle.copyWith(
                color:isDark?Colors.grey:Colors.black,
              )),
              SizedBox(width: 4),
              Text(unit, style: TextStyles.unitStyle.copyWith(
                color:isDark?Colors.grey:Colors.black,
              )),
            ],
          ),
          Text(description, maxLines: 1, style: TextStyles.unitStyle.copyWith(
            color:isDark?Colors.grey:Colors.black,
          )),
        ],
      ),
    );
  }
}

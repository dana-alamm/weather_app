import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(title.toUpperCase(), style: TextStyles.staticWord),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: TextStyles.valueStyle),
              SizedBox(width: 4),
              Text(unit, style: TextStyles.unitStyle),
            ],
          ),
          Text(description, maxLines: 1, style: TextStyles.unitStyle),
        ],
      ),
    );
  }
}

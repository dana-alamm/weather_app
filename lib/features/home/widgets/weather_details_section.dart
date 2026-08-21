import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/widgets/detail_card.dart';

class WeatherDetailsSection extends StatelessWidget {
  const WeatherDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Details', style: TextStyles.staticWord),
        SizedBox(height: 12),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.25,
          children: const [
            DetailCard(
              title: 'HUMIDITY',
              value: '60',
              unit: '%',
              description: 'Moderate',
            ),
            DetailCard(
              title: 'WIND',
              value: '4.1',
              unit: 'm/s',
              description: 'SE · Gusts 3.5',
            ),
            DetailCard(
              title: 'PRESSURE',
              value: '1014',
              unit: 'hPa',
              description: 'Normal',
            ),
            DetailCard(
              title: 'VISIBILITY',
              value: '10',
              unit: 'km',
              description: 'Clear view',
            ),
          ],
        ),
      ],
    );
  }
}

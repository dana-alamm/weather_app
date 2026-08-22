import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class MainForcastCard extends StatelessWidget {
  final int temperature;
  final String condition;
  final double maxTemp;
  final double minTemp;
  final String? dateText;
  final String iconPath;
  const MainForcastCard({
    super.key, 
    this.temperature=11, 
   this.condition = 'Moderate Rain',
    this.maxTemp = 13.7,
    this.minTemp = 9.9,
    this.dateText,
    this.iconPath = 'assets/images/🌧.png',
    });

  @override
  Widget build(BuildContext context) {
   final formattedDate=dateText ?? DateFormat('EEE d MMM').format(DateTime.now());
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Image.asset(
          iconPath,
          width: 58,
            height: 58,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.cloud,
              size: 50,
              color: Colors.blueAccent,
            ),
        ),
        const SizedBox(width: 16,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$temperature°',
                style: TextStyles.temperatureNum.copyWith(
                  fontSize: 34
                ),
              ),
              const SizedBox(height: 4,),
              Text(
                condition,
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  const Icon(
                      Icons.arrow_upward,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    Text(
                      ' $maxTemp° ',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_downward,
                      size: 13,
                      color: Color(0xFF94A3B8),
                    ),
                    Text(
                      ' $minTemp°',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                ],
              )
            ],
          )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Today',
                style: TextStyles.subHeading,
              ),
              const SizedBox(height: 2,),
              Text(
                formattedDate,
                style: TextStyles.subHeading,
              )
            ],
          )
        
        ],
      ),
    );
  }
}
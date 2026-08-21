import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/home/widgets/hourly_forecast_card.dart';

class HourlyForecastSection extends StatefulWidget {
  final VoidCallback? onForecastTap;
  const HourlyForecastSection({super.key, this.onForecastTap});

  @override
  State<HourlyForecastSection> createState() => _HourlyForecastSectionState();
}

class _HourlyForecastSectionState extends State<HourlyForecastSection> {
  int selectedIndex=1;

  final List<Map<String, String>> hourlyData = const [
    {'time': '10 AM', 'temp': '10°', 'rain': '85%', 'icon': 'assets/images/rain_cloud.png'},
    {'time': 'NOW', 'temp': '11°', 'rain': '79%', 'icon': 'assets/images/rain_cloud.png'},
    {'time': '2 PM', 'temp': '12°', 'rain': '55%', 'icon': 'assets/images/rain_cloud.png'},
    {'time': '4 PM', 'temp': '13°', 'rain': '25%', 'icon': 'assets/images/rain_cloud.png'},
    {'time': '6 PM', 'temp': '12°', 'rain': '0%', 'icon': 'assets/images/rain_cloud.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hourly', style: TextStyles.staticWord),
            GestureDetector(
              onTap: () {},
              child: Text('7-day forecast', style: TextStyles.savenDaysForcast),
            ),
          ],
        ),
        const SizedBox(height: 12),

       SizedBox(
        height: 145,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
         
          separatorBuilder: (context,Index)=>SizedBox(width: 10,), 
          itemCount: hourlyData.length,
          itemBuilder: (context, index) {
            final item=hourlyData[index];
            return HourlyForecastCard( 
            time:item['time']!, 
            imagePath: item['icon']!, 
            temp: item['temp']!,
            rainProbability: item['rain']!,
            isSelected: selectedIndex==index,
            onTap: (){
              setState(() {
                selectedIndex=index;
              });
            },
            );

          },
          ),
       )
      ],
    );
  }
}

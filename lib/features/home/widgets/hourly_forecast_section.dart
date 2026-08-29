import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/models/weather_model.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/forecast/screens/forecast_screen.dart';
import 'package:weather_app/features/home/widgets/hourly_forecast_card.dart';

class HourlyForecastSection extends StatefulWidget {
  final List<HourlyWeatherModel> hourly;
  final VoidCallback? onForecastTap;
  const HourlyForecastSection({super.key, this.onForecastTap, required this.hourly});

  @override
  State<HourlyForecastSection> createState() => _HourlyForecastSectionState();
}

class _HourlyForecastSectionState extends State<HourlyForecastSection> {
  int selectedIndex=1;

 
  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Hourly', style: TextStyles.staticWord.copyWith(
            color:isDark?Colors.grey:Colors.black,
            )),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ForecastScreen()),
                 (route)=>false);
              },
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
          itemCount: widget.hourly.length,
          itemBuilder: (context, index) {
            final item=widget.hourly[index];
            return HourlyForecastCard( 
            time:item.formattedHour, 
            imagePath: item.assetIcon,
            temp: '${item.temp.round()}°',
            rainProbability: '${(item.pop * 100).round()}%',
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

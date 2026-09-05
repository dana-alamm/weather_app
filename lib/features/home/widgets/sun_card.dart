import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/weather_provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class SunCard extends StatefulWidget {
  final String sunrise;
  
  final String sunset;
  
  const SunCard({
    super.key,
    required this.sunrise,
    
     required this.sunset ,
    
    });

  @override
  State<SunCard> createState() => _SunCardState();
}

class _SunCardState extends State<SunCard> {
  Timer? _timer;

  @override
  void initState(){
super.initState();
_timer=Timer.periodic(const Duration(minutes: 1), (timer){
  if(mounted){
    setState(() {
      
    });
  }
});

  }
  @override
  void dispose(){
    _timer?.cancel();
    super.dispose();
  }
  
 DateTime _parseTime(String timeStr) {
  final now = DateTime.now();
  final parts = timeStr.trim().split(':');
  final hour = int.tryParse(parts[0]) ?? 0;
  final minutePart = parts.length > 1 ? parts[1].split(' ')[0] : '0';
  final minute = int.tryParse(minutePart) ?? 0;
  return DateTime(now.year, now.month, now.day, hour, minute);
}

  //where is the sun now?
  double _calculateProgress(DateTime current, DateTime start, DateTime end) {
    if (current.isBefore(start)) return 0.0;
    if (current.isAfter(end)) return 1.0;

    final totalSeconds = end.difference(start).inSeconds; //end -start
    final elapsedSeconds = current.difference(start).inSeconds;//current-start

    if (totalSeconds <= 0) return 0.0;//to avoid Division by zero
    return (elapsedSeconds / totalSeconds).clamp(0.0, 1.0);
  }
  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;

   
  final weatherProvider = Provider.of<WeatherProvider>(context);

  final currentDateTime = DateTime.now();
  final sunriseDateTime = _parseTime(widget.sunrise);
  final sunsetDateTime = _parseTime(widget.sunset);

  
  final sunriseDisplay = weatherProvider.formatTime(sunriseDateTime);
  final currentNowStr = weatherProvider.formatTime(currentDateTime);
  final sunsetDisplay = weatherProvider.formatTime(sunsetDateTime);
 final currentProgress = _calculateProgress(
  currentDateTime,
  sunriseDateTime,
  sunsetDateTime,
);

    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        //color:Colors.white,
        color:isDark?AppColors.darkCardBg:Colors.white,
        borderRadius: BorderRadius.circular(16),

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8,),
              Text(
                'SUNRISE & SUNSET',
                style: TextStyles.unitStyle.copyWith(
                  color:isDark?Colors.grey:Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(height: 25,),
          SizedBox(
            height: 90,
            width: double.infinity,
            child: CustomPaint(
              painter: SunArcPainter(progress: currentProgress),
            ),
          ),
          const SizedBox(height: 20,),
  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('SUNRISE', sunriseDisplay, isDark: isDark),
              _buildTimeColumn('NOW', currentNowStr, isHighlighted: true, isDark: isDark),
              _buildTimeColumn('SUNSET', sunsetDisplay, isDark: isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time, {required bool isDark, isHighlighted = false}) {
    
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: isDark?Colors.grey:Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isHighlighted
                ? (isDark ? Colors.white : const Color(0xFF1E293B))
                : (isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569)),
          ),
        ),
      ],
    );
  }
}
class SunArcPainter extends CustomPainter {
  final double progress;

  SunArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // draw the arc
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height + 10),
      width: size.width - 20,
     
      height: size.height * 1.3,
    );

    
    final arcPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFFF9E44), Color(0xFFC084FC)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke//to paint the arc only
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, pi, pi, false, arcPaint);

    final startPaint = Paint()..color = const Color(0xFFFF9E44);
    canvas.drawCircle(Offset(rect.left, rect.center.dy), 4, startPaint);

   
    final endPaint = Paint()..color = const Color(0xFFC084FC);
    canvas.drawCircle(Offset(rect.right, rect.center.dy), 4, endPaint);

    // the sun place now
    final clampedProgress = progress.clamp(0.0, 1.0);
    final angle = pi + (clampedProgress * pi);
    final sunX = rect.center.dx + (rect.width / 2) * cos(angle);
    final sunY = rect.center.dy + (rect.height / 2) * sin(angle);

    
    final glowPaint = Paint()..color = Colors.amber.withOpacity(0.25);
    canvas.drawCircle(Offset(sunX, sunY), 14, glowPaint);

   
    final sunPaint = Paint()..color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(sunX, sunY), 7, sunPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; 
  //when progress change repeat the draw
}
 
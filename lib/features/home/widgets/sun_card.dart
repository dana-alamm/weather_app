import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class SunCard extends StatelessWidget {
  final String sunrise;
  final String now;
  final String sunset;
  final double progress;
  const SunCard({
    super.key,
    this.sunrise = '07:13',
    this.now = '13:59',
    this.sunset = '19:36',
    this.progress = 0.65,});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
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
              painter: SunArcPainter(progress: progress),
            ),
          ),
          const SizedBox(height: 20,),
  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeColumn('SUNRISE', sunrise, isDark: isDark),
              _buildTimeColumn('NOW', now, isHighlighted: true, isDark: isDark),
              _buildTimeColumn('SUNSET', sunset, isDark: isDark),
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
    // draw the are
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height + 20),
      width: size.width - 20,
      height: (size.height + 20) * 1.6,
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

    // توهج الشمس
    final glowPaint = Paint()..color = Colors.amber.withOpacity(0.25);
    canvas.drawCircle(Offset(sunX, sunY), 14, glowPaint);

    // قرص الشمس
    final sunPaint = Paint()..color = const Color(0xFFFBBF24);
    canvas.drawCircle(Offset(sunX, sunY), 7, sunPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true; 
  //when progress change repeat the draw
}
  
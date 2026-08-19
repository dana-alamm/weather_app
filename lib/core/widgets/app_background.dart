import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: const Alignment(1.0, -1.0),
          radius: 1.4,
          colors: isDark
              ? const [Color(0xFF5A98FC), Color(0xFF2D3561)]
              : const [Color(0xFF5A98FC), Color(0xFFEEF3FB)],
          stops: const [0.0, 0.7],
        ),
      ),
      child: SafeArea(child: child),
    );
  }
}

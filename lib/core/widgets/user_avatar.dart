import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  final String userName;
  final double size;
  final double? fontSize;
  final Color backgroundColor;
  const UserAvatar({
    super.key,
    required this.userName,
    this.size = 72,
    this.fontSize,
    this.backgroundColor = const Color(0xFF38529A),
  });
  String get _initialLetter {
    final trimmed = userName.trim();
    if (trimmed.isEmpty) return 'U';
    return trimmed.substring(0, 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        _initialLetter,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize ?? (size * 0.4),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>?onChanged;
  const CustomSearchBar({
    super.key, 
    required this.controller, 
    this.onChanged
    });

  @override
  Widget build(BuildContext context) {
    return Container(
  decoration: BoxDecoration(
    color:Colors.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(16),

  ),
  child: TextField(
    controller: controller,
    onChanged: onChanged,
    style: TextStyle(
      fontFamily: 'Inter',
      fontSize: 15,
      color:Colors.black87
    ),
    decoration: InputDecoration(
      hintText: 'Find your city',
      hintStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 15,
        color:Colors.grey.shade400,
      ),
      prefixIcon: Icon(
        Icons.search,
        color:Colors.grey.shade400,
        size: 22,

      ),
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
    ),
  ),
    );
  }
}
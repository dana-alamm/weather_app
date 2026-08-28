

import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String>?onChanged;
  final VoidCallback? onClear;
  const CustomSearchBar({
    super.key, 
    required this.controller, 
    this.onChanged, this.onClear
    });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
  decoration: BoxDecoration(
    color:Colors.white.withOpacity(0.9),
    borderRadius: BorderRadius.circular(16),

  ),
  child: TextField(
    controller: widget.controller,
    onChanged: (val){
      widget.onChanged?.call(val);
      setState(() {
        
      });
    },
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
      suffixIcon: widget.controller.text.isNotEmpty
      ?IconButton(
        onPressed: (){
          widget.controller.clear();
          widget.onClear?.call();
          setState(() {
            
          });
        }, 
        icon: Icon(
          Icons.cancel,
          color: Colors.grey.shade400,
          size: 20,
        ),
        )
        : null,
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
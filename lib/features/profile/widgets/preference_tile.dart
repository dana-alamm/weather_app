import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class PreferenceTile extends StatelessWidget {
  final String iconEmoji;
  final String title;
  final String value;
  final VoidCallback? onTap;
  final bool showDivider;
  
  const PreferenceTile({
    super.key, 
    required this.iconEmoji, 
    required this.title, 
    required this.value, 
    this.onTap, 
     this.showDivider=true, 
     });

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return Column(
   children: [
    InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                   // color: const Color(0xFFF0F6FD),
                   color:isDark?AppColors.darkCardBg:Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    iconEmoji,
                    style: TextStyle(fontSize: 20),
                  ),
                  
            ),
            const SizedBox(width: 16,),
            Expanded(
              child: Text(
                title,
                style:  TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDark?Colors.white:  Color(0xFF1E293B),
                    ),

                ),
                
            ),
            Text(
                  value,
                  style:  TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color:isDark? Colors.grey: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 8,),
                 Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: isDark?Colors.white :Color(0xFF94A3B8),
                ),
          ],
        ),
        ),
    ),
    if (showDivider)
           Divider(
            height: 1,
            thickness: 1,
            color:Colors.grey.withOpacity(0.4)
          ),
   ],
    );
    
  }
 
}
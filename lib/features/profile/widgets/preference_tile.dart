

import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';

class PreferenceTile extends StatelessWidget {
  final String iconEmoji;
  final String title;
  final String value;
  final VoidCallback? onTap;
  final bool showDivider;
  final List<String>? options;
  final ValueChanged<String>? onOptionSelected;

  const PreferenceTile({
    super.key,
    required this.iconEmoji,
    required this.title,
    required this.value,
    this.onTap,
    this.showDivider = true,
    this.options,
    this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    
    final rightActionWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: isDark ? Colors.grey : const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          Icons.arrow_forward_ios_rounded,
          size: 13,
          color: isDark ? Colors.white : const Color(0xFF94A3B8),
        ),
      ],
    );

    return Column(
      children: [
        InkWell(
          onTap: (options != null && options!.isNotEmpty) ? null : onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
               
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCardBg : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    iconEmoji,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 16),

              
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                ),

                
                if (options != null && options!.isNotEmpty)
                  PopupMenuButton<String>(
                    onSelected: onOptionSelected,
                    offset: const Offset(0, 30),
                    color: isDark ? const Color(0xFF1E293B) : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    itemBuilder: (context) => options!.map((option) {
                      final isSelected =
                          option.toLowerCase() == value.toLowerCase();
                      return PopupMenuItem<String>(
                        value: option,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? Colors.white
                                    : const Color(0xFF1E293B),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check,
                                color: Colors.amber,
                                size: 18,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    child: rightActionWidget,
                  )
                else
                  rightActionWidget,
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.withOpacity(0.2),
          ),
      ],
    );
  }
}
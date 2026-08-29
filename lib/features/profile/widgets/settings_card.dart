import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/providers/theme_provider.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({super.key});

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  bool _isDarkMode=false;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context,themeProv,_){
        final isDark=themeProv.isDarkMode;
    
  
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SETTINGS',
        style: TextStyles.staticWord.copyWith(
          color:isDark?
          Colors.grey:AppColors.circleShape2,
        ),
      ),
      const SizedBox(height: 12,),
      Container(
        decoration: BoxDecoration(
          //color:Colors.white,
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.transparent,
                ),

        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                      //  color: Colors.white,
                      color: isDark ? const Color(0x1AFFFFFF) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: _isDarkMode ? const Color(0xFF6366F1) : const Color(0xFFF59E0B),
                        size: 22,
                      ),
                      
                  ),
                  const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        isDark? 'Dark Mode':'Light Mode',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          //color: Color(0xFF1E293B),
                          color: isDark ? Colors.white : const Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      value: isDark,
                      activeColor: const Color(0xFF4A90E2),
                      onChanged: (val) {
                      themeProv.toggleTheme(val);
                       
                     },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
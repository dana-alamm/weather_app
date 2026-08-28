import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'SETTINGS',
        style: TextStyles.staticWord,
      ),
      const SizedBox(height: 12,),
      Container(
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(16),

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
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: _isDarkMode ? const Color(0xFF6366F1) : const Color(0xFFF59E0B),
                        size: 22,
                      ),
                      
                  ),
                  const SizedBox(width: 14),
                    const Expanded(
                      child: Text(
                        'Dark Mode',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    CupertinoSwitch(
                      value: _isDarkMode,
                      activeColor: const Color(0xFF4A90E2),
                      onChanged: (val) {
                        setState(() {
                          _isDarkMode = val;
                        });
                        // هنا يتم استدعاء دالة تغيير الثيم من الـ ThemeProvider
                      },
                    ),
                ],
              ),),
              
              
              
              
          ],
        ),
      )
    ],
    );
  }
}
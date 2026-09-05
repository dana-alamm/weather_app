

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/features/forecast/screens/forecast_screen.dart';
import 'package:weather_app/features/home/screens/home_screen.dart';
import 'package:weather_app/features/profile/screens/profile_screen.dart';
import 'package:weather_app/features/search/screens/search_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
 

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
   
  });

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          decoration: BoxDecoration(
           // color: Colors.white.withOpacity(0.7),
           color:isDark
           ?const Color(0xFF0F1424).withOpacity(0.75)
                : Colors.white.withOpacity(0.7),
            border: Border(
              top: BorderSide(
                //color: Colors.white.withOpacity(0.06),
                color:isDark
                ?Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.6),
                width: 1,
              ),
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              canvasColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              elevation: 0,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: isDark ? AppColors.skyBlue : AppColors.blueColor,
              unselectedItemColor: isDark
                  ? const Color(0xFF64748B)
                  : AppColors.anotherBlue.withOpacity(0.7),
              selectedLabelStyle: TextStyles.label,
              unselectedLabelStyle: TextStyles.label,
              onTap: (index) {
                if (index == currentIndex) return;

                if (index == 0) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ForecastScreen()),
                  );
                } else if (index == 3) {
                Navigator.push(context, 
                MaterialPageRoute(builder: (context)=>const ProfileScreen()),
                );
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_rounded),
                  activeIcon: Icon(Icons.search_rounded),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  activeIcon: Icon(Icons.calendar_month_rounded),
                  label: 'Forecast',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded),
                  activeIcon: Icon(Icons.person_rounded),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
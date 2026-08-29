
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/core/widgets/user_avatar.dart';
import 'package:weather_app/features/auth/screens/login_screen.dart';
import 'package:weather_app/features/profile/services/user_stats_service.dart';
import 'package:weather_app/features/profile/widgets/preference_tile.dart';
import 'package:weather_app/features/profile/widgets/profile_state_card.dart';
import 'package:weather_app/features/profile/widgets/settings_card.dart';
import 'package:weather_app/features/profile/widgets/sign_out_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

// Future<Map<String,int>>_getUserStats()async{
//   final prefs=await SharedPreferences.getInstance();
//   final uid = FirebaseAuth.instance.currentUser?.uid ?? 'guest';

//   final citiesList=prefs.getStringList('recent_search_$uid')??[];
//   final checks = prefs.getInt('checks_count_$uid') ?? 0;
//     final alerts = prefs.getInt('alerts_count_$uid') ?? 0;

//     return{
//       'cities': citiesList.length,
//       'checks': checks,
//       'alerts': alerts,
//     };
// }
Future<Map<String,int>>_getUserStats()=>UserStatsService().getAllStats();
  @override
  Widget build(BuildContext context) {
    
    final isDark=Theme.of(context).brightness==Brightness.dark;
    final user=FirebaseAuth.instance.currentUser;
    final rawEmailName=user?.email?.split('@').first ??'User';
    final userName=(user?.displayName !=null && user!.displayName!.isNotEmpty)
    ? user.displayName!
    :rawEmailName;

    
    final userEmail=user?.email ??'No email';
    return Scaffold(
   backgroundColor: Colors.transparent,
   extendBody: true,
   body: AppBackground(
    child: SafeArea(
      bottom:  false,
      child: SingleChildScrollView(
           padding: const EdgeInsets.only(
              top: 45,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              UserAvatar(
                userName: userName,
                size: 88,
                ),
                const SizedBox(height: 12,),
                Text(
                  userName,
                  style: TextStyles.userNameStyle.copyWith(
                    fontSize: 35,
                    color: isDark?Colors.white:Colors.black
                  ),
                ),
                const SizedBox(height: 4,),
                Text(
                  userEmail,
                  style: TextStyles.subHeading.copyWith(
                    fontSize: 20,
                  ),
                ),
                const SizedBox( height: 35,),

                FutureBuilder(
                  future: _getUserStats(), 
                  builder: (context,snapshot){
                    final stats=snapshot.data??{'cities':0,'checks': 0, 'alerts': 0};
                    return ProfileStateCard(
                      citiesCount: stats['cities']!,
                      checksCount: stats['checks']!,
                      alertsCount: stats['alerts']!,
                    );
                  }
                  ),
               
                const SizedBox(height: 28,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PREFERENCES',
                    style: TextStyles.staticWord.copyWith(
                      color:isDark?Colors.grey:AppColors.circleShape2
                    ),),
                ),
                const SizedBox(height: 12,),
                Container(
                  decoration: BoxDecoration(
                    //color:Colors.white,
                    color:isDark?AppColors.darkCardBg:Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    
                  ),
                  child: Column(
                    children: [
      PreferenceTile(
        iconEmoji: '🌡️',
        title: 'Temperature',
        value: 'Celsius',
        onTap: () {},
      ),
      PreferenceTile(
        iconEmoji: '💨',
        title: 'Wind Speed',
        value: 'm/s',
        onTap: () {},
      ),
      PreferenceTile(
        iconEmoji: '🕒',
        title: 'Time Format',
        value: '24h',
        onTap: () {},
      ),
      PreferenceTile(
        iconEmoji: '📍',
        title: 'Home Location',
        value: 'Turin, IT',
        showDivider: false, 
        onTap: () {},
      ),
                   
                
              ],
                  ),
                ),
                const SizedBox(height: 12,),
                const SettingsCard(),
                const SizedBox(height: 12,),
                 SignOutButton(
                  onTap: ()async{
                    await FirebaseAuth.instance.signOut();

                    if(!context.mounted)return;

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context)=>LoginScreen(),
                      ),
                        (route)=>false,
                      );
                  }
                  ),
              ]
            )
            
      )
      )
    ),
    bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
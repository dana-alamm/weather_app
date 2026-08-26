
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/core/widgets/user_avatar.dart';
import 'package:weather_app/features/profile/widgets/profile_state_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //int _currentNavBarIndex=3;
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
                const ProfileStateCard(),
              ],
            ),
      )
      )
    ),
    bottomNavigationBar: const CustomBottomNavBar(currentIndex: 3),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_colors.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class ProfileStateCard extends StatelessWidget {
  final int citiesCount;
  final int checksCount;
  final int alertsCount; 
  const ProfileStateCard({super.key, 
   this.citiesCount=0, 
   this.checksCount=0, 
   this.alertsCount=0});

  @override
  Widget build(BuildContext context) {
    final isDark=Theme.of(context).brightness==Brightness.dark;
    return Container(
  
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  decoration: BoxDecoration(
    //color:Colors.white,
    color:isDark?AppColors.darkCardBg:Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: IntrinsicHeight(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
    Expanded(child: _buildStateItem('$citiesCount', 'CITIES',isDark)),
            _buildFullLine(),
            Expanded(child: _buildStateItem('$checksCount', 'CHECKS',isDark)),
            _buildFullLine(),
            Expanded(child: _buildStateItem('$alertsCount', 'ALERTS',isDark)),
      ],
    ),
  ),
    );
  }
  Widget _buildStateItem(String value,String label,bool isDark){
    
    return Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyles.valueProfile.copyWith(
              color: isDark?Colors.white:Colors.black,
            ),
          ),
          const SizedBox(height: 4,),
          Text(
            label,
            style: TextStyles.subHeading,
          ),
        ],
      ),
    );
  }
//   Widget _buildDivider(){
// return Container(
//       height: 36,
//       width: 1,

//       color: Colors.grey,
//     );
//   }
Widget _buildFullLine() {
    return Container(
      width: 1.2,
      color: Colors.grey.withOpacity(0.4)
    );
  }
}
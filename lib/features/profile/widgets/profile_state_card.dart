import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class ProfileStateCard extends StatelessWidget {
  final int citiesCount;
  final int checksCount;
  final int alertsCount; 
  const ProfileStateCard({super.key, 
   this.citiesCount=12, 
   this.checksCount=347, 
   this.alertsCount=8});

  @override
  Widget build(BuildContext context) {
    return Container(
  // padding: const EdgeInsets.symmetric(vertical: 15),
  // margin: const EdgeInsets.symmetric(horizontal: 16),
  //     padding: const EdgeInsets.symmetric(vertical: 12),
  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
  decoration: BoxDecoration(
    color:Colors.white,
    borderRadius: BorderRadius.circular(16),
  ),
  child: IntrinsicHeight(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
    Expanded(child: _buildStateItem('$citiesCount', 'CITIES')),
            _buildFullLine(),
            Expanded(child: _buildStateItem('$checksCount', 'CHECKS')),
            _buildFullLine(),
            Expanded(child: _buildStateItem('$alertsCount', 'ALERTS')),
      ],
    ),
  ),
    );
  }
  Widget _buildStateItem(String value,String label){
    return Container(
      width: 50,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: TextStyles.valueProfile,
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
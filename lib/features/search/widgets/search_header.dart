import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/text_styles.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Find a city.',
            style: TextStyles.Heading1,

          ),
          const SizedBox(height: 6,),
          Text(
            'Search anywhere in the world',
            style:TextStyles.subHeading ,
          ),
          //const SizedBox(height: 20,),

        ],
      ),
      );
  }
}
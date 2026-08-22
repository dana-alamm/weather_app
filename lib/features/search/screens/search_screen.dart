import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/theme/text_styles.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';
import 'package:weather_app/features/search/providers/search_provider.dart';
import 'package:weather_app/features/search/widgets/current_location_button.dart';
import 'package:weather_app/features/search/widgets/custom_search_bar.dart';
import 'package:weather_app/features/search/widgets/recent_city_tile.dart';
import 'package:weather_app/features/search/widgets/search_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}



class _SearchScreenState extends State<SearchScreen> {
  int _currentNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  

  final List<RecentCity> _recentCities=const[
  RecentCity(
    name: 'Rome',
    country: 'Italy · Lazio',
    temperature: 19,
    condition: 'Partly Cloudy',
    imageUrl: 'assets/images/Rome.png'
    ),
    RecentCity(
      name: 'London',
      country: 'United Kingdom',
      temperature: 14,
      condition: 'Rainy',
      imageUrl: 'assets/images/London.jpg'
      ),
      RecentCity(
        name: 'Tokyo',
        country: 'Japan',
        temperature: 28,
        condition: 'Mostly Clear',
        imageUrl: 'assets/images/Tokyo.png'
        ),
        RecentCity(
      name: 'Dubai',
      country: 'United Arab Emirates',
      temperature: 38,
      condition: 'Sunny',
      imageUrl: 'assets/images/Dubai.png',
    ),
    RecentCity(
      name: 'New York',
      country: 'United States',
      temperature: 22,
      condition: 'Cloudy',
      imageUrl: 'assets/images/New_York.png'
    ),
  ];
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      
      body: AppBackground(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 20,
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchHeader(),
                const SizedBox(height: 20),
                CustomSearchBar(controller: _searchController),
                const SizedBox(height: 10),

               CurrentLocationButton(
                onTap: ()async{
                 final cityName= await context.read<SearchProvider>().fetchCurrentCityName();
                  if(cityName != null && mounted){
                    _searchController.text=cityName;
                    context.read<SearchProvider>().searchCity(cityName);
                  }
                },
               ),
               const SizedBox(height: 24,),
               Text(
                'Recent',
                style: TextStyles.staticWord,
               ),
               const SizedBox(height: 12,),
               ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  final city=_recentCities[index];
                  return RecentCityTile(
                    city: city, 
                    onTap: (){
                       _searchController.text = city.name;
                        context.read<SearchProvider>().searchCity(city.name);
                    }
                    );

                },
                separatorBuilder: (context, index) => const SizedBox(height: 6),
                itemCount: _recentCities.length
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/widgets/app_background.dart';
import 'package:weather_app/core/widgets/custom_bottom_nav_bar.dart';
import 'package:weather_app/features/home/providers/weather_provider.dart';
import 'package:weather_app/features/search/providers/search_provider.dart';
import 'package:weather_app/features/search/widgets/current_location_button.dart';
import 'package:weather_app/features/search/widgets/custom_search_bar.dart';
import 'package:weather_app/features/search/widgets/search_header.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _currentNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();
  // @override
  // void initState(){
  //   super.initState();

  // }
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
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
                }
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

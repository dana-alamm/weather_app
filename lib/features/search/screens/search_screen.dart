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
import 'package:weather_app/features/search/widgets/search_result_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _currentNavIndex = 1;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SearchProvider>().loadRecentCities();
    });
  }

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
              bottom: 100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchHeader(),
                const SizedBox(height: 20),
                CustomSearchBar(
                  controller: _searchController,
                  onChanged: (val) {
                    context.read<SearchProvider>().searchCity(val);
                  },
                  onClear: () {
                    context.read<SearchProvider>().clearSearch();
                  },
                ),
                const SizedBox(height: 10),

                CurrentLocationButton(
                  onTap: () async {
                    final cityName = await context
                        .read<SearchProvider>()
                        .fetchCurrentCityName();
                    if (cityName != null && mounted) {
                      _searchController.text = cityName;
                      context.read<SearchProvider>().searchCity(cityName);
                    }
                  },
                ),
                const SizedBox(height: 24),
                Consumer<SearchProvider>(
                  builder: (context, searchProv, _) {
                    if (searchProv.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      );
                    }
                    if (searchProv.errorMessage != null) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            searchProv.errorMessage!,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    }
                    if (_searchController.text.trim().isNotEmpty) {
                      if (searchProv.searchResults.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              'No matching cities found.',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: searchProv.searchResults.length,
                        itemBuilder: (context, index) {
                          final cityResult = searchProv.searchResults[index];
                          return SearchResultCard(
                            weather: cityResult,
                            onTap: () async {
                              context.read<SearchProvider>().addToRecent(
                                cityResult,
                              );
                              if (!context.mounted) return;

                              context.read<WeatherProvider>().fetchWeatherData(
                                lat: cityResult.lat,
                                lon: cityResult.lon,
                                newCityName: cityResult.cityName,
                              );
                              _searchController.clear();
                              context.read<SearchProvider>().clearSearch();
                              FocusScope.of(context).unfocus();
                            },
                          );
                        },
                      );
                    }
                    if (searchProv.recentCities.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Text(
                            'No recent searches yet',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('RECENT', style: TextStyles.staticWord),
                        const SizedBox(height: 12),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final city = searchProv.recentCities[index];
                            return RecentCityTile(
                              city: city,
                              onTap: () {
                                _searchController.text = city.cityName;
                                context.read<SearchProvider>().searchCity(
                                  city.cityName,
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 6),

                          itemCount: searchProv.recentCities.length,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

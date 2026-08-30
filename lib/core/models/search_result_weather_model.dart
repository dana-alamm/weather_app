class SearchResultWeatherModel{
  final String cityName;
  final String state;
  final String country;
  final double lat;
  final double lon;
  final double temp;
  final String condition;
  final String description;
  final int humidity;
  final String icon;

  SearchResultWeatherModel({
    required this.cityName,
    required this.state,
    required this.country,
    required this.lat,
    required this.lon,
    required this.temp,
    required this.condition,
    required this.description,
    required this.humidity,
    required this.icon,
  });
  String get subtitle{
    final parts=[cityName, if(state.isNotEmpty)state,country];
    return parts.join(', ');
  }
  factory SearchResultWeatherModel.fromApiJson({
    required Map<String, dynamic> geoJson,
    required Map<String, dynamic> weatherJson,
  }) {
    return SearchResultWeatherModel(
      cityName: geoJson['name'] ?? '',
      state: geoJson['state'] ?? '',
      country: geoJson['country'] ?? '',
      lat: (geoJson['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (geoJson['lon'] as num?)?.toDouble() ?? 0.0,
      temp: (weatherJson['main']['temp'] as num?)?.toDouble() ?? 0.0,
      condition: weatherJson['weather'][0]['main'] ?? '',
      description: weatherJson['weather'][0]['description'] ?? '',
      humidity: weatherJson['main']['humidity'] ?? 0,
      icon: weatherJson['weather'][0]['icon'] ?? '',
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'state': state,
      'country': country,
      'lat': lat,
      'lon': lon,
      'temp': temp,
      'condition': condition,
      'description': description,
      'humidity': humidity,
      'icon': icon,
    };
  }

  //to read the object after sharedPreference
  factory SearchResultWeatherModel.fromStoredJson(Map<String, dynamic> json) {
    return SearchResultWeatherModel(
      cityName: json['cityName'] ?? '',
      state: json['state'] ?? '',
      country: json['country'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lon: (json['lon'] as num?)?.toDouble() ?? 0.0,
      temp: (json['temp'] as num?)?.toDouble() ?? 0.0,
      condition: json['condition'] ?? '',
      description: json['description'] ?? '',
      humidity: json['humidity'] ?? 0,
      icon: json['icon'] ?? '',
    );
  }
}
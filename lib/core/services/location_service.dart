
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:geocoding_platform_interface/geocoding_platform_interface.dart' hide Geocoding;
class LocationService {
  static Future<Map<String,dynamic>> getCurrentLocationData() async{
    
    bool serviceEnable=await Geolocator.isLocationServiceEnabled();
    if(!serviceEnable){
      throw Exception('Location services are disabled.');
    }
    LocationPermission permission=await Geolocator.checkPermission();
    if(permission==LocationPermission.denied){
      permission=await Geolocator.requestPermission();
       if(permission==LocationPermission.denied){
      throw Exception('Location permissions are denied');
    }
    }
  if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }
  Position position=await Geolocator.getCurrentPosition(
   locationSettings: const LocationSettings(
    accuracy: LocationAccuracy.high,
    timeLimit: Duration(seconds: 10),
   )
  );
String cityName='Unknown City';
try {
  final Geocoding geocoding = Geocoding();
  List<Placemark> placeMarks = await geocoding.placemarkFromCoordinates(
  position.latitude,
  position.longitude,
);
  if(placeMarks.isNotEmpty){
    final place=placeMarks.first;
    cityName=place.locality?.isNotEmpty==true
    ?place.locality!
    :(place.administrativeArea??'Unknown City');
  }
} catch (e) {
  cityName='Unknown City';
}
return{
 'cityName': cityName,
  'latitude': position.latitude,
  'longitude': position.longitude,
};
  }
}
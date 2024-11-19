import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetLocationService {
  Future<String> getCityNameFromCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    //get the current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    print(position.latitude);
    print(position.longitude);

    //convert the location in to list of place mark
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    String cityName = placemark[0].locality!;
    print(cityName);

    return cityName;
  }
}

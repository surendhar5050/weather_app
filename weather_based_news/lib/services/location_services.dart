import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationServices {
  getPresmisson() async {
    //get the permission from user
    LocationPermission locationPermission = await Geolocator.checkPermission();

//Ask the permission
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission==LocationPermission.denied) {
        getPresmisson();
      }
    }
   
  }

  Future<Position> getLocation() async {
    Position curPosistion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

//     List<Placemark> placeMarks = await placemarkFromCoordinates(
//         curPosistion.latitude, curPosistion.longitude);
// print(placeMarks.first.locality);
    return curPosistion;
  }
}

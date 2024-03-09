import 'package:vechtrackapp/constant/kimports.dart';

class locallocations {
  Future getlocation() async {
    final location = await Location();
    LocationData data = await location.getLocation();

    final LatLng result = LatLng(data.latitude!, data.longitude!);
    return [data, result];
  }
}

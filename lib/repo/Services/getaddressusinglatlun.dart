import 'package:geocoding/geocoding.dart';
import 'package:vechtrackapp/constant/kimports.dart';

class getaddressusinglatlng {
  Future getaddress(LatLng source) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(source.latitude, source.longitude);
    return placemarks;
  }
}

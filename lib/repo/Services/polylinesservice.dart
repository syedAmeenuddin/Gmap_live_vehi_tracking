import 'package:vechtrackapp/constant/kimports.dart';

class polylines_local {
  Future<List<LatLng>> getpolyline(
      PointLatLng origin, PointLatLng destination) async {
    PolylinePoints polylines = PolylinePoints();
    PolylineResult result = await polylines.getRouteBetweenCoordinates(
      keys.googleMap,
      origin,
      destination,
    );

    List<LatLng> data = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((element) {
        data.add(LatLng(element.latitude, element.longitude));
      });
    }
    return data;
  }
}

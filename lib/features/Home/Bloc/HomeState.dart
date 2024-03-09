import 'package:vechtrackapp/constant/kimports.dart';

class HomeState {
  final LatLng curlocation;
  final LatLng deslocation;
  final bool loading;
  final double zoom;
  final Set<Marker> markers;
  final Set<Circle> circles;
  final List<LatLng> coordinates;
  final List<Uint8List> images;
  final String dircstatus;

  HomeState(
      {required this.curlocation,
      required this.deslocation,
      required this.loading,
      required this.zoom,
      required this.markers,
      required this.circles,
      required this.dircstatus,
      required this.images,
      required this.coordinates});
}

class initcurlocationState extends HomeState {
  initcurlocationState({
    required final LatLng curlocation,
    required final LatLng deslocation,
    required double zoom,
    required final List<Uint8List> images,
    required Set<Marker> markers,
    required final String dircstatus,
    required List<LatLng> coordinates,
    required final Set<Circle> circles,
  }) : super(
          curlocation: curlocation,
          deslocation: deslocation,
          loading: true,
          images: images,
          circles: circles,
          dircstatus: dircstatus,
          zoom: zoom,
          markers: markers,
          coordinates: coordinates,
        );
}

class FetchcurlocationState extends HomeState {
  FetchcurlocationState({
    required final List<Uint8List> images,
    required final LatLng curlocation,
    required double zoom,
    required final String dircstatus,
    required final Set<Circle> circles,
    required final LatLng deslocation,
    required Set<Marker> markers,
    required List<LatLng> coordinates,
  }) : super(
          curlocation: curlocation,
          loading: false,
          images: images,
          circles: circles,
          deslocation: deslocation,
          zoom: zoom,
          markers: markers,
          dircstatus: dircstatus,
          coordinates: coordinates,
        );
}

class updatelocationState extends HomeState {
  updatelocationState({
    required final LatLng curlocation,
    required final List<Uint8List> images,
    required final double zoom,
    required final String dircstatus,
    required final Set<Circle> circles,
    required final LatLng deslocation,
    required Set<Marker> markers,
    required List<LatLng> coordinates,
  }) : super(
            curlocation: curlocation,
            markers: markers,
            deslocation: deslocation,
            zoom: zoom,
            circles: circles,
            images: images,
            coordinates: coordinates,
            dircstatus: dircstatus,
            loading: false);
}

class updatedestinationState extends HomeState {
  updatedestinationState({
    required final LatLng curlocation,
    required final List<Uint8List> images,
    required final double zoom,
    required Set<Marker> markers,
    required final String dircstatus,
    required final Set<Circle> circles,
    required final LatLng deslocation,
    required List<LatLng> coordinates,
  }) : super(
            curlocation: curlocation,
            deslocation: deslocation,
            markers: markers,
            zoom: zoom,
            circles: circles,
            dircstatus: dircstatus,
            coordinates: coordinates,
            images: images,
            loading: false);
}

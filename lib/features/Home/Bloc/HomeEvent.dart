import 'package:vechtrackapp/constant/kimports.dart';

class HomeEvent {}

class FetchcurlocationEvent extends HomeEvent {
  final BuildContext context;

  FetchcurlocationEvent({required this.context});
}

class updatelocationEvent extends HomeEvent {
  final LocationData locationData;

  updatelocationEvent({required this.locationData});
}

class updatedestinationEvent extends HomeEvent {
  final LatLng destinationloc;

  updatedestinationEvent({required this.destinationloc});
}

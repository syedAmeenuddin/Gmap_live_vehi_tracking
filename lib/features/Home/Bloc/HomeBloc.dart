import 'package:vechtrackapp/constant/kimports.dart';

import 'package:geocoding/geocoding.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  StreamSubscription<LocationData>? _locationSubscription;
  // final location = Location();
  HomeBloc()
      : super(
          initcurlocationState(
              curlocation: LatLng(0, 0),
              deslocation: LatLng(0, 0),
              zoom: 18,
              images: [],
              circles: {},
              dircstatus: '',
              markers: {},
              coordinates: []),
        ) {
    on<FetchcurlocationEvent>((event, emit) async {
      final locationdata = await locallocations().getlocation();
      LatLng _l = locationdata[1];
      LocationData _ld = locationdata[0];
      final Uint8List data =
          await convertimagestobyte().convertimage(event.context);

      emit(
        FetchcurlocationState(
          zoom: 18,
          deslocation: state.deslocation,
          curlocation: _l,
          dircstatus: state.dircstatus,
          coordinates: state.coordinates,
          images: [data],
          circles: {
            Circle(
              fillColor: const Color.fromARGB(0, 33, 149, 243).withAlpha(2),
              circleId: CircleId('car'),
              center: _l,
              radius: _ld.accuracy!,
              strokeColor: Colors.transparent,
              zIndex: 1,
            ),
          },
          markers: {
            Marker(
                rotation: _ld.heading!,
                icon: BitmapDescriptor.fromBytes(data),
                markerId: MarkerId('Source'),
                position: _l,
                zIndex: 2,
                flat: true,
                anchor: Offset(0.5, 0.5)),
          },
        ),
      );
    });

    on<updatelocationEvent>((event, emit) async {
      String showaddress = '';
      List<LatLng> coordinatess = [];
      Set<Marker> markerr = {};
      if (state.dircstatus=='') {
        markerr.add(
          Marker(
              rotation: event.locationData.heading!,
              icon: BitmapDescriptor.fromBytes(state.images[0]),
              markerId: MarkerId('Source'),
              position: LatLng(
                  event.locationData.latitude!, event.locationData.longitude!),
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5)),
        );
      } else {
        markerr.addAll({
          Marker(
              rotation: event.locationData.heading!,
              icon: BitmapDescriptor.fromBytes(state.images[0]),
              markerId: MarkerId('Source'),
              position: LatLng(
                  event.locationData.latitude!, event.locationData.longitude!),
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5)),
          Marker(
              markerId: MarkerId('Destination'),
              position: state.deslocation,
              zIndex: 2,
              flat: true,
              anchor: Offset(0.5, 0.5)),
        });
      }
      if (state.markers.length == 2) {
        coordinatess = await polylines_local().getpolyline(
          PointLatLng(
              event.locationData.latitude!, event.locationData.longitude!),
          PointLatLng(state.deslocation.latitude, state.deslocation.longitude),
        );
        final List<Placemark> placedata =
            await getaddressusinglatlng().getaddress(
          LatLng(event.locationData.latitude!, event.locationData.longitude!),
        );
        showaddress =
            'Head to ${placedata[0].street} ${placedata[0].thoroughfare} ${placedata[0].subLocality}';
      }

      emit(
        updatelocationState(
          coordinates: coordinatess,
          zoom: state.zoom,
          images: state.images,
          dircstatus: showaddress,
          deslocation: state.deslocation,
          circles: {
            Circle(
              fillColor: const Color.fromARGB(0, 33, 149, 243).withAlpha(2),
              circleId: CircleId('car'),
              center: LatLng(
                  event.locationData.latitude!, event.locationData.longitude!),
              radius: event.locationData.accuracy!,
              strokeColor: Colors.transparent,
              zIndex: 1,
            ),
          },
          markers: markerr,
          curlocation: LatLng(
              event.locationData.latitude!, event.locationData.longitude!),
        ),
      );
    });
    on<updatedestinationEvent>(
      (event, emit) async {
        Set<Marker> temp = state.markers;
        temp.add(Marker(
          markerId: MarkerId('Destination'),
          position: event.destinationloc,
        ));

        List<LatLng> coordinatess = await polylines_local().getpolyline(
          PointLatLng(state.curlocation.latitude, state.curlocation.longitude),
          PointLatLng(
              event.destinationloc.latitude, event.destinationloc.longitude),
        );
        emit(
          updatedestinationState(
            dircstatus: 'loading....',
            circles: state.circles,
            images: state.images,
            curlocation: state.curlocation,
            deslocation: LatLng(
                event.destinationloc.latitude, event.destinationloc.longitude),
            zoom: state.zoom,
            coordinates: coordinatess,
            markers: temp,
          ),
        );
      },
    );
  }
  @override
  Future<void> close() {
    _locationSubscription?.cancel();
    return super.close();
  }
}

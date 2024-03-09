import 'package:vechtrackapp/constant/kimports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
  Location location = Location();
  // ignore: unused_field
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(FetchcurlocationEvent(context: context));
    _startListeningLocation();
  }

  void _startListeningLocation() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocation) {
        Future.delayed(Duration(seconds: 1));
        context
            .read<HomeBloc>()
            .add(updatelocationEvent(locationData: currentLocation));
      });
    });
  }

  TextEditingController _googleplacesearch = TextEditingController();
  Widget build(BuildContext context) {
    final _width = MediaQuery.sizeOf(context).width;
    final _height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Container(
              width: _width,
              height: _height,
              child: Stack(
                children: [
                  state.loading
                      ? Container(
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Container(
                          height: _height,
                          child: GoogleMap(
                            myLocationButtonEnabled: false,
                            polylines: {
                              Polyline(
                                polylineId: PolylineId('Source'),
                                color: colors.red,
                                width: 5,
                                points: state.coordinates,
                              ),
                            },
                            circles: state.circles,
                            markers: state.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: state.curlocation, zoom: state.zoom),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            myLocationEnabled: true,
                          ),
                        ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(197, 31, 31, 31),
                            borderRadius: BorderRadius.circular(20)),
                        width: _width * 0.95,
                        height: _height * 0.07,
                        child: GooglePlaceAutoCompleteTextField(
                          boxDecoration: BoxDecoration(
                              border: Border.all(
                                  width: 0, color: Colors.transparent)),
                          textEditingController: _googleplacesearch,
                          googleAPIKey: keys.googleMap,
                          inputDecoration: InputDecoration(
                            hintText: 'Search Destination',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                            contentPadding:
                                EdgeInsets.only(left: 20, right: 20),
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          debounceTime: 800,
                          countries: ["in"],
                          isLatLngRequired: true,
                          getPlaceDetailWithLatLng: (Prediction prediction) {
                            final LatLng data = LatLng(
                                double.parse(prediction.lat!),
                                double.parse(prediction.lng!));
                            context.read<HomeBloc>().add(
                                updatedestinationEvent(destinationloc: data));
                          },
                          itemClick: (Prediction prediction) {
                            _googleplacesearch.text = prediction.description!;
                            _googleplacesearch.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: prediction.description!.length));
                          },
                          itemBuilder: (context, index, Prediction prediction) {
                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.location_on),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Expanded(
                                      child: Text(
                                          "${prediction.description ?? ""}"))
                                ],
                              ),
                            );
                          },
                          seperatedBuilder: Divider(),
                          isCrossBtnShown: true,
                          containerHorizontalPadding: 10,
                        ),
                      ),
                      state.dircstatus != ''
                          ? Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(197, 255, 59, 59),
                                  borderRadius: BorderRadius.circular(20)),
                              width: _width * 0.80,
                              height: _height * 0.15,
                              child: Text(
                                state.dircstatus,
                                style: TextStyle(
                                  fontSize: _height * 0.15 / 9,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

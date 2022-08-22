import 'package:driver_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Gmap extends StatefulWidget {
  const Gmap({Key? key, required this.scaffoldState, required this.callBack})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;
  final Function(LatLng) callBack;

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  late GoogleMapController _mapController;
  late Position currentPosition;
  // GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  Color darkBlue = Colors.black;
  Color grey = Colors.grey;
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();

  void _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    widget
        .callBack(LatLng(currentPosition.latitude, currentPosition.longitude));

    CameraPosition _myCurrentLocation = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 14.4746,
    );
    _mapController
        .animateCamera(CameraUpdate.newCameraPosition(_myCurrentLocation));
  }

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    scaffoldSate = widget.scaffoldState;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        mapType: MapType.normal,
        compassEnabled: true,
        zoomGesturesEnabled: true,
        rotateGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _determinePosition();
        },
      ),
      Positioned(
        top: 10,
        left: 15,
        child: IconButton(
            icon: const Icon(
              Icons.menu,
              color: BaseColor.primary,
              size: 30,
            ),
            onPressed: () {
              scaffoldSate.currentState!.openDrawer();
            }),
      ),
    ]);
  }
}

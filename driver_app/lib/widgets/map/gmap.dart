import 'package:driver_app/utils/base_constant.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Gmap extends StatefulWidget {
  const Gmap({Key? key, required this.scaffoldState}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldState;

  @override
  State<Gmap> createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  late GoogleMapController _mapController;
  // GoogleMapsPlaces googlePlaces;
  TextEditingController destinationController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldSate = GlobalKey<ScaffoldState>();
  LocationData? currentLocation;

  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
    CameraPosition _myCurrentLocation = CameraPosition(
      target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
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
    getCurrentLocation();
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
          getCurrentLocation();
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

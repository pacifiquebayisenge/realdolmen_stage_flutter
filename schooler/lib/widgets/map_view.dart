import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 30;

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller  = Completer();
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;

  @override
  void initState() {
    super.initState();

    // init huidige locatie

    setInitialLocation();


    // init de kaart markers
    setSourceAndDestinationMarkerIcons();

  }

  void setSourceAndDestinationMarkerIcons() async {

    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/imgs/source_pin.png'
    );

    destinationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.0),
        'assets/imgs/destination_pin_.png'
    );
  }

  void setInitialLocation() {
    currentLocation = LatLng(
        SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude
    );

    destinationLocation = LatLng(
        DEST_LOCATION.latitude,
        DEST_LOCATION.longitude
    );
  }

  @override

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION
  );

  Widget build(BuildContext context) {
    return Container(
      child: GoogleMap(
        myLocationEnabled: true,
        compassEnabled: false,
        tiltGesturesEnabled: false,
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      )
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/services/directions_model.dart';
import 'package:schooler/services/directions_repository.dart';

const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 20;
const double CAMERA_BEARING = 30;
const double INFO_BAR_VISIBLE = 70;
const double INFO_BAR_INVISIBLE = -200;

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  Completer<GoogleMapController> _controller = Completer();
  late Marker _origin;
  late Marker _destination;
  late Directions? _info;
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
  late LatLng currentLocation;
  late LatLng destinationLocation;
  double infoBarPosition = INFO_BAR_VISIBLE;

  List<String> resultList = [];
  final floatingSearchBarController = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
  }

  void _addMarker(LatLng pos) async {
    if (_markers.isEmpty == true || _markers.length == 2) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _markers.clear();
        _info = null;
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
          position: pos,
        );

        _markers.add(_origin);
      });
    } else {
      setState(() {
        _destination = Marker(
            markerId: const MarkerId('Destination'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: pos,
            onTap: () {
              setState(() {
                infoBarPosition = INFO_BAR_VISIBLE;
              });
            });

        _markers.add(_destination);
      });

      // get directions
      final directions = await DirectionsRepository().getDirections(
          origin: _origin.position, destination: _destination.position);
      setState(() {
        _info = directions!;
      });
    }
  }

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION);

  _queryList(String query) {
    setState(() {
      resultList = [];
      if (query.isEmpty) {
        resultList = scholen;
      } else {
        scholen.forEach((element) {
          if (element.startsWith(query, 0)) {
            resultList.add(element);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: GoogleMap(
            myLocationEnabled: false,
            compassEnabled: false,
            tiltGesturesEnabled: false,
            markers: _markers,
            mapType: MapType.normal,
            initialCameraPosition: initialCameraPosition,
            onLongPress: _addMarker,
            onTap: (LatLng loc) {
              // als men op de map klikt zal de info bar verdwijnen
              setState(() {
                infoBarPosition = INFO_BAR_INVISIBLE;
              });
            },
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              //pinsOnMap();
            },
          ),
        ),
        FloatingSearchBar(
          border: BorderSide(color: Colors.black12),
          backdropColor: Colors.black26,
          closeOnBackdropTap: true,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          controller: floatingSearchBarController,
          hint: 'Search...',
          scrollPadding: const EdgeInsets.only(top: 6, bottom: 56),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: 0.0,
          openAxisAlignment: 0.0,
          width: 600,
          automaticallyImplyBackButton: false,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            _queryList(query);
          },
          transition: CircularFloatingSearchBarTransition(),
          leadingActions: [
            FloatingSearchBarAction.back(
              showIfClosed: false,
            ),
          ],
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: const Icon(Icons.place),
                onPressed: () {
                  print('map');
                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: List.generate(resultList.length, (index) {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              //_addToList(resultList[index]);

                              floatingSearchBarController.close();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, left: 20.0),
                              child: Container(
                                height: 112,
                                child: Center(
                                    child: Text(
                                  resultList[index],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        ),
        AnimatedPositioned(
          left: 0,
          right: 0,
          bottom: infoBarPosition,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(1),
                  spreadRadius: -5,
                  blurRadius: 15,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'lib/images/empty_space.gif',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Schoolnaam',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text('Straatnaan 12\nstadnaam postcode',
                                style: TextStyle(fontSize: 11)),
                            Text('100 km  away', style: TextStyle(fontSize: 11))
                          ],
                        ),
                      ),
                      TextButton(
                        child: Icon(
                          Icons.navigation_rounded,
                          size: 30,
                          color: Colors.indigo.shade800,
                        ),
                        onPressed: () {},
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                          Colors.indigo.shade800.withOpacity(0.2),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

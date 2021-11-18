import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/services/directions_model.dart';
import 'package:schooler/services/directions_repository.dart';

const LatLng SOURCE_LOCATION = LatLng(50.8454872, 4.3570163);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 11;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 0;
const double INFO_BAR_VISIBLE = 70;
const double INFO_BAR_INVISIBLE = -200;
const double DISTANCE_BAR_VISIBLE = 60;
const double DISTANCE_BAR_INVISIBLE = -200;

class MapView extends StatefulWidget {
  const MapView({Key? key, required this.modeChanger}) : super(key: key);
  final Function modeChanger;
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
  double distanceBarPos = DISTANCE_BAR_INVISIBLE;

  List<String> resultList = [];
  final floatingSearchBarController = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
  }

  void _addMarker(LatLng pos) async {
    if (_markers.isEmpty == true || _markers.length == 2) {
      // als de markers lijst leeg is
      // bepaal vertrek punt
      setState(() {
        distanceBarPos = DISTANCE_BAR_INVISIBLE;
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
      // als er al een marker in de lijst zit
      // bepaal aankomst punt
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
        distanceBarPos = DISTANCE_BAR_VISIBLE;
      });
    }
  }

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION);

// methode om zoek resultaten weer te geven
  _queryList(String query) {
    setState(() {
      // maak de eerste letter van de query een hoofdletter
      if (query.isNotEmpty) {
        query = query.substring(0, 1).toUpperCase() +
            query.substring(1, query.length);
      }

      // maak resultaten eerst leeg
      resultList = [];

      // vul resultaten lijst op basis van de gegeven query
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
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            child: GoogleMap(
              zoomControlsEnabled: false,
              tiltGesturesEnabled: false,
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: initialCameraPosition,
              polylines: {
                if (_markers.length == 2 && _info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info!.polylinePoints
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
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
          // info over de geklikte destination marker
          AnimatedPositioned(
            left: 0,
            right: 0,
            bottom: infoBarPosition,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            child: Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(15),
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
                            children: const [
                              Text(
                                'Schoolnaam',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text('Straatnaan 12\nstadnaam postcode',
                                  style: TextStyle(fontSize: 11)),
                              Text('100 km  away',
                                  style: TextStyle(fontSize: 11))
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
          ),
          // info over de afstand en duurtijd
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: distanceBarPos,
            child: Visibility(
              visible: true,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _markers.length == 2 && _info != null
                          ? '${_info!.totalDistance}, ${_info!.totalDuration}'
                          : '0 km, 0 mins',
                      style: const TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      splashColor: Colors.red,
                      onTap: () {
                        setState(() {
                          distanceBarPos = DISTANCE_BAR_INVISIBLE;

                          _info = null;
                          _markers.clear();
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 3.0),
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          FloatingSearchBar(
            border: const BorderSide(color: Colors.black12),
            backdropColor: Colors.black26,
            closeOnBackdropTap: true,
            borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    widget.modeChanger();
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
                                child: SizedBox(
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
        ],
      ),
    );
  }
}

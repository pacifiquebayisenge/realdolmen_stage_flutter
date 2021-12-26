import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/services/directions_model.dart';
import 'package:schooler/services/directions_repository.dart';
import 'package:schooler/services/globals.dart';
import 'package:location/location.dart';
import 'package:schooler/widgets/widgets.dart';


// bron: tutotrial : https://www.youtube.com/watch?v=Zz5hMvgiWmY&t=5s

const LatLng SOURCE_LOCATION = LatLng(50.8454872, 4.3570163);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 11;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 0;

const double INFO_BAR_VISIBLE = 70;
const double INFO_BAR_INVISIBLE = -200;

const double DISTANCE_BAR_VISIBLE = 60;
const double DISTANCE_BAR_INVISIBLE = -200;

const double LOADING_BAR_VISIBLE = 250;
const double LOADING_BAR_INVISIBLE = -250;

class MapView extends StatefulWidget {
  const MapView({Key? key,  this.modeChanger}) : super(key: key);
  final Function? modeChanger;
  static SchoolObject? chosenSchool = null;
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  late Marker _origin;
  late Marker _destination;
  late Directions? _info = null;
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;
  Set<Marker> _markers = Set<Marker>();
   PermissionStatus? _permissionGranted = null;

   late LatLng currentLocation;
  late LatLng destinationLocation;
  double infoBarPosition = INFO_BAR_INVISIBLE;
  double distanceBarPos = DISTANCE_BAR_INVISIBLE;
  double loadingBar = LOADING_BAR_INVISIBLE;

  List<SchoolObject> resultList = [];
  final floatingSearchBarController = FloatingSearchBarController();
  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION);

   SchoolObject? selectedSchool;

  @override
  void initState()  {
    resultList = schools;

    getLocationPermission();
    setUpRoute();

    super.initState();
  }

  @override
  void dispose()  {
    MapView.chosenSchool = null;
    super.dispose();
  }

  setUpRoute() async {
    if(MapView.chosenSchool == null) return;
    await getLocationPermission();
    await _resultClick(MapView.chosenSchool!);
    await getRoute();


  }

  getRoute() async {
    loadingBar = LOADING_BAR_VISIBLE;
    getLocationPermission();
    setState(() {
      _info = null;
      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: const InfoWindow(title: 'Origin'),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        position: currentLocation,
      );

      _markers.add(_origin);
    });


    // get directions
    final directions = await DirectionsRepository().getDirections(
        origin: _origin.position, destination: _destination.position);
    setState(() {
      _info = directions!;
      distanceBarPos = DISTANCE_BAR_VISIBLE;
      loadingBar = LOADING_BAR_INVISIBLE;
    });

  }



  getLocationPermission() async {

    if(_permissionGranted == PermissionStatus.granted) return;

    bool serviceEnabled = await Location.instance.serviceEnabled();

    if(!serviceEnabled) {
      serviceEnabled = await Location.instance.requestService();
    }

    _permissionGranted = await Location.instance.hasPermission();

    if (_permissionGranted == PermissionStatus.denied) {

      _permissionGranted = await Location.instance.requestPermission();

      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }


    var pos = await Location.instance.getLocation();
     currentLocation = LatLng(pos.latitude!,  pos.longitude!);
    print(currentLocation);
  }


  _resultClick(SchoolObject school)  {
// als er al een marker in de lijst zit
    // bepaal aankomst punt


    setState(() {
      distanceBarPos = DISTANCE_BAR_INVISIBLE;
      infoBarPosition = INFO_BAR_INVISIBLE;

      _info = null;
      _markers.clear();
      

        selectedSchool = null;

        _destination = Marker(
            markerId: MarkerId('Destination_${school.naam}'),
            infoWindow: const InfoWindow(title: 'Destination'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            position: LatLng(school.lat, school.long),
            onTap: () {
              setState(() {
                selectedSchool = school;
                infoBarPosition = INFO_BAR_VISIBLE;
              });
            });

        _markers.add(_destination);

    });
   
  }

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
        resultList = schools;
      } else {
        for (var element in schools) {
          if (element.naam.startsWith(query, 0)) {
            resultList.add(element);
          }
        }
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
              //onLongPress: _addMarker,
              onTap: (LatLng loc) {

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
                        // school icon
                        ClipOval(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundColor: Color.fromRGBO(
                                    234, 144, 16, 1),
                                radius: 25,
                              ),
                              const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 23,
                              ),
                              ClipRRect(
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(30)),
                                child: Image.asset(
                                  'lib/images/school.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                selectedSchool != null ?  selectedSchool!.naam :'Schoolnaam',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(selectedSchool != null ?  '${selectedSchool!.adres.split(',')[0]}\n${selectedSchool!.adres.split(',')[1].trim()}' :'Straatnaan 12\nstadnaam postcode',
                                  style: const TextStyle(fontSize: 11)),

                            ],
                          ),
                        ),
                        if(_info == null)
                        TextButton(
                          child: Icon(
                            Icons.navigation_rounded,
                            size: 30,
                            color: Colors.indigo.shade800,
                          ),
                          onPressed: getRoute,
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
                          infoBarPosition = INFO_BAR_INVISIBLE;

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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            top: loadingBar,
            child: Visibility(
              visible: true,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Container(
                  color: Colors.black87,
                  child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/images/Globe2.gif',
                          scale: 4.5,
                          fit: BoxFit.cover,
                        ),
                        Text('Loading...',
                          style: GoogleFonts
                              .montserrat(
                              color: const Color.fromRGBO(234, 144, 16, 1),
                              fontSize: 15,
                              fontWeight:
                              FontWeight
                                  .w600),),
                      ],
                    ),
                  ),

                ),
              )
            ),
          ),

          // searchbar
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
                    widget.modeChanger!();
                  },
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              // zoek resultaten lijst
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: List.generate(resultList.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 20.0),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          child: Container(
                            child: Material(
                              child: InkWell(
                                overlayColor:
                                    MaterialStateProperty.all(Colors.grey),
                                onTap: () {
                                  //_addToList(resultList[index]);
                                  _resultClick(resultList[index]);
                                  floatingSearchBarController.close();
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // verticaal centreren van circle avatar
                                      // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // school icon
                                        ClipOval(
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              const CircleAvatar(
                                                backgroundColor: Color.fromRGBO(
                                                    234, 144, 16, 1),
                                                radius: 25,
                                              ),
                                              const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 23,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(30)),
                                                child: Image.asset(
                                                  'lib/images/school.png',
                                                  width: 30,
                                                  height: 30,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Flexible(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            resultList[index].naam,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.grey.shade700,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            resultList[index].adres,
                                            style: GoogleFonts.montserrat(
                                                color: Colors.black45,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              color: Colors.transparent,
                            ),
                            color: Colors.white,
                          ),
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

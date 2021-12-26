import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/pages/webview.dart';
import 'package:schooler/widgets/map_view.dart';
import 'package:schooler/widgets/school_search.dart';

const LatLng SOURCE_LOCATION = LatLng(50.8343772, 4.3870163);
const LatLng DEST_LOCATION = LatLng(42.744421, -71.1698939);
const double CAMERA_ZOOM = 10.4;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 0;
const double INFO_BAR_VISIBLE = 70;
const double INFO_BAR_INVISIBLE = -200;
const double DISTANCE_BAR_VISIBLE = 60;
const double DISTANCE_BAR_INVISIBLE = -200;

class SchoolDetailPage extends StatefulWidget {
  SchoolDetailPage({Key? key, required this.school, required this.hideRouteOption}) : super(key: key);
  late SchoolObject school;
  bool hideRouteOption = false;

  @override
  State<SchoolDetailPage> createState() => _SchoolDetailPageState();
}

class _SchoolDetailPageState extends State<SchoolDetailPage> {
  late Marker _destination;

  final Set<Marker> _markers = Set<Marker>();

  final Completer<GoogleMapController> _controller = Completer();

  CameraPosition initialCameraPosition = const CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: SOURCE_LOCATION);

  int getRandom(int limit) {
    Random rdm = new Random();

    // random getal genereren van 0 (incl.) tot 101 (ecl.)
    int number = rdm.nextInt(limit) + 12;

    return number;
  }

  getPos() {
    _destination = Marker(
        markerId: MarkerId('Destination_${widget.school.naam}'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        position: LatLng(widget.school.lat, widget.school.long),
        onTap: () {});

    _markers.add(_destination);
  }

  openWebView() {


    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewPage(
          school: widget.school,
        ),
      ),
    );


  }
  
  getRoute() {
    if(SchoolSearch.redirect == null) return;
    SchoolSearch.redirect!();
    MapView.chosenSchool = widget.school;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    getPos();

    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.indigo.shade800,
        appBar: AppBar(
          centerTitle: true,
          flexibleSpace: const Image(
            image: AssetImage('lib/images/81.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.black12),
          backgroundColor: Colors.indigo.shade800,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close_rounded),
          ),
          title: Text(
            'School Info',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
        ),
        // Voorkomen dat knoppen mee omhoog springen door het toetstebord
        // bron https://stackoverflow.com/questions/54115269/keyboard-is-pushing-the-floatingactionbutton-upward-in-flutter-app/56196712
        resizeToAvoidBottomInset: false,
        body: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(widget.school.naam,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                              fontWeight: FontWeight.w900)),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 1,
                      shadowColor: Colors.lightBlueAccent,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Table(
                          defaultColumnWidth: const IntrinsicColumnWidth(),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [

                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: Text(
                                    '${getRandom(501)} students',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const TableCell(
                                child: SizedBox(
                                  height: 40,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Center(
                                  child: Text(
                                    '${getRandom(201)} teachers',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const TableCell(
                                child: SizedBox(
                                  height: 40,
                                ),
                              )
                            ]),
                            TableRow(children: [

                              TableCell(
                                child: Center(
                                  child: Text(
                                    '${widget.school.type}',
                                    style: GoogleFonts.montserrat(
                                        color: Colors.grey.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              const TableCell(
                                child: SizedBox(
                                  height: 40,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_rounded,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          widget.school.adres.split(',')[0],
                                          style: GoogleFonts.montserrat(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          widget.school.adres
                                              .split(',')[1]
                                              .trim(),
                                          style: GoogleFonts.montserrat(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const TableCell(
                                child: SizedBox(
                                  height: 40,
                                ),
                              )
                            ]),


                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: openWebView,
                          child: Icon(
                            FontAwesomeIcons.globe,
                            color: Colors.indigo.shade800,
                          ),
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.indigo.shade800.withOpacity(0.7))),
                        ),
                        if(widget.hideRouteOption != true)
                        TextButton(
                          onPressed: getRoute,
                          child: Icon(
                            FontAwesomeIcons.mapMarkedAlt,
                            color: Colors.indigo.shade800,
                          ),
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.indigo.shade800.withOpacity(0.7))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const FractionallySizedBox(
                      widthFactor: 0.6,
                      child: Divider(
                        thickness: 2,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: SizedBox(
                        width: 300,
                        height: 200,
                        child: GoogleMap(
                          myLocationEnabled: false,
                          myLocationButtonEnabled: false,
                          rotateGesturesEnabled: false,
                          mapToolbarEnabled: false,
                          scrollGesturesEnabled: false,
                          compassEnabled: false,
                          zoomGesturesEnabled: false,
                          zoomControlsEnabled: false,
                          tiltGesturesEnabled: false,
                          markers: _markers,
                          mapType: MapType.normal,
                          initialCameraPosition: initialCameraPosition,

                          //onLongPress: _addMarker,
                          onTap: (LatLng loc) {},
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            //pinsOnMap();
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

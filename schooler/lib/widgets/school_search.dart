import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:like_button/like_button.dart';
import 'package:schooler/pages/school_detail.dart';
import 'package:schooler/services/globals.dart';
import 'package:intl/intl.dart';
import 'package:schooler/widgets/filter_dialog.dart';

import 'custom_like_button.dart';

class SchoolSearch extends StatefulWidget {
  const SchoolSearch({Key? key, required this.modeChanger}) : super(key: key);

  final Function modeChanger;
  static List<String> schoolList = [];
  @override
  _SchoolSearchState createState() => _SchoolSearchState();
}

class _SchoolSearchState extends State<SchoolSearch> {
  final floatingSearchBarController = FloatingSearchBarController();
  bool favoListActive = false;
  bool filterActive = false;

  List<SchoolObject> resultList = [];

  @override
  void initState() {
    resultList = schools;
    super.initState();
  }



  // methode om zoek resultaten weer te geven
  _queryList(String query) {
    setState(() {
      // maak de eerste letter van de query een hoofdletter
      if (query.isNotEmpty) {
        query = query.substring(0, 1).toUpperCase() +
            query.substring(1, query.length);
      }

      // maak reuslaten lijst leeg
      resultList = [];

      // als query leeg is , geef alle scholen weer
      // anders geef resultaten beginend met de query
      if (query.isEmpty) {
        resultList = scholen2;
      } else {
        scholen2.forEach((element) {
          if (element.naam.startsWith(query, 0)) {
            resultList.add(element);
          }
        });
      }
    });
  }

  _showFavoList() {
    if (thisUser.favoSchoolsList.isEmpty) {
      _showSnackbar('Favorite list is empty');
      return;
    }
    setState(() {
      if (favoListActive == false) {
        favoListActive = true;
        resultList = thisUser.favoSchoolsList;
      } else {
        favoListActive = false;
        resultList = schools;
      }
    });
  }

  _filterDialog() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SchoolDetailPage(),
      ),
    );

    /*
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) =>  FilterDialog(applyFilter: _filter,),
    );

     */
  }

  _filter() {
    setState(() {
      if(FilterDialog.selectedPlace == 'All' && FilterDialog.selectedType == 'All' ) {
        filterActive = false;
        resultList = [];
        resultList = schools;
        return;
      }

      if(FilterDialog.selectedPlace != 'All' && FilterDialog.selectedType != 'All' ) {
        filterActive = true;
        resultList = [];
        schools.forEach((element) {
          if(element.adres.split(',')[1].split(' ')[2] == FilterDialog.selectedPlace && element.type == FilterDialog.selectedType){


              resultList.add(element);

          }
        });
        return;
      }

      if(FilterDialog.selectedPlace != 'All') {
        filterActive = true;
        resultList = [];
        schools.forEach((element) {
          if(element.adres.split(',')[1].split(' ')[2] == FilterDialog.selectedPlace){


              resultList.add(element);

          }
        });
        return;
      }

      if(FilterDialog.selectedType != 'All') {
        filterActive = true;
        resultList = [];
        schools.forEach((element) {
          if(element.type == FilterDialog.selectedType){


              resultList.add(element);

          }
        });
        return;
      }

    });




  }

  _refresh() {
    setState(() {
      if(thisUser.favoSchoolsList.isEmpty) {
        favoListActive = false;
        resultList = schools;
      }
    });


  }

  // snackbar widget om verwijdering van de registratie te bevestigen
  _showSnackbar(String text) {
    final snackBar = SnackBar(
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          color: const Color.fromRGBO(54, 60, 69, 1),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.orange, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: ListView.builder(
              itemCount: resultList.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    onTap: () {
                      print('info');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // verticaal centreren van circle avatar
                          // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(234, 144, 16, 1),
                                    radius: 25,
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 23,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(30)),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(resultList[index].naam,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              Text(resultList[index].adres,
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomLikeButton(
                          school: resultList[index],
                          refresh: _refresh,
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
        FloatingSearchBar(
          backdropColor: Colors.transparent,
          closeOnBackdropTap: true,
          clearQueryOnClose: false,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
          controller: floatingSearchBarController,
          hint: 'Search...',
          scrollPadding: const EdgeInsets.only(top: 16, bottom: 0),
          transitionDuration: const Duration(milliseconds: 800),
          transitionCurve: Curves.easeInOut,
          physics: const BouncingScrollPhysics(),
          axisAlignment: 0.0,
          openAxisAlignment: 0.0,
          width: 600,
          automaticallyImplyBackButton: false,
          debounceDelay: const Duration(milliseconds: 500),
          onQueryChanged: (query) {
            // Call your model, bloc, controller here.
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
                  widget.modeChanger();
                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          builder: (context, transition) {
            return Visibility(
              visible: false,
              child: Container(),
            );
          },
        ),
        Positioned(
          top: 53,
          left: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(130, 10),
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    primary: favoListActive
                        ? const Color.fromRGBO(234, 144, 16, 1)
                        : Colors.grey),
                onPressed: _showFavoList,
                child: Text('Show favorite list',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(120, 10),
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    primary: filterActive && !favoListActive
                        ? const Color.fromRGBO(234, 144, 16, 1)
                        : Colors.grey),
                onPressed: _filterDialog,
                child: Text('Filter',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

/*

 Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: ListView.builder(
              itemCount: resultList.length,
              addAutomaticKeepAlives: false,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    onTap: () {
                      print('info');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          // verticaal centreren van circle avatar
                          // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircleAvatar(
                                    backgroundColor:
                                        Color.fromRGBO(234, 144, 16, 1),
                                    radius: 25,
                                  ),
                                  const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 23,
                                  ),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(resultList[index].naam,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                               Text(resultList[index].toString(),
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        LikeButton(
                          isLiked: isLiked,
                            size: 24,
                            onTap: (bool l) async {
                               this.isLiked = !l;
                               setState(() {
                                 resultList[index].isFavo = !l;

                                 if(resultList[index].isFavo) _addToFavList(resultList[index]);
                                 if(resultList[index].isFavo) _removeFromFavList(resultList[index]);
                               });

                               print('it was ${resultList[index].isFavo}');
                               print('it isn now ${resultList[index].isFavo}');
                              return !l;

                            } ,
                            circleColor: CircleColor(
                                start: const Color(0xff00ddff),
                                end: Colors.indigo.shade800),
                            likeBuilder: (isFavo) {
                              return Icon(
                                Icons.favorite_rounded,
                                color: resultList[index].isFavo ? Colors.redAccent : Colors.grey,
                                size: 24,
                              );
                            }),
                      ],
                    ),
                  ),
                );
              }),
        ),
 */
/*
* Padding(
                key: ValueKey(resultList[i]),
                padding: const EdgeInsets.symmetric( horizontal: 8.0, vertical: 15),
                child: Container(
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {

                        print('info');
                      },
                      overlayColor: MaterialStateProperty.all(Colors.grey),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            // verticaal centreren van circle avatar
                            // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                      Color.fromRGBO(234, 144, 16, 1),
                                      radius: 25,


                                    ),CircleAvatar(
                                      backgroundColor:
                                      Colors.white,
                                      radius: 23,


                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
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
                              // rangschiknummer

                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(resultList[i],
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500)),
                                const Text('Straatnaan 12, stadnaam postcode',
                                    style: TextStyle(fontSize: 11)),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              )
* */

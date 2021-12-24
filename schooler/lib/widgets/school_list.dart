import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/pages/school_detail.dart';
import 'package:schooler/services/globals.dart';

class SchoolList extends StatefulWidget {
  static List<SchoolObject> schoolList = [];
  SchoolList({Key? key}) : super(key: key);

  @override
  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {

  final floatingSearchBarController = FloatingSearchBarController();

  List<SchoolObject> resultList = [];

  @override
  initState() {
    SchoolList.schoolList = [];
    resultList = schools;
    super.initState();
  }



  // methode om nieuwe item in de lijst toe te voegen
  _addToList(SchoolObject school) {
    setState(() {
      SchoolList.schoolList.add(school);
    });
  }

  // methode om item uit de lijst te verwijderen
  _deleteInList(SchoolObject school) {
    setState(() {
      SchoolList.schoolList.removeAt(SchoolList.schoolList.indexOf(school));
    });
  }

// methode om de nieuwe rang orde bij te houden
  _update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    SchoolObject school = SchoolList.schoolList.removeAt(oldIndex);

    SchoolList.schoolList.insert(newIndex, school);
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
        resultList = schools;
      } else {
        schools.forEach((element) {
          if (element.naam.startsWith(query, 0)) {
            resultList.add(element);
          }
        });
      }
    });
  }

  _schoolInfo(SchoolObject school) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SchoolDetailPage(school: school,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: SchoolList.schoolList.isEmpty ?

         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10,),
           child: Text(
           'Search for the schools you would like to apply for. '
           'Short press for info, long press to reorder the list',
           style: GoogleFonts.montserrat(fontSize: 13,fontWeight: FontWeight.bold, color: Colors.black45),
           ),
         )
        :
        ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              _update(oldIndex, newIndex);
            });
          },
          children: [

            for (var i = 0; i < SchoolList.schoolList.length; i++)
              Padding(
                key: ValueKey(SchoolList.schoolList[i].naam),
                padding: const EdgeInsets.symmetric (horizontal: 8.0, vertical: 15),
                child: Container(
                  color: Colors.white,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.grey,
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
                              // rangschiknummer
                              CircleAvatar(
                                backgroundColor:
                                    Color.fromRGBO(234, 144, 16, 1),
                                radius: 15,
                                // rang nummer
                                child: Text(
                                  (i + 1).toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15),
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
                                Text(SchoolList.schoolList[i].naam,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts
                                      .montserrat(
                                      color: Colors.grey
                                          .shade700,
                                      fontSize: 15,
                                      fontWeight:
                                      FontWeight
                                          .w500),),
                                 Text(SchoolList.schoolList[i].adres,
                                  style: GoogleFonts
                                      .montserrat(
                                      color: Colors.black45,
                                      fontSize: 11,
                                      fontWeight:
                                      FontWeight
                                          .w500),),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          // info & delete button
                          Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.red,
                                onTap: () {
                                  _deleteInList(SchoolList.schoolList[i]);
                                  print('delete');
                                },
                                overlayColor:
                                    MaterialStateProperty.all(Colors.red),
                                child: const Icon(
                                  Icons.delete_rounded,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
      FloatingSearchBar(
        backdropColor: Colors.black26,
        closeOnBackdropTap: true,
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        controller: floatingSearchBarController,
        hint: 'Search...',
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
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
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
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

          // zoek resultaten lijst
          return ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: List.generate(resultList.length, (index) {
                  if (SchoolList.schoolList.isEmpty || !SchoolList.schoolList
                      .contains(resultList[index])) {
                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
                      child: ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(30)),
                        child: Container(

                          child: Material(
                            child: InkWell(
                              overlayColor: MaterialStateProperty.all(Colors.grey),
                              onTap: () {
                                _addToList(resultList[index]);

                                floatingSearchBarController.close();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    // verticaal centreren van circle avatar
                                    // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      // school icon
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
                                          style: GoogleFonts
                                              .montserrat(
                                              color: Colors.grey
                                                  .shade700,
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight
                                                  .w500),),
                                         Text(resultList[index].adres,
                                          style: GoogleFonts
                                              .montserrat(
                                              color: Colors.black45,
                                              fontSize: 12,
                                              fontWeight:
                                              FontWeight
                                                  .w500),),
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
                  }
                  else {
                    return const SizedBox();
                  }
                }),
              ),
            ),
          );
        },
      ),
    ]);
  }
}



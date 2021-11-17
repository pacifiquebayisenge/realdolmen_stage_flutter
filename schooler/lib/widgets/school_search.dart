import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';

class SchoolSearch extends StatefulWidget {
  const SchoolSearch({Key? key, required this.modeChanger}) : super(key: key);

  final Function modeChanger;
  static List<String> schoolList = [];
  @override
  _SchoolSearchState createState() => _SchoolSearchState();
}

class _SchoolSearchState extends State<SchoolSearch> {
  @override
  initState() {
    resultList = SchoolSearch.schoolList = scholen;
    super.initState();
  }

  final floatingSearchBarController = FloatingSearchBarController();

  List<String> resultList = [];

  // methode om nieuwe item in de lijst toe te voegen
  _addToList(String school) {
    setState(() {
      SchoolSearch.schoolList.add(school);
    });
  }

  // methode om item uit de lijst te verwijderen
  _deleteInList(String school) {
    setState(() {
      SchoolSearch.schoolList.removeAt(SchoolSearch.schoolList.indexOf(school));
    });
  }

// methode om de nieuwe rang orde bij te houden
  _update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    String school = SchoolSearch.schoolList.removeAt(oldIndex);

    SchoolSearch.schoolList.insert(newIndex, school);
  }

  // methode om zoek resultaten weer te geven
  _queryList(String query) {
    setState(() {
      // maak reuslaten lijst leeg
      resultList = [];

      // als query leeg is , geef alle scholen weer
      // anders geef resultaten beginend met de query
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
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: ReorderableListView(
          onReorder: (int oldIndex, int newIndex) {
            setState(() {
              _update(oldIndex, newIndex);
            });
          },
          children: [
            for (var i = 0; i < SchoolSearch.schoolList.length; i++)
              Padding(
                key: ValueKey(SchoolSearch.schoolList[i]),
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


                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(30)),
                                      child: Image.asset(
                                        'lib/images/school.png',
                                        width: 40,
                                        height: 40,

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
                                Text(SchoolSearch.schoolList[i],
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
          ],
        ),
      ),
      FloatingSearchBar(
        backdropColor: Colors.black26,
        closeOnBackdropTap: true,
        borderRadius: BorderRadius.all(Radius.circular(30)),
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
                  if (SchoolSearch.schoolList.isEmpty) {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              _addToList(resultList[index]);

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
                  } else if (!SchoolSearch.schoolList
                      .contains(resultList[index])) {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              _addToList(resultList[index]);

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
                  } else {
                    return SizedBox();
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

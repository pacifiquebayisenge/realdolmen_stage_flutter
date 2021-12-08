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
  final floatingSearchBarController = FloatingSearchBarController();
  List<String> resultList = [];

  @override
  initState() {
    resultList = scholen;
    super.initState();
  }

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
      borderRadius: BorderRadius.all(Radius.circular(30)),
      child: Stack(children: [
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
                              Text(resultList[index],
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500)),
                              const Text('Straatnaan 12, stadnaam postcode',
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.black54)),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          splashColor: Colors.redAccent.withOpacity(0.4),
                          onPressed: () {
                            print('like');
                          },
                          icon: Icon(Icons.favorite_border_rounded),
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
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
      ]),
    );
  }
}

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

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/pages/schools.dart';
import 'package:schooler/widgets/school_search.dart';
import 'package:schooler/widgets/widgets.dart';

class SchoolList extends StatefulWidget {
  static List<String> schoolList = [];
  SchoolList({Key? key}) : super(key: key);

  @override
  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  @override
  initState() {
    SchoolList.schoolList = [];
    resultList = scholen;
    super.initState();
  }

  final floatingSearchBarController = FloatingSearchBarController();

  List<String> resultList = [];

  // methode om nieuwe item in de lijst toe te voegen
  _addToList(String school) {
    setState(() {
      SchoolList.schoolList.add(school);
    });
  }

  // methode om item uit de lijst te verwijderen
  _deleteInList(String school) {
    setState(() {
      SchoolList.schoolList.removeAt(SchoolList.schoolList.indexOf(school));
    });
  }

// methode om de nieuwe rang orde bij te houden
  _update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    String school = SchoolList.schoolList.removeAt(oldIndex);

    SchoolList.schoolList.insert(newIndex, school);
  }

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
            for (var i = 0; i < SchoolList.schoolList.length; i++)
              Padding(
                key: ValueKey(SchoolList.schoolList[i]),
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
                                Text(SchoolList.schoolList[i],
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
                  if (SchoolList.schoolList.isEmpty) {
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 25),
                              child: Container(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Text(
                                      resultList[index],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                        'Straatnaan 12, stadnaam postcode',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54)),
                                  ],
                                )),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                        color: Colors.white,
                      ),
                    );
                  } else if (!SchoolList.schoolList
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 25, horizontal: 20.0),
                              child: Container(
                                child: Center(
                                    child: Column(
                                  children: [
                                    Text(
                                      resultList[index],
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                        'Straatnaan 12, stadnaam postcode',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.black54)),
                                  ],
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

/*

 height: 112,



* List.generate(widget.strings.length * 2, (index) {
          if (index.isEven) {
            return Flexible(
              flex: 3,
              child: BulletPoint(
                text: widget.strings[index ~/ 2],

              ),
            );
          } else {
            return Spacer(
              flex: 1,
            );
          }
        }),
*
*
* scholen.map((t) {
              return InkWell(
                onTap: () {print(t);},
                child: Container(
                    color: Colors.transparent,
                    height: 112,
                    child: Center(child: Text(t))),
              );
            }).toList(),
* */

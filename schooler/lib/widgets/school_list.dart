import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  @override
  initState() {
    getSchoolList = scholen;
    super.initState();
  }

  final floatingSearchBarController = FloatingSearchBarController();
  List<String> schoolList = [];
  List<String> getSchoolList = [];

  // methode om nieuwe item in de lijst toe te voegen
  _addToList(String school) {
    setState(() {
      schoolList.add(school);
    });
  }

  // methode om item uit de lijst te verwijderen
  _deleteInList(String school) {
    setState(() {
      schoolList.removeAt(schoolList.indexOf(school));
    });
  }

// methode om de nieuwe rang orde bij te houden
  _update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var item = schoolList.removeAt(oldIndex);

    schoolList.insert(newIndex, item);
  }

  _queryList(String query) {
    setState(() {
      getSchoolList = [];
      if(query.isEmpty) {
        getSchoolList = scholen;
      }
      else {
        scholen.forEach((element) {
          if(element.startsWith(query,0)) {
            getSchoolList.add(element);

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
            for (var i = 0; i < schoolList.length; i++)
              Padding(
                key: ValueKey(schoolList[i]),
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
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
                            backgroundColor: Color.fromRGBO(234, 144, 16, 1),
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
                            Text(schoolList[i],
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // delete button
                          Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _deleteInList(schoolList[i]);
                                  print('delete');
                                },
                                overlayColor:
                                MaterialStateProperty.all(Colors.red),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // info button
                          Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  print('school info pagina');
                                },
                                overlayColor:
                                MaterialStateProperty.all(Colors.grey),
                                child: const Icon(
                                  Icons.info_outline_rounded,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
                children: List.generate(getSchoolList.length, (index) {
                  if(schoolList.isEmpty) {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              _addToList(getSchoolList[index]);

                              floatingSearchBarController.close();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, left: 20.0),
                              child: Container(
                                height: 112,
                                child: Center(
                                    child: Text(
                                      getSchoolList[index],
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
                  }
                  else if (!schoolList.contains(getSchoolList[index]))  {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              _addToList(getSchoolList[index]);

                              floatingSearchBarController.close();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  right: 20.0, left: 20.0),
                              child: Container(
                                height: 112,
                                child: Center(
                                    child: Text(
                                      getSchoolList[index],
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
                  }
                  else {
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

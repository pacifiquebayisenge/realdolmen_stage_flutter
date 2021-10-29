import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final floatingSearchBarController = FloatingSearchBarController();
  List<String> schoolList = [];

  _addToList(String school) {
    setState(() {
      schoolList.add(school);
    });
  }

  _update(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    var item = schoolList.removeAt(oldIndex);

    schoolList.insert(newIndex, item);
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

            print(scholen);
            print(newIndex);

            print('list \n ${scholen[0]} \n${scholen[1]} \n${scholen[2]}');
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
                      SizedBox(
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
                                style:
                                    const TextStyle(fontWeight: FontWeight.w500)),
                            const Text('Straatnaan 12, stadnaam postcode',
                                style: TextStyle(fontSize: 11)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // info button om naar de school info pagina te surfen
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  print('delete');},
                                overlayColor: MaterialStateProperty.all(Colors.red),
                                child: Icon( Icons.close,
                                  color: Colors.redAccent,),
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            color: Colors.white,
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  print('school info pagina');},
                                overlayColor: MaterialStateProperty.all(Colors.grey),
                                child: Icon( Icons.info_outline_rounded,
                                color: Colors.grey,),
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

        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
          print(query);
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
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Container(
              color: Colors.white,
              child: Column(
                children: List.generate(scholen.length, (index) {
                  if (!schoolList.contains(scholen[index])) {
                    return Center(
                      child: Container(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey,
                            onTap: () {
                              _addToList(scholen[index]);

                              floatingSearchBarController.close();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20.0,left: 20.0),
                              child: Container(
                                height: 112,
                                child: Center(child: Text(scholen[index], maxLines: 2,
                                  overflow: TextOverflow.ellipsis,)),
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

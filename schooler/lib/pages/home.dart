import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:schooler/services/globals.dart' as globals;

import 'card_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<QuerySnapshot<Object?>> futureRegiRef;

  @override
  void initState() {
    // bron: https://stackoverflow.com/questions/58664293/futurebuilder-runs-twice
    futureRegiRef = futureFetch();

    super.initState();
  }

  // key voor de animatie lijst
  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // future methode om de delay animatie te simuleren
  void getRegisList(List<DocumentSnapshot> data) async {
    regiList = [];
    Future ft = Future(() => {});

    // haal lijst op uit de server
    data.forEach((element) {
      ft = ft.then((value) async {
        await Future.delayed(const Duration(milliseconds: 100), () {
          regiList.add(Registration.toRegi(
              element.id, element.data() as Map<String, dynamic>));
          _listKey.currentState!.insertItem(regiList.length - 1);
        });
      });
    });
  }

  final Stream<QuerySnapshot> list = FirebaseFirestore.instance
      .collection('registrations')
      .orderBy('date', descending: true)
      .snapshots();

  Future<QuerySnapshot<Object?>> futureFetch() async {
    return await FirebaseFirestore.instance
        .collection('registrations')
        .orderBy('date', descending: true)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: futureRegiRef,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<DocumentSnapshot> documents = snapshot.data!.docs;
            getRegisList(documents);
            return AnimatedList(
              key: _listKey,
              initialItemCount: regiList.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                if (index != regiList.length - 1) {
                  return SlideTransition(
                    position: animation
                        .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                    child: CustomCard(
                      registration: regiList[index],
                      navMethod: () {
                        // methode om naar de detail pagina te gaan
                        // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CardDetail(
                              c: CustomCard(
                                registration: regiList[index],
                                // geven lege methode mee omdat
                                // het ier enkel om de data gaat
                                // in de card UI
                                navMethod: () {},
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: SlideTransition(
                      position: animation
                          .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                      child: CustomCard(
                        registration: regiList[index],
                        navMethod: () {
                          // methode om naar de detail pagina te gaan
                          // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetail(
                                c: CustomCard(
                                  registration: regiList[index],
                                  // geven lege methode mee omdat
                                  // het ier enkel om de data gaat
                                  // in de card UI
                                  navMethod: () {},
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            );
            /*
            return ListView(

                children: documents
                    .map((doc) => CustomCard(registration: Registration.toRegi(doc.id, doc.data() as Map<String,dynamic>), navMethod: (){}))
                    .toList());
            */
          } else if (snapshot.hasError) {
            return Text('It s Error!');
          }

          return Center(child: CircularProgressIndicator());
        });

    /*
    return StreamBuilder<QuerySnapshot>(
        stream: list,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {}

/*
            list.listen((event) {

              if (event.docChanges.first.type == DocumentChangeType.removed) {

                _listKey.currentState!.removeItem(
                    event.docChanges.first.oldIndex,
                        (context, animation) => SlideTransition(
                      position: animation.drive(
                          Tween(begin: Offset(0, 0), end: Offset(1, 0))),
                      child: CustomCard(
                          registration: regiList[0], navMethod: () {}),
                    ));

                regiList.removeAt(event.docChanges.first.oldIndex);




                print(event.docChanges.first.oldIndex);
              }

              if (event.docChanges.first.type == DocumentChangeType.added) {
                print('added');
                // zet data om naar een Map<String,dynamic>
                Map<String, dynamic> data =
                    event.docChanges.first.doc.data() as Map<String, dynamic>;

                // zet om naar een Registration klasse object
                Registration newRegi =
                    Registration.toRegi(event.docChanges.first.doc.id, data);

                // voeg toe aan de regsitratielijst
                regiList.insert(0, newRegi);

                _listKey.currentState!.insertItem(0);

              }
              if (event.docChanges.first.type == DocumentChangeType.modified) {
                print('modified');
              }
            });

*/

            // haal de inschrijvingen uit de database
            getRegisList(snapshot.data!.docs);

            return AnimatedList(
              key: _listKey,
              // bron  https://stackoverflow.com/questions/65673773/why-do-i-get-the-error-renderbox-was-not-laid-out-renderviewporta3518-needs-l
              initialItemCount: regiList.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                //Map<String, dynamic> snapshotData = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                if (index != regiList.length - 1) {
                  return SlideTransition(
                    position: animation
                        .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                    child: CustomCard(
                        registration: regiList[index],
                        navMethod: () {
                          // methode om naar de detail pagina te gaan
                          // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetail(
                                  c: CustomCard(
                                    registration: regiList[index],
                                    // geven lege methode mee omdat
                                    // het ier enkel om de data gaat
                                    // in de card UI
                                    navMethod: () {},
                                  ),
                                ),
                              ));
                        }),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: SlideTransition(
                      position: animation
                          .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                      child: CustomCard(
                          registration: regiList[index],
                          navMethod: () {
                            // methode om naar de detail pagina te gaan
                            // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardDetail(
                                    c: CustomCard(
                                      registration: regiList[index],
                                      // geven lege methode mee omdat
                                      // het ier enkel om de data gaat
                                      // in de card UI
                                      navMethod: () {},
                                    ),
                                  ),
                                ));
                          }),
                    ),
                  );
                }
              },
            );
/*
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {

                Map<String, dynamic> data = document.data()! as Map<String,dynamic>;
                return CustomCard(registration: Registration.toRegi(document.id, data), navMethod: () {  },);
              }).toList(),
            );
            */
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Something is  waiting'),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return ListTile(
                    title: Text(data['voornaam']),
                    subtitle: Text(data['naam']),
                  );
                }).toList(),
              );
              /*
              return Scaffold(
                backgroundColor: Colors.indigo.shade800,
                body: AnimatedList(
                    key: _listKey,
                    // bron  https://stackoverflow.com/questions/65673773/why-do-i-get-the-error-renderbox-was-not-laid-out-renderviewporta3518-needs-l

                    initialItemCount: registerList.length,
                    itemBuilder:
                        (BuildContext context, int index, Animation<double> animation) {
                      if (index != registerList.length - 1) {
                        return InkWell(
                          //onTap: addThis,
                          child: SlideTransition(
                            position: animation
                                .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                            child: CustomCard(
                              registration: registerList[index],
                              navMethod: () {
                                // methode om naar de detail pagina te gaan
                                // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CardDetail(
                                        c: CustomCard(
                                            registration: registerList[index],
                                            // geven lege methode mee omdat
                                            // het ier enkel om de data gaat
                                            // in de card UI
                                            navMethod: () {}),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 100.0),
                          child: InkWell(
                            //onTap: addThis,
                            child: SlideTransition(
                              position: animation
                                  .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                              child: CustomCard(
                                registration: registerList[index],
                                navMethod: () {
                                  // methode om naar de detail pagina te gaan
                                  // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CardDetail(
                                          c: CustomCard(
                                              registration: registerList[index],
                                              // geven lege methode mee omdat
                                              // het ier enkel om de data gaat
                                              // in de card UI
                                              navMethod: () {}),
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                        );
                      }
                    }),
              );*/
            } else {
              // geen data => call to action pagina
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: Image(
                        image: AssetImage('lib/images/empty_space.gif'),
                        width: 250,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('No registrations yet'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('Create a new registration here'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.indigo.shade800,
                            shape: StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'new');
                          },
                          child: Icon(Icons.add_circle),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }

          return Center(
            child: Text('Something went wrong'),
          );
        });
    */
  }
}
/*
*
*
* Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DelayedDisplay(
            delay: Duration(milliseconds: 500),
            child: Image(
              image: AssetImage('lib/images/empty_space.gif'),
              width: 250,
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: Text('No registrations yet'),
          ),
          SizedBox(
            height: 10,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: Text('Create a new registration here'),
          ),
          SizedBox(
            height: 10,
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: 900),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child:  ElevatedButton(

                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: Colors.indigo.shade800,
                  shape: StadiumBorder(),
                ),


                onPressed: () {
                  Navigator.pushNamed(context, 'new');
                },
                child: Icon(Icons.add_circle),

              ),
            ),
          )
        ],
      ),
    );
*
* */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/services/globals.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:schooler/services/globals.dart' as globals;

import 'card_detail.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<QuerySnapshot<Object?>> _futureRegiRef;
   late Stream<QuerySnapshot> _streamList;

  @override
  void initState() {
    // bron: https://stackoverflow.com/questions/58664293/futurebuilder-runs-twice
   _futureRegiRef = _futureFetch();
    // stream reference om te gebruiken voor de real time changes

    _streamList = _streamFetch();
    super.initState();
  }


  Stream<QuerySnapshot> _streamFetch() {
    return  FirebaseFirestore.instance
        .collection('users').doc(thisUser.id).collection('registrations')
        .orderBy('date', descending: true)
        .snapshots();
  }

  // future reference methode om mee te geven aan de Future builder widget
  Future<QuerySnapshot<Object?>> _futureFetch() async {
     return await FirebaseFirestore.instance
        .collection('users').doc(thisUser.id).collection('registrations')
        .orderBy('date', descending: true)
        .get();
  }

  // key voor de animatie lijst
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // future methode om de delay animatie te simuleren
  void _getRegisList(List<DocumentSnapshot> data) async {
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


// snackbar widget om verwijdering van de registratie te bevestigen
  showSnackbar(String text) {

    final snackBar = SnackBar(
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          color: const Color.fromRGBO(54, 60, 69, 1),
          child:  Text(
            text,
            style:  GoogleFonts.montserrat(color: Colors.orange, fontWeight: FontWeight.w600 ),textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // methode pm de realtime changes in de database op te volgen
  void realtime() {


    _streamList.listen((event) {
      // kijken of het maar om 1 data gaat
      if (event.docChanges.length > 1) return;

      switch (event.docChanges.first.type) {
        // als er een inschrijving wordt toegevoegd
        case DocumentChangeType.added:
          {
            // nieuwe inschrijving toevoegen aan de lijst
            regiList.insert(
                0,
                Registration.toRegi(event.docChanges.first.doc.id,
                    event.docChanges.first.doc.data() as Map<String, dynamic>));

            // toevoeg animatie aan de animated list widget
            _listKey.currentState!.insertItem(0);

            // show bevestiging
            showSnackbar('Registration successfully added !');
          }
          break;

        // wanneer een inschrijving wordt verwijderd
        case DocumentChangeType.removed:
          {
            // verwijder animatie aan de animated list widget
            _listKey.currentState!.removeItem(
                event.docChanges.first.oldIndex,
                (context, animation) => SlideTransition(
                      position: animation
                          .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                      child: CustomCard(
                          registration:
                              regiList[event.docChanges.first.oldIndex],
                          navMethod: () {}),
                    ));

            //  inschrijving verwijderen uit de lijst
            regiList.removeAt(event.docChanges.first.oldIndex);

            // show bevestiging
            showSnackbar('Registration successfully deleted !');
          }
          break;

      // wanneer een inschrijving wordt gewijzigd
        case DocumentChangeType.modified:
          {
            // verwijder animatie aan de animated list widget
            _listKey.currentState!.removeItem(
                event.docChanges.first.oldIndex,
                (context, animation) => SlideTransition(
                      position: animation
                          .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                      child: CustomCard(
                          registration:
                              regiList[event.docChanges.first.oldIndex],
                          navMethod: () {}),
                    ));

            //  inschrijving verwijderen uit de lijst
            regiList.removeAt(event.docChanges.first.oldIndex);

            // nieuwe inschrijving toevoegen aan de lijst
            regiList.insert(
                event.docChanges.first.oldIndex,
                Registration.toRegi(event.docChanges.first.doc.id,
                    event.docChanges.first.doc.data() as Map<String, dynamic>));

            // toevoeg animatie aan de animated list widget
            _listKey.currentState!.insertItem(event.docChanges.first.oldIndex);

            // show bevestiging
            showSnackbar('Registration successfully modified !');
          }
          break;
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'lib/images/81.png',
          ),
          repeat: ImageRepeat.repeat,
          fit: BoxFit.scaleDown,
        ),
      ),
      child: FutureBuilder<QuerySnapshot>(
        future: _futureRegiRef,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) print('none');

          if (snapshot.connectionState == ConnectionState.active)
            print('active');

          if (snapshot.connectionState == ConnectionState.waiting) {
            print('waiting');
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Column(
                  children: const [
                    SpinKitSpinningLines(
                      color: Color.fromRGBO(234, 144, 16, 1),
                      size: 150,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text('Loading...'),
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            print('done');
           realtime();
          }

          if (snapshot.hasData) {
            if (snapshot.data!.docs.length > 0) {
               List<DocumentSnapshot> documents = snapshot.data!.docs;

              _getRegisList(documents);

              return DelayedDisplay(
                delay: const Duration(milliseconds: 200),
                child: AnimatedList(
                  key: _listKey,
                  initialItemCount: regiList.length,
                  itemBuilder: (BuildContext context, int index,
                      Animation<double> animation) {

                    if (index != regiList.length - 1) {
                      return SlideTransition(
                        position: animation.drive(
                            Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                        child: CustomCard(
                          registration: regiList[index],
                          navMethod: () {
                            // methode om naar de detail pagina te gaan
                            // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CardDetail(
                                  card: CustomCard(
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
                      // als het de laatste kaart is
                      // geef een kaart terug met 100 bottom padding
                      // zodat bottom nav bar niet overlap wordt
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: SlideTransition(
                          position: animation.drive(
                              Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                          child: CustomCard(
                            registration: regiList[index],
                            navMethod: () {
                              // methode om naar de detail pagina te gaan
                              // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CardDetail(
                                    card: CustomCard(
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
                ),
              );
            } else {
              // geen inschrijvingen: call to action
              return Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: Image(
                        image: AssetImage('lib/images/empty_space.gif'),
                        width: 250,
                      ),
                    ),
                    const DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('No registrations yet'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('Create a new registration here'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DelayedDisplay(
                      delay: const Duration(milliseconds: 900),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(100)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.indigo.shade800,
                            shape: const StadiumBorder(),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, 'new');
                          },
                          child: const Icon(Icons.add_circle),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
          // something went wrong
          if (snapshot.hasError) {
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: const [
                    DelayedDisplay(
                      delay: Duration(milliseconds: 500),
                      child: Image(
                        image: AssetImage('lib/images/error.gif'),
                        width: 350,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('Something went wrong'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    DelayedDisplay(
                      delay: Duration(milliseconds: 900),
                      child: Text('Please try again later'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          }

          // loading screen
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: Column(
                children: const [
                  SpinKitSpinningLines(
                    color: Color.fromRGBO(234, 144, 16, 1),
                    size: 150,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        },
      ),
    );
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

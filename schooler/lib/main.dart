import 'dart:math';

import 'package:flutter/material.dart';
import 'package:schooler/pages/home.dart';
import 'package:schooler/pages/new.dart';
import 'package:schooler/pages/notifications.dart';
import 'package:schooler/pages/schools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schooler/widgets/widgets.dart';

import 'classes/registration.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
 // await Firebase.initializeApp();
  runApp(MaterialApp(
    color: Colors.indigo.shade800,
    theme: ThemeData(
      primaryColor: Colors.indigo.shade800,
    ),
    home: App(),
    routes: {
      'home': (context) => Home(),
      'new': (context) => New(),
      'notifications': (context) => Notifications(),
      'schools': (context) => Schools(),
    },
  ));
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}
/*FutureBuilder(

        future: _fbApp,
      builder: ( context, snapshot) {
         if (snapshot.hasError) {
           print('You have an error ! ${snapshot.error.toString()}');
           return Text('Something went wrong!');
         } else if (snapshot.hasData) {
           return App();
         } else {
           return Center(
             child: CircularProgressIndicator(),
           );
         }
      },)*/
class _AppState extends State<App> {

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }




  // Om de geselecteerde pagina te onthouden
  int _selectedIndex = 0;

  // Methode wanneer me nee knop klikt
   void _onItemTapped(int index) async {
      setState(()  {
      switch (index) {
        case 0:
          {
            Random r = new Random();
            Registration.newRegi(
                voornaam: '${r.nextInt(100)}',
                naam: 'Pokers',
                rijksNr: '97042025942',
                straat: 'Winkelstraat',
                huisNr: 15,
                busNr: '',
                postcode: 1500,
                gemeente: 'Halle',
                oVoornaam1: 'Felicien',
                oNaam1: 'Brabant',
                beroep1: 'Bakker',
                berStraat1: 'Bakkerstaat',
                berHuisNr1: 13,
                berBusNr1: '',
                berPostcode1: 1500,
                berGemeente1: 'Halle',
                oVoornaam2: 'Melina',
                oNaam2: 'Hangover',
                beroep2: 'Tandarts',
                berStraat2: 'Ziekelaan',
                berHuisNr2: 12,
                berBusNr2: '',
                berPostcode2: 1500,
                berGemeente2: 'Halle',
                vraagGOK: true,
                vraagTN: true, schoolList: null);

            print("Open home page");
            // Navigator.pushReplacementNamed(context, '/');
          }
          break;

        case 1:
          {
            // popup pagina niet in de main body weer geven
            //_selectedIndex = 0;
            print("Open new page");
            Navigator.pushNamed(context, 'new');
            //Navigator.of(context).push(_createRoute());
            return;
          }
          break;

        case 2:
          {
            print("Open notification page");

            //Navigator.pushReplacementNamed(context, 'notifications');
          }
          break;

        case 3:
          {
            print("Open schools page");
            //Navigator.pushReplacementNamed(context, 'schools');
          }
          break;

        default:
          {
            print("Invalid choice");
          }
          break;
      }
      // Verander de knop naar de geselecteerde pagina
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget? test() {
    if (_selectedIndex == 2) {
      return null;
    }
    return AppBar(
      backgroundColor: Colors.indigo.shade800,
      elevation: 0,
      title: const Center(
        child: Text('Schooler'),
      ),
    );
  }

  final screens = [Home(), New(), Notifications(), Schools()];

  @override
  Widget build(BuildContext context) {

    if(_error) {
      print('You have an error !');
      return Text('Something went wrong!');
    }

    if (!_initialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        backgroundColor: Colors.indigo.shade800,
        // bool/ pagina content kan achter de bottom nav bar = pagina neemt heel scherm over
        // voorlopig false => moeite met bottom padding in Notification pagina
        // bron: https://stackoverflow.com/questions/59491186/extend-container-behind-bottom-navigation-flutter
        extendBody:  true,

        appBar: test(),
        body: SafeArea(
            bottom: false,
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: screens[_selectedIndex])),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(1),
                  spreadRadius: -5,
                  blurRadius: 15,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: BottomNavigationBar(

                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle),
                    label: 'New',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school_sharp),
                    label: 'Schools',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.indigo.shade800,
                onTap:  _onItemTapped,
              ),
            ),
          ),
        ));





  }
}

/*
Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: -5,
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            child: BottomNavigationBar(

              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle),
                  label: 'New',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'Notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school_sharp),
                  label: 'Schools',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.blueAccent,
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
 */

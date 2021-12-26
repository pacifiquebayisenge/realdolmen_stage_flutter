import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/pages/home.dart';
import 'package:schooler/pages/login.dart';
import 'package:schooler/pages/new.dart';
import 'package:schooler/pages/notifications.dart';
import 'package:schooler/pages/schools.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schooler/services/globals.dart';
import 'package:schooler/widgets/widgets.dart';

import 'classes/registration.dart';
import 'classes/school.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    if (user == null) return;

  });
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.indigo.shade800,
    theme: ThemeData(

      primaryColor: Colors.indigo.shade800,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.black12),
        color: Colors.blue.shade900,
      ),
    ),
    home: App(),
    routes: {

      'login': (context) => Login(),
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

class _AppState extends State<App> {
  // staat van flutter firebase
  bool _initialized = false;
  bool _error = false;

  // async funtie om firebase te initialiseren
  void initializeFlutterFire() async {
    try {
      // wachten tot firebase init
      await Firebase.initializeApp();
      await FirebaseAuth.instance.signOut();
      setState(() {
        _initialized = true;
        userState();
        print("FIRE");

      });
    } catch (e) {
      // bij firebase init error
      setState(() {
        _error = true;
        print("NO FIRE ");
      });
    }
  }

  @override
   initState()  {
    initializeFlutterFire();

    super.initState();

  }

  void userState() async {
    schools = [];
   FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user == null) {
        setState(() {
          _selectedIndex = 4;
          // TODO: empy user class here
        });

        print('User is currently signed out!');
      } else {
        await thisUser.getUser(user.uid);
        bool profileComplete = await thisUser.userInfoCheck(user.uid);

        schools = await SchoolObject.getAllSchools();
        thisUser.favoSchoolsList = await SchoolObject.getAllFavoSchools();


        Future.delayed(const Duration(milliseconds: 2000), ()  {

          setState(()  {

            _selectedIndex = 0;

          });
        });


        if (profileComplete == false) _showDialog();

        print('User is signed in!');
      }
    });
  }

  _showDialog() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => ProfileDialog(),
      );
    });
  }

  // Om de geselecteerde pagina te onthouden
  int _selectedIndex = 0;

  // Methode wanneer me nee knop klikt
  void _onItemTapped(int index) async {
    setState(() {
      switch (index) {
        case 0:
          {


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


  // aangepaste appbar
  PreferredSizeWidget? _customAppBar() {
    if (_selectedIndex == 2 || _selectedIndex == 4) {
      return null;
    }
    return AppBar(
      actions: [

        if(_selectedIndex == 0)
          PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Account', 'Log out'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })

      ],
      flexibleSpace: const Image(
        image: AssetImage('lib/images/81.png'),
        fit: BoxFit.cover,
        repeat: ImageRepeat.repeat,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Schooler',
        style: GoogleFonts.montserrat(
            fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
      ),
    );
  }

  // wat te doen met de geklikte menu buttons
  Future<void> handleClick(String value) async {

    switch (value)
    {
      case 'Account': {

      }
      break;
      case 'Log out': {
        await FirebaseAuth.instance.signOut();
      }
      break;
    }
  }

  // aangepaste navigatie bar
  Widget? _customBottomNavBar() {
    if (_selectedIndex == 4) {
      return null;
    }
    return Padding(
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
          borderRadius: BorderRadius.all(const Radius.circular(20.0)),
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
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  final screens = [
    const Home(),
    const New(),
     Notifications(),
    const Schools(),
    const Login(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print('You have an error !');
      return Text('Something went wrong!');
    }

    if (!_initialized) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }



    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      // bool/ pagina content kan achter de bottom nav bar = pagina neemt heel scherm over
      // voorlopig false => moeite met bottom padding in Notification pagina
      // bron: https://stackoverflow.com/questions/59491186/extend-container-behind-bottom-navigation-flutter
      extendBody: true,
      resizeToAvoidBottomInset: false,
      appBar: _customAppBar(),
      body: SafeArea(
          bottom: false,
          child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: screens[_selectedIndex])),
      bottomNavigationBar: _customBottomNavBar(),
    );
  }
}



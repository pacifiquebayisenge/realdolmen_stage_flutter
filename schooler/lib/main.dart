import 'package:flutter/material.dart';
import 'package:schooler/pages/home.dart';
import 'package:schooler/pages/new.dart';
import 'package:schooler/pages/notifications.dart';
import 'package:schooler/pages/schools.dart';
import 'package:schooler/widgets/widgets.dart';

void main() {
  runApp(MaterialApp(
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

class _AppState extends State<App> {
  // Om de geselecteerde pagina te onthouden
  int _selectedIndex = 0;

  // Methode wanneer me nee knop klikt
  void _onItemTapped(int index) {
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
            _selectedIndex = 0;
            print("Open new page");
            Navigator.of(context).push(_createRoute());
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

  final screens = [Home(), New(), Notifications(), Schools()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Schooler'),
        ),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
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
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const New(),
      transitionsBuilder: (context, animation, secondairyAnimation, child) {
        var curve = Curves.ease;
        var curveTween = CurveTween(curve: curve);

        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);


        return SlideTransition(position: offsetAnimation, child: child);
      });
}

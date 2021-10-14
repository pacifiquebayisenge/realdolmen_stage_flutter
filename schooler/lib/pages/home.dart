import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:schooler/services/globals.dart' as globals;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: Image(
                    image: AssetImage('lib/images/empty_space.gif'),
                    width: 250,
                  ),
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 900),
                  child: Text('Nog geen inschrijvingen'),
                ),
                DelayedDisplay(
                  delay: Duration(milliseconds: 900),
                  child: Text('Klik op '),
                ),
                DelayedDisplay(
                    delay: Duration(milliseconds: 900),
                    child: Icon(Icons.add_circle)),
                DelayedDisplay(
                  delay: Duration(milliseconds: 900),
                  child: Text('om een nieuwe inschrijving te maken'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';

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
            child: DelayedDisplay(
              delay: Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(image: AssetImage('lib/images/empty_space.gif'),width: 250,),
                  Text('Nog geen inschrijvingen'),
                  Text('Klik op '),
                  Icon(Icons.add_circle),
                  Text('om een nieuwe inschrijving te maken')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
      body: SafeArea(

        child: Center(

          child: Container(

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Text('Nog geen inschrijvingen')],
            ),
          ),
        ),
      ),
    );
  }
}

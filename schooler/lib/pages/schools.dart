import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';

class Schools extends StatefulWidget {
  const Schools({Key? key}) : super(key: key);

  @override
  _SchoolsState createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("schools page"),
      ),
    );
  }
}

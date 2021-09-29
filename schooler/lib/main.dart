import 'package:flutter/material.dart';
import 'package:schooler/pages/home.dart';

void main() {
  runApp( MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
    },
  ));
}
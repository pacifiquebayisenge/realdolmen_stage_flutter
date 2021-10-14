import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  List<Widget> _list = [
    CustomCard(),
    CustomCard(),
    CustomCard(),
    CustomCard(),
  ];



  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomCard(),
      )
    );
  }
}

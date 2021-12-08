import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooler/classes/registration.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key, required this.registration, required this.navMethod})
      : super(key: key);

  // inschrijving van de student
  final Registration registration;

  // void methode als paramater om naar
  // de detail pagina van deze kaart te surfen
  // nullable want we geven niet altijd een methode mee

  final VoidCallback? navMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(

        boxShadow: [
          BoxShadow(
            color: Colors.black38.withOpacity(.5),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: -5.0, //extend the shadow
            offset: const Offset(
              15.0, // Move to right 10  horizontally
              5.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Card(
        elevation: 14,
        shadowColor: Colors.black38,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onLongPress: () {
            navMethod!();
          },
          child: Container(
            decoration: const BoxDecoration(

            ),
            padding: const EdgeInsets.all(16),
            child: CardContent(registration),
          ),
        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  const CardContent(this._registration, {Key? key}) : super(key: key);
  final Registration _registration;

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  // methode om random percentage te berekennen
  int getRandom() {
    Random rdm = new Random();
    // random getal genereren van 0 (incl.) tot 101 (ecl.)
    // om te delen door 100
    // omdat de LinearPercentIndicator enkel double van 0 tot en met 1 accepteert
    int progPerc = rdm.nextInt(11);

    return progPerc;
  }

  @override
  void initState() {
    super.initState();
    // voer de functie uit na dat de build functie van de widgets afgelopen is
    // bron: 7:44 => https://www.youtube.com/watch?v=i9g2kSuWutk&list=PL4cUxeGkcC9gP1qg8yj-Jokef29VRCLt1&index=9
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _linearPercWidth = 0.8;
    });
  }

  double _linearPercWidth = 0;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${this.widget._registration.voornaam} ${this.widget._registration.naam}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 5),
      Text(
        '${this.widget._registration.straat} ${this.widget._registration.huisNr}, ${this.widget._registration.postcode} ${this.widget._registration.gemeente}',
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
      const SizedBox(height: 10),
      Text('School preferences: ${getRandom()}'),
      Text('Enrollments state: pending'),

      /*
      // ingeschrijving vooruitgang
      Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        // om de afmetingen te krijgen van de parent widget
        // bron: https://stackoverflow.com/questions/41558368/how-can-i-layout-widgets-based-on-the-size-of-the-parent
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: LinearPercentIndicator(
            padding: EdgeInsets.only(top: 0, bottom: 10),
            lineHeight: 4.0,
            percent: getRandom().floorToDouble()/10,
            animation: true,
            animationDuration: 1000,
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
        ),
      ),

      // scholen voorkeur
      Wrap(
        children: [
          Chip(
            avatar: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.grey,
              child: Text(
                '1',
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w900),
              ),
            ),
            label: Text('Don Bosco'),
          ),
          SizedBox(
            width: 5,
          ),
          Chip(
              avatar: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey,
                child: Text(
                  '2',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.w900),
                ),
              ),
              label: Text('Heilig Hart')),
          SizedBox(
            width: 5,
          ),
          Chip(
              avatar: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.grey,
                child: Text(
                  '3',
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.w900),
                ),
              ),
              label: Text('Atheneum')),
        ],
      ),

      */
    ]);
  }
}

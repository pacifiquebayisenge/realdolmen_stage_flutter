import 'dart:math';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schooler/dummy_data/data.dart' as dummy;
import 'package:schooler/pages/card_detail.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {Key? key,
      required this.voornaam,
      required this.naam,
      required this.navMethod})
      : super(key: key);

  // naam en voornaam van de student
  final String voornaam;
  final String naam;

  // void methode als paramater om naar
  // de detail pagina van deze kaart te surfen
  // nullable want we geven niet altijd een methode mee

  final VoidCallback? navMethod;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.lightBlueAccent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onLongPress: () {
          navMethod!();
        },
        child: Container(
          padding: EdgeInsets.all(16),
          child: CardContent(voornaam, naam),
        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  const CardContent(this.voornaam, this.naam, {Key? key}) : super(key: key);
  final String voornaam;
  final String naam;

  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {
  // methode om random percentage te berekennen
  double getProgress() {
    Random rdm = new Random();
    // random getal genereren van 0 (incl.) tot 101 (ecl.)
    // om te delen door 100
    // omdat de LinearPercentIndicator enkel double van 0 tot en met 1 accepteert
    double progPerc = rdm.nextInt(101) / 100;

    return progPerc;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
           right: 0,
          width: 60,
          height: 60,
          child: CircleAvatar(
            child: Text('Girl/Boy icon',
            textAlign: TextAlign.center,),
            backgroundColor: Colors.grey,
          ),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            '${this.widget.voornaam} ${this.widget.naam}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('Holleveldweg 56, 1500 Halle \n\n'
              'Dossier in behandeling: \n'
              'Scholen voorkeur  '),
          Wrap(
            children: [
              Chip(label: Text('Don Bosco')),
              Chip(label: Text('Heilig Hart')),
              Chip(label: Text('Atheneum')),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: LinearPercentIndicator(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              lineHeight: 4.0,
              percent: getProgress(),
              animation: true,
              animationDuration: 1000,
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
          ),
        ]),
      ],
    );
  }
}

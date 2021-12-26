import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        '${widget._registration.voornaam} ${widget._registration.naam}',
        style: GoogleFonts
            .montserrat(
            color: Colors.grey
                .shade900,
            fontSize: 15,
            fontWeight:
            FontWeight
                .w700),
      ),
      const SizedBox(height: 5),
      Text(
        '${widget._registration.straat} ${widget._registration.huisNr}, ${this.widget._registration.postcode} ${widget._registration.gemeente}',
        style: GoogleFonts
            .montserrat(

            color: Colors.black54,
            fontSize: 10,
            fontWeight:
            FontWeight
                .w500),
      ),
      const SizedBox(height: 10),
    Text('School preferences: ${widget._registration.schoolList!.length}', style: GoogleFonts
        .montserrat(

        color: Colors.grey
            .shade800,
        fontSize: 12,
        fontWeight:
        FontWeight
            .w500)),
      Text('Enrollments state: pending', style: GoogleFonts
          .montserrat(

          color: Colors.grey
              .shade800,
          fontSize: 12,
          fontWeight:
          FontWeight
              .w500)),


    ]);
  }
}

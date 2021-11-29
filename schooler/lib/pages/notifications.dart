import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:schooler/dummy_data/data.dart';

import 'card_detail.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  @override
  void initState() {
    super.initState();
    // voer de functie uit na dat de build functie van de widgets afgelopen is
    // bron: 7:44 => https://www.youtube.com/watch?v=i9g2kSuWutk&list=PL4cUxeGkcC9gP1qg8yj-Jokef29VRCLt1&index=9
    WidgetsBinding.instance!.addPostFrameCallback((_)  {


    });
  }

  // lijst om registraties op te halen
  List<Registration> registerList = [];


  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();


  void addThis() {
    Random r = new Random();

    registerList.insert(
        0,
        new Registration(
          id: '${r.nextInt(1000000)}',
            voornaam: '${r.nextInt(100)}',
            naam: 'Pokers',
            rijksNr: '97042025942',
            straat: 'Winkelstraat',
            huisNr: 15,
            busNr: '',
            postcode: 1500,
            gemeente: 'Halle',
            oVoornaam1: 'Felicien',
            oNaam1: 'Brabant',
            beroep1: 'Bakker',
            berStraat1: 'Bakkerstaat',
            berHuisNr1: 13,
            berBusNr1: '',
            berPostcode1: 1500,
            berGemeente1: 'Halle',
            oVoornaam2: 'Melina',
            oNaam2: 'Hangover',
            beroep2: 'Tandarts',
            berStraat2: 'Ziekelaan',
            berHuisNr2: 12,
            berBusNr2: '',
            berPostcode2: 1500,
            berGemeente2: 'Halle',
            vraagGOK: true,
            vraagTN: true, schoolList: []));

    _listKey.currentState!.insertItem(0);





    /*
   Registration.newRegi(
       voornaam: '${r.nextInt(100)}',
       naam: 'Pokers',
       rijksNr: '97042025942',
       straat: 'Winkelstraat',
       huisNr: 15,
       busNr: '',
       postcode: 1500,
       gemeente: 'Halle',
       oVoornaam1: 'Felicien',
       oNaam1: 'Brabant',
       beroep1: 'Bakker',
       berStraat1: 'Bakkerstaat',
       berHuisNr1: 13,
       berBusNr1: '',
       berPostcode1: 1500,
       berGemeente1: 'Halle',
       oVoornaam2: 'Melina',
       oNaam2: 'Hangover',
       beroep2: 'Tandarts',
       berStraat2: 'Ziekelaan',
       berHuisNr2: 12,
       berBusNr2: '',
       berPostcode2: 1500,
       berGemeente2: 'Halle',
       vraagGOK: true,
       vraagTN: true);

     */
  }

  void removeThis() {
    regiList.removeAt(0);
    _listKey.currentState!.removeItem(
        0,
        (context, animation) => SlideTransition(
              position: animation
                  .drive(Tween(begin: Offset(1, 0), end: const Offset(0, 0))),
              child:
                  CustomCard(registration: registerList[0], navMethod: () {}),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.indigo.shade700,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(

            backgroundColor: Colors.indigo.shade800,
            pinned: false,
            snap: false,
            floating: false,
            expandedHeight: 100.0,
            flexibleSpace:  FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Notifications', style: GoogleFonts.montserrat(

                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),),
              background:   const Image(
                image: AssetImage('lib/images/81.png'),
        fit: BoxFit.cover,
                repeat: ImageRepeat.repeat,
      ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return Container(

                  decoration:  BoxDecoration(
                   color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  // color: index.isOdd ? Colors.white : Colors.black12,
                  //height: 100.0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                    child: Column(
                      children: List.generate(
                        10,
                            (index) {
                          if (index == 9) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom:100.0),
                              child: Container(
                                color: index.isOdd
                                    ? Colors.white
                                    : Colors.grey,
                                height: 100.0,
                                child: Center(
                                  child: Text('$index', textScaleFactor: 5),
                                ),
                              ),
                            );
                          }
                          else {
                            return Container(
                              color: index.isOdd
                                  ? Colors.white
                                  : Colors.grey,
                              height: 100.0,
                              child: Center(
                                child: Text('$index', textScaleFactor: 5),
                              ),
                            );
                          }
                        } ,
                      ),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }


}

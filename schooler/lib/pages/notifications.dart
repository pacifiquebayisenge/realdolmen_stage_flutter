import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
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
  // lijst om registraties op te halen
  List<Registration> registerList = [];

  @override
  void initState() {
    super.initState();
    // voer de functie uit na dat de build functie van de widgets afgelopen is
    // bron: 7:44 => https://www.youtube.com/watch?v=i9g2kSuWutk&list=PL4cUxeGkcC9gP1qg8yj-Jokef29VRCLt1&index=9
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getRegisList();
    });
  }

  void getRegisList() {
    Future ft = Future(() => {});

    // omgekeerde lijst zodat laaste ingeschreven van boven wordt weergegeven
    regiList.reversed.toList().forEach((element) {
      // een future zodat men een wacht tijd kan simuleren om elke
      // kaart UI om de beurt te laten verschijnen met een animatie
      ft = ft.then((value) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          registerList.add(element);
          _listKey.currentState!.insertItem(registerList.length - 1);
        });
      });
    });
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void addThis() {
    Random r = new Random();

    registerList.insert(
        0,
        new Registration(
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
            vraagTN: true));

    _listKey.currentState!.insertItem(0);
  }

  void removeThis() {
    regiList.removeAt(0);
    _listKey.currentState!.removeItem(
        0,
        (context, animation) => SlideTransition(
              position: animation
                  .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
              child: CustomCard(
                  registration: registerList[0],
                navMethod: () {}

              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
          key: _listKey,
          // bron  https://stackoverflow.com/questions/65673773/why-do-i-get-the-error-renderbox-was-not-laid-out-renderviewporta3518-needs-l
          shrinkWrap: true,
          initialItemCount: registerList.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return InkWell(
              onTap: addThis,
              child: SlideTransition(
                position: animation
                    .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                child: CustomCard(
                  registration: registerList[index],
                  navMethod: () {
                    // methode om naar de detail pagina te gaan
                    // bron: https://www.youtube.com/watch?v=4naljQa5QA8 & https://github.com/iamshaunjp/flutter-animations/blob/lesson-4/ninja_trips/lib/shared/tripList.dart
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardDetail(
                            c: CustomCard(
                              registration: registerList[index],
                              // geven lege methode mee omdat
                              // het ier enkel om de data gaat
                              // in de card UI
                              navMethod: () {}
                            ),
                          ),
                        ));
                  },
                ),
              ),
            );
          }),
    );
  }

  buildItem(item, int index, Animation<double> animation) {}
}

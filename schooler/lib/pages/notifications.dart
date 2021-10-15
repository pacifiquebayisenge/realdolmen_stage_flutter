import 'package:flutter/material.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/widgets/widgets.dart';
import 'package:schooler/dummy_data/data.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<Widget> cardList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getCardsList();
    });
  }

  void getCardsList() {
    Future ft = Future(() {});

    regiList.forEach((element) {
      ft = ft.then((_) {
        return Future.delayed(const Duration(milliseconds: 100), () {
          cardList.add(CustomCard(
            voornaam: element.voornaam,
            naam: element.naam,
          ));
          print('Lijst count ${cardList.length}');
          _listKey.currentState!.insertItem(cardList.length - 1);

        });
      });
    });


    /*
    cardList.add(SizedBox(
      height: 250,
    ));
    */
  }

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void addThis() {
    regiList.insert(
        0,
        new Registration(
            voornaam: 'ggggggggg',
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
            position:
                animation.drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
            child: InkWell(
              onTap: () => {
                print('Lijst count ${regiList.length}'),
                addThis(),
                print('Lijst count ${regiList.length}')
              },
              child: CustomCard(
                  voornaam: 'regiList[index].voornaam',
                  naam: 'regiList[index].naam'),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
          key: _listKey,
          shrinkWrap: true,
          initialItemCount: cardList.length,
          itemBuilder:
              (BuildContext context, int index, Animation<double> animation) {
            return SlideTransition(
                position: animation
                    .drive(Tween(begin: Offset(1, 0), end: Offset(0, 0))),
                child: InkWell(
                  onTap: () => {
                    print('Lijst count ${regiList.length}'),
                    removeThis(),
                    print('Lijst count ${regiList.length}')
                  },
                  child: CustomCard(
                      voornaam: regiList[index].voornaam,
                      naam: regiList[index].naam),
                ));
          }),
    );
  }

  buildItem(item, int index, Animation<double> animation) {}
}

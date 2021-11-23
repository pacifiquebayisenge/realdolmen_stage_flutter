import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Registration {
  // id
  late final String id;

  // basis info voor de ingeschrevende
  late final String voornaam;
  late final String naam;
  late final String rijksNr;

  // domicilierings adres
  late final String straat;
  late final int huisNr;
  late final String? busNr;
  late final int postcode;
  late final String gemeente;

  // vragen over eerste ouder
  late final String? oVoornaam1;
  late final String? oNaam1;
  late final String? beroep1;
  late final String? berStraat1;
  late final int? berHuisNr1;
  late final String? berBusNr1;
  late final int? berPostcode1;
  late final String? berGemeente1;

  // vragen over tweede ouder
  late final String? oVoornaam2;
  late final String? oNaam2;
  late final String? beroep2;
  late final String? berStraat2;
  late final int? berHuisNr2;
  late final String? berBusNr2;
  late final int? berPostcode2;
  late final String? berGemeente2;

  // vooorangsvragen
  late final bool? vraagGOK;
  late final bool? vraagTN;

  // schoolLijst
  late final List<dynamic> schoolList;
// Firestore collectie reference naar de regstratie collectie
  CollectionReference _regiRef =
      FirebaseFirestore.instance.collection('registrations');

  Registration(
      {required this.id,
      required this.voornaam,
      required this.naam,
      required this.rijksNr,
      required this.straat,
      required this.huisNr,
      required this.busNr,
      required this.postcode,
      required this.gemeente,
      required this.oVoornaam1,
      required this.oNaam1,
      required this.beroep1,
      required this.berStraat1,
      required this.berHuisNr1,
      required this.berBusNr1,
      required this.berPostcode1,
      required this.berGemeente1,
      required this.oVoornaam2,
      required this.oNaam2,
      required this.beroep2,
      required this.berStraat2,
      required this.berHuisNr2,
      required this.berBusNr2,
      required this.berPostcode2,
      required this.berGemeente2,
      required this.vraagGOK,
      required this.vraagTN,
      required this.schoolList});

  // methode om de geboorte datum te bekomen
  String getBDate() {
    // de eerste 6 cijfer die de datum voorstellen opsplitsen in hun respectvoolle betekenins
    String year = this.rijksNr.substring(0, 2);
    String month = this.rijksNr.substring(2, 4);
    String day = this.rijksNr.substring(4, 6);

    // Het jaar van de huidige datum omzette naar string
    // daarvan enkel de 2 laatste cijfer nemen en dan omzette naar int
    // verminderen met het jaartal uit rijksregister nummer
    // als het resultaat positief is dan is de persoon geboren VANAF 2000
    // als negatief dan is de persoon geboren VOOR 2000
    if (int.parse(DateTime.now().year.toString().substring(3, 4)) -
            int.parse(year) >
        0) {
      year = '20${year}';
    } else {
      year = '19${year}';
    }

    return '$day-$month-$year';
  }

  // methode om het geslacht van de persoon te achterhalen
  String getGender() {
    // de 3 delige cijfers na die van de geboortedatum ophalen
    String nr = this.rijksNr.substring(6, 9);

    // als getal even is dan is het een vrouw zoniet dan is het een man
    if (int.parse(nr) % 2 == 0) return 'vrouw';
    return 'man';
  }

  @override
  String toString() {
    return '''
        voornaam : $voornaam
        naam : $naam
        rijksNr : $rijksNr
        \n
        --- adres ---
        \n
        straat : $straat
        huisNr : $huisNr
        busNr : $busNr
        postcode : $postcode
        gemeente : $gemeente
        \n
        --- ouder 1 ---
        \n
        oVoornaam1: $oVoornaam1
        oNaam1: $oNaam1
        beroep1: $beroep1
        berStraat1: $berStraat1
        berHuisNr1: $berHuisNr1
        berBusNr1: $berBusNr1
        berPostcode1: $berPostcode1
        berGemeente1: $berGemeente1
        \n
        --- ouder 2 ---
        \n
        oVoornaam2: $oVoornaam2
        oNaam2: $oNaam2
        beroep2: $beroep2
        berStraat2: $berStraat2
        berHuisNr2: $berHuisNr2
        berBusNr2: $berBusNr2
        berPostcode2: $berPostcode2
        berGemeente2: $berGemeente2
        \n
        --- voorrangsvragen --- 
        \n
        vraagGOK: $vraagGOK
        vraagTN: $vraagTN
        \n
         --- schoollijst --- 
        \n
        schoollijst: $schoolList

        ''';
  }

// statische methode om lijst van registraties op te halen uit de database
  static Future<List<Registration>> getRegiList() async {
    List<Registration> regiList = [];

    await FirebaseFirestore.instance
        .collection('registrations')
        .orderBy('date')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Registration regi = Registration(
            id: doc.id,
            voornaam: doc['voornaam'],
            naam: doc['naam'],
            rijksNr: doc['rijksNr'],
            straat: doc['straat'],
            huisNr: doc['huisNr'],
            busNr: doc['busNr'],
            postcode: doc['postcode'],
            gemeente: doc['gemeente'],
            oVoornaam1: doc['oVoornaam1'],
            oNaam1: doc['oNaam1'],
            beroep1: doc['beroep1'],
            berStraat1: doc['berStraat1'],
            berHuisNr1: doc['berHuisNr1'],
            berBusNr1: doc['berBusNr1'],
            berPostcode1: doc['berPostcode1'],
            berGemeente1: doc['berGemeente1'],
            oVoornaam2: doc['oVoornaam2'],
            oNaam2: doc['oNaam2'],
            beroep2: doc['beroep2'],
            berStraat2: doc['berStraat2'],
            berHuisNr2: doc['berHuisNr2'],
            berBusNr2: doc['berBusNr2'],
            berPostcode2: doc['berPostcode2'],
            berGemeente2: doc['berGemeente2'],
            vraagGOK: doc['vraagGOK'],
            vraagTN: doc['vraagTN'],
            schoolList: ['schoolList']);

        regiList.add(regi);
      });
    });

    return regiList;
  }

  Future<void> deleteRegi() async {
    _regiRef
        .doc(id)
        .delete()
        .then((value) => print("Registration succesfully deleted "))
        .catchError((error) => print("Failed to delete Registration: $error"));
  }

  Future<void> editRegi() async {
    _regiRef
        .doc(id)
        .update({
          'voornaam': voornaam,
          'naam': naam,
          'rijksNr': rijksNr,
          'straat': straat,
          'huisNr': huisNr,
          'busNr': busNr,
          'postcode': postcode,
          'gemeente': gemeente,
          'oVoornaam1': oVoornaam1,
          'oNaam1': oNaam1,
          'beroep1': beroep1,
          'berStraat1': berStraat1,
          'berHuisNr1': berHuisNr1,
          'berBusNr1': berBusNr1,
          'berPostcode1': berPostcode1,
          'berGemeente1': berGemeente1,
          'oVoornaam2': oVoornaam2,
          'oNaam2': oNaam2,
          'beroep2': beroep2,
          'berStraat2': berStraat2,
          'berHuisNr2': berHuisNr2,
          'berBusNr2': berBusNr2,
          'berPostcode2': berPostcode2,
          'berGemeente2': berGemeente2,
          'vraagGOK': vraagGOK,
          'vraagTN': vraagTN,
          'schoolList': schoolList
        })
        .then((value) => print("Registration succesfully updated "))
        .catchError((error) => print("Failed to update Registration: $error"));
  }

  // methode om nieuwe registratie naar de server te versturen
  static Future<void> newRegi(
      {required voornaam,
      required naam,
      required rijksNr,
      required straat,
      required huisNr,
      required busNr,
      required postcode,
      required gemeente,
      required oVoornaam1,
      required oNaam1,
      required beroep1,
      required berStraat1,
      required berHuisNr1,
      required berBusNr1,
      required berPostcode1,
      required berGemeente1,
      required oVoornaam2,
      required oNaam2,
      required beroep2,
      required berStraat2,
      required berHuisNr2,
      required berBusNr2,
      required berPostcode2,
      required berGemeente2,
      required vraagGOK,
      required vraagTN,
      required schoolList}) {
    // Firestore collectie reference naar de regstratie collectie
    CollectionReference _regiRef =
        FirebaseFirestore.instance.collection('registrations');

    // gebruk de collectie reference van registratie om de nieuwe registratie toe te voegen
    return _regiRef
        .add({
          'date': DateTime.now(),
          'voornaam': voornaam,
          'naam': naam,
          'rijksNr': rijksNr,
          'straat': straat,
          'huisNr': huisNr,
          'busNr': busNr,
          'postcode': postcode,
          'gemeente': gemeente,
          'oVoornaam1': oVoornaam1,
          'oNaam1': oNaam1,
          'beroep1': beroep1,
          'berStraat1': berStraat1,
          'berHuisNr1': berHuisNr1,
          'berBusNr1': berBusNr1,
          'berPostcode1': berPostcode1,
          'berGemeente1': berGemeente1,
          'oVoornaam2': oVoornaam2,
          'oNaam2': oNaam2,
          'beroep2': beroep2,
          'berStraat2': berStraat2,
          'berHuisNr2': berHuisNr2,
          'berBusNr2': berBusNr2,
          'berPostcode2': berPostcode2,
          'berGemeente2': berGemeente2,
          'vraagGOK': vraagGOK,
          'vraagTN': vraagTN,
          'schoolList': schoolList
        })
        .then((value) => print("Registration succesfully added "))
        .catchError((error) => print("Failed to add Registration: $error"));
  }

  // methode om firestore object om te zette naar een Registratie klas object
  static Registration toRegi(String id, Map<String, dynamic> data) {
    return Registration(
        id: id,
        voornaam: data['voornaam'],
        naam: data['naam'],
        rijksNr: data['rijksNr'],
        straat: data['straat'],
        huisNr: data['huisNr'],
        busNr: data['busNr'],
        postcode: data['postcode'],
        gemeente: data['gemeente'],
        oVoornaam1: data['oVoornaam1'],
        oNaam1: data['oNaam1'],
        beroep1: data['beroep1'],
        berStraat1: data['berStraat1'],
        berHuisNr1: data['berHuisNr1'],
        berBusNr1: data['berBusNr1'],
        berPostcode1: data['berPostcode1'],
        berGemeente1: data['berGemeente1'],
        oVoornaam2: data['oVoornaam2'],
        oNaam2: data['oNaam2'],
        beroep2: data['beroep2'],
        berStraat2: data['berStraat2'],
        berHuisNr2: data['berHuisNr2'],
        berBusNr2: data['berBusNr2'],
        berPostcode2: data['berPostcode2'],
        berGemeente2: data['berGemeente2'],
        vraagGOK: data['vraagGOK'],
        vraagTN: data['vraagTN'],
        schoolList: data['schoolList']);
  }
}

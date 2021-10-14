import 'package:flutter/cupertino.dart';

@immutable
class Registration {
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
  late final String oVoornaam1;
  late final String oNaam1;
  late final String beroep1;
  late final String berStraat1;
  late final int berHuisNr1;
  late final String? berBusNr1;
  late final int berPostcode1;
  late final String berGemeente1;

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
  late final bool vraagGOK;
  late final bool vraagTN;

  Registration(
      {required this.voornaam,
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
      required this.vraagTN});



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

        ''';
  }
}

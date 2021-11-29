import 'package:cloud_firestore/cloud_firestore.dart';

abstract class User {
  late String voornaam;
  late String naam;
  late String rr;

  User.emptyConstructor() {}

  User({required String vn, required String nm, required String rr}) {
    this.voornaam = vn;
    this.naam = nm;
    this.rr = rr;
  }

  static Future<void> newUser(
      {required String uid,
      required String email
      }) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set({
      'uid': uid,
      'email': email,
      'date': DateTime.now(),
      'voornaam': "",
      'naam': "",
      'rijksNr': "",
      'straat': "",
      'huisNr': "",
      'busNr': "",
      'postcode': "",
      'gemeente': "",
      'oVoornaam1': "",
      'oNaam1': "",
      'beroep1': "",
      'berStraat1': "",
      'berHuisNr1': "",
      'berBusNr1': "",
      'berPostcode1': "",
      'berGemeente1': "",
      'oVoornaam2': "",
      'oNaam2': "",
      'beroep2': "",
      'berStraat2': "",
      'berHuisNr2': "",
      'berBusNr2': "",
      'berPostcode2': "",
      'berGemeente2': "",})
        .then((value) => print("User Seccesfully Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


}

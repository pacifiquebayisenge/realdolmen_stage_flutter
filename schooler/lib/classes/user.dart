import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schooler/services/globals.dart';

class User {
  late String id;

  late String voornaam;
  late String naam;
  late String rijksNr;

  // domicilierings adres
  late final String straat;
  late final int huisNr;
  late final String? busNr;
  late final int postcode;
  late final String gemeente;

  // registratie lijst van deze user
  late final List<dynamic> regiList = [];

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  User.emptyConstructor();

  User(
      {required this.id,
      required this.voornaam,
      required this.naam,
      required this.rijksNr});

  // methode om user in te loggen via email en password
  static Future<String?> login(
      {required String email, required String password}) async {
    try {
       UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // thisUser = User(id: userCredential.user!.uid,voornaam: "test",naam: "test" ,rijksNr: "97042025942" );
      await thisUser.getUser(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      }
      if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    } catch (e) {
      print(e);
      return 'Something went wrong, please try again later.';
    }
  }

  // methode om user te registeren via email en password
  static Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // nieuwe user toevoegen aan database
     await _newUser(uid: userCredential.user!.uid, email: email);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak !';
      }
      if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email !';
      }
    } catch (e) {
      print(e);
      return 'Something went wrong, please try again later.';
    }
  }

  // methode om user toe te voegen in de database
  static Future<void> _newUser(
      {required String uid, required String email}) async {
    await FirebaseFirestore.instance
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
          'berGemeente2': "",
          'regiList': ""
        })
        .then((value) => print("User Seccesfully Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // methode om gegevens van de user op te halen
   Future<void> getUser(String id) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data()! as Map<String, dynamic>;

        thisUser = User(
            id: id,
            voornaam: data['voornaam'],
            naam: data['naam'],
            rijksNr: data['rijksNr']);
      } else {
        print('Document does not exist on the database');
      }
      ;
    });
  }

  // methode om na te gaan of er informatie ove rde user mist
  Future<bool> userInfoCheck(String id) async {
    bool profileComplete = true;

    await _userRef.doc(id).get().then(((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        if (data["voornaam"] == "") {
          profileComplete = false;
        }
      } else {
        print('Document does not exist on the database');
      }
    }));
    return profileComplete;
  }

  // methode om de basis info van de user te updaten
  Future<bool> updateUserProfile(
      {required String voornaam,
      required String naam,
      required String rijksNr}) async {

    bool result = false;
    await _userRef.doc(id).update(
        {'voornaam': voornaam, 'naam': naam, 'rijksNr': rijksNr}).then((value) {
      this.voornaam = voornaam;
      this.naam = naam;
      this.rijksNr = rijksNr;

      result = true;
    }).catchError((error) {
      print(error);
      result = false;
    });

    return result;
  }

  Future<void> getRegiList() async {


  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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



  final CollectionReference _userRef =  FirebaseFirestore.instance
      .collection('users');

  User.emptyConstructor();

  User({required this.id, required this.voornaam, required this.naam, required this.rijksNr});

  // methode om user in te loggen via email en password
  static Future<String?> login  ({required String email, required String password}) async {

    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password: password);

    // thisUser = User(id: userCredential.user!.uid,voornaam: "test",naam: "test" ,rijksNr: "97042025942" );



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
  static Future<String?> signUp ({required String email, required String password}) async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);



      // nieuwe user toevoegen aan database
      _newUser(
          uid: userCredential.user!.uid, email: email);

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
      'berGemeente2': "",
    'regiList' : ""})
        .then((value) => print("User Seccesfully Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }



  Future<String> userInfoCheck(String id) async {
    String result = "";

    await _userRef.doc(id).get().then(((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {


        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        if(data["voornaam"] == "") {

          result = "Complete account info";

        };


      } else {

        print('Document does not exist on the database');
      }

    }));
    return result;
  }



}

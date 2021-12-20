import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/services/globals.dart';

class User {
  String? id;

  late String voornaam;
  late String naam;
  late String rijksNr;

  // domicilierings adres
  late final String straat;
  late final int huisNr;
  late final String? busNr;
  late final int postcode;
  late final String gemeente;

  // info beroep in geval van zelf ouder te worden
  late final String? beroep;
  late final String? berStraat;
  late final int? berHuisNr;
  late final String? berBusNr;
  late final int? berPostcode;
  late final String? berGemeente;

  // info partner in geval van  zelf ouder te worden
  late final String? oVoornaam3;
  late final String? oNaam3;
  late final String? beroep3;
  late final String? berStraat3;
  late final int? berHuisNr3;
  late final String? berBusNr3;
  late final int? berPostcode3;
  late final String? berGemeente3;

  // info eerste ouder
  late final String? oVoornaam1;
  late final String? oNaam1;
  late final String? beroep1;
  late final String? berStraat1;
  late final int? berHuisNr1;
  late final String? berBusNr1;
  late final int? berPostcode1;
  late final String? berGemeente1;

  // info tweede ouder
  late final String? oVoornaam2;
  late final String? oNaam2;
  late final String? beroep2;
  late final String? berStraat2;
  late final int? berHuisNr2;
  late final String? berBusNr2;
  late final int? berPostcode2;
  late final String? berGemeente2;

  // favoriete scholen lijst van deze user
  late List<SchoolObject> favoSchoolsList = [];

  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  User.emptyConstructor();

  User({
    // basis info
    required this.id,
    required this.voornaam,
    required this.naam,
    required this.rijksNr,

     // adress
    required this.straat,
    required this.huisNr,
    required this.busNr,
    required this.postcode,
    required this.gemeente,

    // beroep in geval van parent te worden
    required this.beroep,
    required this.berStraat,
    required this.berHuisNr,
    required this.berBusNr,
    required this.berPostcode,
    required this.berGemeente,

    // beroep partner  in geval van kind dat parent wordt
    required this.oVoornaam3,
    required this.oNaam3,
    required this.beroep3,
    required this.berStraat3,
    required this.berHuisNr3,
    required this.berBusNr3,
    required this.berPostcode3,
    required this.berGemeente3,

    // ouder 1 info
    required this.oVoornaam1,
    required this.oNaam1,
    required this.beroep1,
    required this.berStraat1,
    required this.berHuisNr1,
    required this.berBusNr1,
    required this.berPostcode1,
    required this.berGemeente1,

    // ouder 2 info
    required this.oVoornaam2,
    required this.oNaam2,
    required this.beroep2,
    required this.berStraat2,
    required this.berHuisNr2,
    required this.berBusNr2,
    required this.berPostcode2,
    required this.berGemeente2,

  });

  // methode om user in te loggen via email en password
  static Future<String?> login(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

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

          // basis info
          'uid': uid,
          'email': email,
          'date': DateTime.now(),
          'voornaam': "",
          'naam': "",
          'rijksNr': "",

           // adress
          'straat': "",
          'huisNr': 0,
          'busNr': "",
          'postcode': 0,
          'gemeente': "",

          // beroep in geval van ouder te worden
          'beroep': "",
          'berStraat': "",
          'berHuisNr': 0,
          'berBusNr': "",
          'berPostcode': 0,
          'berGemeente': "",

      // partner in geval van ouder te zijn geworden
      'oVoornaam3': "",
      'oNaam3': "",
      'beroep3': "",
      'berStraat3': "",
      'berHuisNr3': 0,
      'berBusNr3': "",
      'berPostcode3': 0,
      'berGemeente3': "",

          // ouder 1 info
          'oVoornaam1': "",
          'oNaam1': "",
          'beroep1': "",
          'berStraat1': "",
          'berHuisNr1': 0,
          'berBusNr1': "",
          'berPostcode1': 0,
          'berGemeente1': "",

          // ouder 2 info
          'oVoornaam2': "",
          'oNaam2': "",
          'beroep2': "",
          'berStraat2': "",
          'berHuisNr2': 0,
          'berBusNr2': "",
          'berPostcode2': 0,
          'berGemeente2': "",
        })
        .then((value) => print("User Seccesfully Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  // methode om gegevens van de user op te halen
  Future<void> getUser(String id) async {
    await _userRef
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) async {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data()! as Map<String, dynamic>;

        thisUser = User(
          // basis info
          id: id,
          voornaam: data['voornaam'],
          naam: data['naam'],
          rijksNr: data['rijksNr'],

          // adress
          straat: data['straat'],
          huisNr: data['huisNr'],
          busNr: data['busNr'],
          postcode: data['postcode'],
          gemeente: data['gemeente'],

          // beroep in geval van ouder
          beroep: data['beroep'],
          berStraat: data['berStraat'],
          berHuisNr: data['berHuisNr'],
          berBusNr: data['berBusNr'],
          berPostcode: data['berPostcode'],
          berGemeente: data['berGemeente'],

          // partner in geval van ouder te zijn geworden
          oVoornaam3: data['oVoornaam3'],
          oNaam3: data['oNaam3'],
          beroep3: data['beroep3'],
          berStraat3: data['berStraat3'],
          berHuisNr3: data['berHuisNr3'],
          berBusNr3: data['berBusNr3'],
          berPostcode3: data['berPostcode3'],
          berGemeente3: data['berGemeente3'],

          // ouder 1 info
          oVoornaam1: data['oVoornaam1'],
          oNaam1: data['oNaam1'],
          beroep1: data['beroep1'],
          berStraat1: data['berStraat1'],
          berHuisNr1: data['berHuisNr1'],
          berBusNr1: data['berBusNr1'],
          berPostcode1: data['berPostcode1'],
          berGemeente1: data['berGemeente1'],

          // ouder 2 info
          oVoornaam2: data['oVoornaam2'],
          oNaam2: data['oNaam2'],
          beroep2: data['beroep2'],
          berStraat2: data['berStraat2'],
          berHuisNr2: data['berHuisNr2'],
          berBusNr2: data['berBusNr2'],
          berPostcode2: data['berPostcode2'],
          berGemeente2: data['berGemeente2'],
          
          
        );
        
        print(data['favoSchoolsList']);


        //await  thisUser.getUserRegis();

      } else {
        print('Document does not exist on the database');
      }
      ;
    });
  }
/*
  Future<void> getUserRegis() async {
    _userRef
        .doc(id)
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
            schoolList: doc['schoolList']);

        regiList.add(regi);
      });
    });
  }

 */

  // methode om na te gaan of het user profiel compleet is
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

      getUser(id!);

      result = true;
    }).catchError((error) {
      print('Something went wrong while updating profile');
      print(error);
      result = false;
    });

    return result;
  }

  // methode om de basis info van de user te updaten
  Future<void> updateUserAdress({
    required String straat,
    required int huisNr,
    required String busNr,
    required int postcode,
    required String gemeente,
  }) async {
    await _userRef.doc(id).update({
      'straat': straat,
      'huisNr': huisNr,
      'busNr': busNr,
      'postcode': postcode,
      'gemeente': gemeente
    }).then((value) {
      getUser(id!);
    }).catchError((error) {
      print('Something went wrong while updating adres');
      print(error);
    });
  }


    // methode om ouder van user te updaten
  Future<void> updateUserParents({
    required String  oVoornaam1,
    required String oNaam1,
    required String beroep1,
    required String berStraat1,
    required int berHuisNr1,
    required String berBusNr1,
    required int berPostcode1,
    required String berGemeente1,
    required String oVoornaam2,
    required String oNaam2,
    required String beroep2,
    required String berStraat2,
    required int berHuisNr2,
    required String berBusNr2,
    required int berPostcode2,
    required String berGemeente2,
  }) async {
    await _userRef.doc(id).update({
      // ouder 1
      'oVoornaam1': oVoornaam1,
      'oNaam1': oNaam1,
      'beroep1': beroep1,
      'berStraat1': berStraat1,
      'berHuisNr1': berHuisNr1,
      'berBusNr1': berBusNr1,
      'berPostcode1': berPostcode1,
      'berGemeente1': berGemeente1,

      // ouder 2
      'oVoornaam2': oVoornaam2,
      'oNaam2': oNaam2,
      'beroep2': beroep2,
      'berStraat2': berStraat2,
      'berHuisNr2': berHuisNr2,
      'berBusNr2': berBusNr2,
      'berPostcode2': berPostcode2,
      'berGemeente2': berGemeente2,
    }).then((value) {

      getUser(id!);
    }).catchError((error) {
      print('Something went wrong while updating parents');
      print(error);
    });
  }

  // methode om beroep van user te updaten ( in geval van ouder te zijn geworden)
  Future<void> updateUserProf({
        required String beroep,
    required String berStraat,
    required int berHuisNr,
    required String berBusNr,
    required int berPostcode,
    required String berGemeente,
  }) async {
    await _userRef.doc(id).update({

      'beroep': beroep,
      'berStraat': berStraat,
      'berHuisNr': berHuisNr,
      'berBusNr': berBusNr,
      'berPostcode': berPostcode,
      'berGemeente': berGemeente,
    }).then((value) {
      getUser(id!);
    }).catchError((error) {
      print('Something went wrong while updating profession');
      print(error);
    });
  }


  // methode om user partner te updaten (in geval van ouder te zijn geworden)
  Future<void> updateUserPartner({
    required String  oVoornaam3,
    required String oNaam3,
    required String beroep3,
    required String berStraat3,
    required int berHuisNr3,
    required String berBusNr3,
    required int berPostcode3,
    required String berGemeente3,

  }) async {
    await _userRef.doc(id).update({
      'oVoornaam3': oVoornaam3,
      'oNaam3': oNaam3,
      'beroep3': beroep3,
      'berStraat3': berStraat3,
      'berHuisNr3': berHuisNr3,
      'berBusNr3': berBusNr3,
      'berPostcode3': berPostcode3,
      'berGemeente3': berGemeente3,

    }).then((value) {
      getUser(id!);
    }).catchError((error) {
      print('Something went wrong while updating partner');
      print(error);
    });
  }



}

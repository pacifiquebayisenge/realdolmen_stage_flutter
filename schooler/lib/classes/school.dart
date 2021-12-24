import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooler/services/globals.dart';

class SchoolObject {
  late String? id;
  late String naam;
  late String adres;
  late String type;
  late double lat;
  late double long;

  // Firestore collectie reference naar de regstratie collectie
  final CollectionReference _schoolRef = FirebaseFirestore.instance
      .collection('users')
      .doc(thisUser.id)
      .collection('favoSchoolsList');

  SchoolObject(
      { this.id,
      required this.naam,
      required this.adres,
        required this.type,
        required this.lat,
        required this.long,

     });

  // methode om school in favoriete lijst toe te voegen
  Future<void> addSchoolFavo() async {
    await _schoolRef
        .doc(id)
        .set({'id': id, 'naam': naam, 'adres': adres,  'type': type, 'latitude' : lat, 'longitude' : long})
        .then((value) => print("School succesfully added to Favo list"))
        .catchError(
            (error) => print("Failed to add School to Favo list: $error"));
  }

  // metohde om school uit favoriete lijst toe te voegen
  Future<void> removeSchoolFavo() async {
    await _schoolRef
        .doc(id)
        .delete()
        .then((value) => print("School succesfully deleted from Favo list"))
        .catchError(
            (error) => print("Failed to delete School from Favo list: $error"));
  }

  // methode om firestore object om te zette naar een school object klas object
  static SchoolObject toSchoolObject(String id, Map<String, dynamic> data) {
    return SchoolObject(id: id, naam: data['naam'], adres: data['adres'],  type: data['type'], lat: data['latitude'], long: data['longitude']);
  }


  // methode om alle scholen in de database op te halen
  static Future<List<SchoolObject>> getAllSchools() async  {

    List<SchoolObject> list = [];


    await FirebaseFirestore.instance
        .collection('schools')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        list.add(SchoolObject.toSchoolObject(doc.id, doc.data() as Map<String, dynamic>));
      });
    });


    return list;
  }

  // methode om alle scholen in de database op te halen
  static Future<List<SchoolObject>> getAllFavoSchools() async  {

    List<SchoolObject> list = [];


    await FirebaseFirestore.instance
        .collection('users')
    .doc(thisUser.id)
    .collection('favoSchoolList')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        list.add(SchoolObject.toSchoolObject(doc.id, doc.data() as Map<String, dynamic>));
      });
    });


    return list;
  }
}

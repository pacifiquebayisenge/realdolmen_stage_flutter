import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schooler/services/globals.dart';

class SchoolObject {
  late String id;
  late String naam;
  late String adres;
  late bool isFavo;

  // Firestore collectie reference naar de regstratie collectie
  final CollectionReference _schoolRef = FirebaseFirestore.instance
      .collection('users')
      .doc(thisUser.id)
      .collection('favoSchoolsList');

  SchoolObject(
      {required this.id,
      required this.naam,
      required this.adres,
      required this.isFavo});

  Future<void> _addSchoolFavo({required SchoolObject school}) async {
    await _schoolRef
        .doc(id)
        .set({'id': id, 'naam': naam, 'adres': adres, 'isFavo': isFavo})
        .then((value) => print("School succesfully added to Favo list"))
        .catchError(
            (error) => print("Failed to add School to Favo list: $error"));
  }

  Future<void> _deleteSchoolFavo() async {
    await _schoolRef
        .doc(id)
        .delete()
        .then((value) => print("School succesfully deleted from Favo list"))
        .catchError(
            (error) => print("Failed to delete School from Favo list: $error"));
  }

  Future<void> _updateFavoState(bool favoState) async {
    await _schoolRef
        .doc(id)
        .update({'isFavo': favoState})
        .then((value) => print("School succesfully updated"))
        .catchError((error) => print("Failed to update School: $error"));
  }

  // methode om firestore object om te zette naar een school object klas object
  static SchoolObject toSchoolObject(String id, Map<String, dynamic> data) {
    return SchoolObject(id: id, naam: data['naam'], adres: data['adres'], isFavo: data['isFavo']);
  }

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
}

abstract class User {

  late String voornaam;
  late String naam;
  late String rr;

  User.emptyConstructor(){}

  User({required String vn, required String nm, required String rr}) {
    this.voornaam = vn;
    this.naam = nm;
    this.rr = rr;
  }



}
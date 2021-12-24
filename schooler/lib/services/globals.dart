import 'package:schooler/classes/registration.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/classes/user.dart';

late Registration regi;
 User thisUser = User.emptyConstructor();

List<Registration> regiList = [
];

List<SchoolObject> schools = [

];

List<String> vragenGOK = [
 'The family has received a school allowance in the 2019-2020 school year and/or in the 2020-2021 school year.',
 'The mother of the pupil has a diploma of secondary education or a study certificate of the second year of the third degree of the secondary education or an associated equivalent study certificate.'
];

List<String> vragenTN = [
 'At least a Dutch-language diploma of secondary education or an equivalent Dutch-language study certificate.',
 'A Dutch-language certificate of the second year of the third stage of secondary education or an equivalent Dutch-language certificate.',
 'Proof of at least sufficient knowledge of Dutch issued by Selor.',
 'Proof of that one of them has attended 9 years of regular education in Dutch-language primary and secondary education.',
 'Proof that one of them masters Dutch at at least level B2',
];
import 'dart:async';

import 'dart:math' as math;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/services/globals.dart';
import 'package:schooler/widgets/widgets.dart';
import 'widgets.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_slider/page_slider.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:schooler/classes/registration.dart';

import 'bullet_list.dart';

class FormQuestions extends StatefulWidget {
  FormQuestions({Key? key, this.editRegi}) : super(key: key);
  Registration? editRegi;
  @override
  _FormQuestionsState createState() => _FormQuestionsState();
}

class _FormQuestionsState extends State<FormQuestions> {
  // De  form velden controllers + keys
  final _thisForm = GlobalKey<FormBuilderState>();
  final voornaam = TextEditingController();
  final naam = TextEditingController();
  final rijksNr = TextEditingController();

  final _thisForm2 = GlobalKey<FormBuilderState>();
  final straat = TextEditingController();
  final huisNr = TextEditingController();
  final busNr = TextEditingController();
  final postcode = TextEditingController();
  final gemeente = TextEditingController();

  final _thisForm3 = GlobalKey<FormBuilderState>();
  final oVoornaam1 = TextEditingController();
  final oNaam1 = TextEditingController();
  final beroep1 = TextEditingController();
  final berStraat1 = TextEditingController();
  final berHuisNr1 = TextEditingController();
  final berBusNr1 = TextEditingController();
  final berPostcode1 = TextEditingController();
  final berGemeente1 = TextEditingController();

  final _thisForm4 = GlobalKey<FormBuilderState>();
  final oVoornaam2 = TextEditingController();
  final oNaam2 = TextEditingController();
  final beroep2 = TextEditingController();
  final berStraat2 = TextEditingController();
  final berHuisNr2 = TextEditingController();
  final berBusNr2 = TextEditingController();
  final berPostcode2 = TextEditingController();
  final berGemeente2 = TextEditingController();

  late bool vraagGOK = false;
  late bool vraagTN = false;

  // key voor de page slider
  final GlobalKey<PageSliderState> _slider = GlobalKey();

  // Huidige stap aanwijzing
  int _currentStep = 0;

  // Huidige stap aanwijzing
  late int? _stepCount = 0;

  // bool om aan te duiden dat 2e ouder ook zal ingevoerd worden
  bool secParent = false;

  // standaard pagina hoogte
  double pageHeight = 450;

  bool regiSucces = false;

  bool isParent = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => editRegistration());
  }

  @override
  void dispose() {
    voornaam.dispose();
    naam.dispose();
    rijksNr.dispose();

    straat.dispose();
    huisNr.dispose();
    busNr.dispose();
    postcode.dispose();
    gemeente.dispose();

    oVoornaam1.dispose();
    oNaam1.dispose();
    beroep1.dispose();
    berStraat1.dispose();
    berHuisNr1.dispose();
    berBusNr1.dispose();
    berPostcode1.dispose();
    berGemeente1.dispose();

    oVoornaam2.dispose();
    oNaam2.dispose();
    beroep2.dispose();
    berStraat2.dispose();
    berHuisNr2.dispose();
    berBusNr2.dispose();
    berPostcode2.dispose();
    berGemeente2.dispose();
    super.dispose();
  }

  void editRegistration() {
    if (widget.editRegi != null) {
      voornaam.text = widget.editRegi!.voornaam;
      naam.text = widget.editRegi!.naam;
      rijksNr.text = widget.editRegi!.rijksNr;
      straat.text = widget.editRegi!.straat;
      huisNr.text = widget.editRegi!.huisNr.toString();
      busNr.text = widget.editRegi!.busNr!;
      postcode.text = widget.editRegi!.postcode.toString();
      gemeente.text = widget.editRegi!.gemeente;

      oVoornaam1.text = widget.editRegi!.oVoornaam1!;
      oNaam1.text = widget.editRegi!.oNaam1!;
      beroep1.text = widget.editRegi!.beroep1!;
      berStraat1.text = widget.editRegi!.berStraat1!;
      berHuisNr1.text = widget.editRegi!.berHuisNr1!.toString();
      berBusNr1.text = widget.editRegi!.berBusNr1!;
      berPostcode1.text = widget.editRegi!.berPostcode1!.toString();
      berGemeente1.text = widget.editRegi!.berGemeente1!;

      if (widget.editRegi!.oVoornaam2 != null) {
        secParent = true;

        oVoornaam2.text = widget.editRegi!.oVoornaam2!;
        oNaam2.text = widget.editRegi!.oNaam2!;
        beroep2.text = widget.editRegi!.beroep2!;
        berStraat2.text = widget.editRegi!.berStraat2!.toString();
        berHuisNr2.text = widget.editRegi!.berHuisNr2!.toString();
        berBusNr2.text = widget.editRegi!.berBusNr2!;
        berPostcode2.text = widget.editRegi!.berPostcode2!.toString();
        berGemeente2.text = widget.editRegi!.berGemeente2!;
      }

      widget.editRegi!.schoolList.forEach((element) {
        SchoolList.schoolList.add(element);
      });
    }
  }

  void t() {
    FirebaseFirestore.instance
        .collection('registrations')
        .orderBy('date', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Timestamp timestamp;
        timestamp = doc['date'];

        if (timestamp.toDate().day == 1) {
          FirebaseFirestore.instance
              .collection('registrations')
              .doc(doc.id)
              .delete();
        }
      });
    });
  }

  void userTypeBtn(String type) {
    setState(() {
    if(type == 'parent') {

        isParent = true;

    }else {
      isParent = false;
    }
    });
    nextStep() ;
  }

  void autoStudentData(){

    if(!isParent){
      voornaam.text = thisUser.voornaam;
      naam.text = thisUser.naam;
      rijksNr.text = thisUser.rijksNr;
    }

    if(!isParent && thisUser.straat != null){
      straat.text = thisUser.straat;
      huisNr.text = thisUser.huisNr.toString();
      postcode.text = thisUser.postcode.toString();
      gemeente.text = thisUser.gemeente;
    }

    if(!isParent && thisUser.oVoornaam1 != ""){
      oVoornaam1.text = thisUser.oVoornaam1!;
      oNaam1.text = thisUser.oNaam1!;
      beroep1.text = thisUser.beroep1!;
      berStraat1.text = thisUser.berStraat1!;
      berHuisNr1.text = thisUser.berHuisNr1!.toString();
      berBusNr1.text = thisUser.berBusNr1!;
      berPostcode1.text = thisUser.berPostcode1!.toString();
      berGemeente1.text = thisUser.berGemeente1!;
    }

    if(!isParent && thisUser.oVoornaam2 != ""){
      oVoornaam2.text = thisUser.oVoornaam2!;
      oNaam2.text = thisUser.oNaam2!;
      beroep2.text = thisUser.beroep2!;
      berStraat2.text = thisUser.berStraat2!;
      berHuisNr2.text = thisUser.berHuisNr2!.toString();
      berBusNr2.text = thisUser.berBusNr2!;
      berPostcode2.text = thisUser.berPostcode2!.toString();
      berGemeente2.text = thisUser.berGemeente2!;
    }
  }

  void removeParent() {
    setState(() {
      oVoornaam2.clear();
      oNaam2.clear();
      beroep2.clear();
      berStraat2.clear();
      berHuisNr2.clear();
      berBusNr2.clear();
      berPostcode2.clear();
      berGemeente2.clear();

      secParent = false;
      previousStep();
    });
  }

  // methode om de GOK en TN vragen op te vragen
  // 2 knoppen = ja knop en nee knop
  // index als parameter om te weten welke knop gedrukt werd
  // 1 = true, 0 = nee
  void vraagYesNo(int index) {
    // aan de hand van welke pagina weten we over welke vragen het gaat
    switch (_currentStep) {
      case 5:
        {
          vraagGOK = index != 0;

          nextStep();
          print("vraagGOK $vraagGOK");
        }
        break;
      case 6:
        {
          vraagTN = index != 0;
          nextStep();
          print("vraagTN $vraagTN");
        }
        break;
      default:
        {
          print("Invalid choice");
        }
        break;
    }
  }

  // methode om de pagina hoogte aan te passen naar gelang de pagina nummer
  void setpageHeight(int page) {
    print('THIS IS THE ACTUAL PAGE NUMBER $page');

    setState(() {
      switch (page) {
        case 3:
          {
            pageHeight = 480;
          }
          break;
        case 4:
          {
            pageHeight = 480;
          }
          break;
        case 7:
          {
            pageHeight = 520;
          }
          break;
        case 8:
          {
            pageHeight = 550;
          }
          break;
        default:
          {
            pageHeight = 470;
          }
          break;
      }
    });
  }

  // methode om elke validator van elke formfield na te gaan
  // geeft bool terug om te zien of form juist is ingevoerd
  bool checkStep() {
    bool formSucces = false;

    switch (_currentStep) {
      case 0:
        {
          formSucces = _thisForm.currentState!.validate();
        }
        break;

      case 1:
        {
          formSucces = _thisForm.currentState!.validate();
        }
        break;

      case 2:
        {
          formSucces = _thisForm2.currentState!.validate();
        }
        break;

      case 3:
        {
          formSucces = _thisForm3.currentState!.validate();
        }
        break;

      case 4:
        {
          formSucces = _thisForm4.currentState!.validate();
        }
        break;
      case 5:
        {
          formSucces = true;
        }
        break;
      case 6:
        {
          pageHeight = 450;
          formSucces = true;
        }
        break;
      case 7:
        {
          formSucces = true;
        }
        break;
      case 8:
        {
          formSucces = true;
        }
        break;

      default:
        {
          print("Invalid choice");
        }
        break;
    }

    return formSucces;
  }

  // Methode om naar volgende stap te gaan
  // ALs laatste stap is verstuur data naar server
  Future<void> nextStep() async {

    autoStudentData();
    t();
    //print(checkStep());

    // als form op deze pagina niet juist is ingevoerd dan kan men niet verder
    //if (!checkStep()) return;

    bool isLastStep =
        _currentStep == _slider.currentState!.widget.pages.length - 2;

    // als het de laatste stap is, vervoledig de wizart
    if (isLastStep) {
      print('Completed!');
      _thisForm.currentState!.save();

      if (widget.editRegi != null) {
        Registration regi1 = Registration(
            voornaam: voornaam.text,
            naam: naam.text,
            rijksNr: rijksNr.text,
            straat: straat.text,
            huisNr: int.parse(huisNr.text),
            busNr: busNr.text,
            postcode: int.parse(postcode.text),
            gemeente: gemeente.text,
            oVoornaam1: oVoornaam1.text,
            oNaam1: oNaam1.text,
            beroep1: beroep1.text,
            berStraat1: berStraat1.text,
            berHuisNr1: int.parse(berHuisNr1.text),
            berBusNr1: berBusNr1.text,
            berPostcode1: int.parse(berPostcode1.text),
            berGemeente1: berGemeente1.text,
            oVoornaam2: oVoornaam2.text,
            oNaam2: oNaam2.text,
            beroep2: beroep2.text,
            berStraat2: berStraat2.text,
            berHuisNr2: int.tryParse(berHuisNr2.text),
            berBusNr2: berBusNr2.text,
            berPostcode2: int.tryParse(berPostcode2.text),
            berGemeente2: berGemeente2.text,
            vraagGOK: vraagGOK,
            vraagTN: vraagTN,
            schoolList: SchoolList.schoolList,
            id: widget.editRegi!.id);
        await regi1.editRegi().then((value) {
          setState(() {
            _currentStep += 1;
            _slider.currentState!.next();
            regiSucces = true;
          });

          //Timer(const Duration(milliseconds: 5500 ), () {Navigator.pop(context); });
        }).catchError((value) {
          print(value);
          setState(() {
            _currentStep += 1;
            _slider.currentState!.next();
            regiSucces = false;
          });
        });
      } else {
        //  verstuur data naar de server
        Registration.newRegi(
                voornaam: voornaam.text,
                naam: naam.text,
                rijksNr: rijksNr.text,
                straat: straat.text,
                huisNr: int.parse(huisNr.text),
                busNr: busNr.text,
                postcode: int.parse(postcode.text),
                gemeente: gemeente.text,
                oVoornaam1: oVoornaam1.text,
                oNaam1: oNaam1.text,
                beroep1: beroep1.text,
                berStraat1: berStraat1.text,
                berHuisNr1: int.parse(berHuisNr1.text),
                berBusNr1: berBusNr1.text,
                berPostcode1: int.parse(berPostcode1.text),
                berGemeente1: berGemeente1.text,
                oVoornaam2: oVoornaam2.text,
                oNaam2: oNaam2.text,
                beroep2: beroep2.text,
                berStraat2: berStraat2.text,
                berHuisNr2: int.tryParse(berHuisNr2.text),
                berBusNr2: berBusNr2.text,
                berPostcode2: int.tryParse(berPostcode2.text),
                berGemeente2: berGemeente2.text,
                vraagGOK: vraagGOK,
                vraagTN: vraagTN,
                schoolList: SchoolList.schoolList)
            .then((value) {
          setState(() {
            _currentStep += 1;
            _slider.currentState!.next();

            regiSucces = true;
          });

          //Timer(const Duration(milliseconds: 2500 ), () {Navigator.pop(context); });
        }).catchError((value) {
          setState(() {
            _currentStep += 1;
            _slider.currentState!.next();
            regiSucces = false;
          });
        });
      }

      Timer(const Duration(milliseconds: 4500), () {
        Navigator.pop(context);
      });
    }
    //// Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina
    else if (_currentStep == 3 && secParent == false) {
      setState(() => _currentStep += 2);

      _slider.currentState!.next();
      _slider.currentState!.next();
    } else {
      // step indicator verschijnt => aantal stappen meegeven
      _stepCount = _slider.currentState!.widget.pages.length - 1;

      setState(() => _currentStep += 1);

      _slider.currentState!.next();
    }
    setpageHeight(_currentStep);

    print(
        '$_currentStep ${_slider.currentState!.currentPage} | ${_slider.currentState!.widget.pages.length}');
  }

  // Methode om naar vorige stap te gaan
  // ALs eerste stap is sluit de popup
  void previousStep() {
    bool isFirstStep = _currentStep == 0;

    if (isFirstStep) {
      Navigator.pop(context);
    }
    // Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina  => dubbele stap achteruit
    else if (_currentStep == 5 && secParent == false) {
      setState(() => _currentStep -= 2);
      _slider.currentState!.previous();
      _slider.currentState!.previous();
    } else {
      setState(() => _currentStep -= 1);
      _slider.currentState!.previous();
    }

    setpageHeight(_currentStep);
    print(
        '$_currentStep ${_slider.currentState!.currentPage} | ${_slider.currentState!.widget.pages.length}');
  }

  // methode om laatste 2 controle cijfers van rijksregister te berekennen
  // geeft de 2 controle cijfers terug
  int rijksnummerCheck(String rijksregisternummer) {
    // eerste 9 cijfers van het rijksregisternummer
    int deeltal = int.parse(rijksregisternummer.substring(0, 9));

    // modula 97 om de restwaarde hiervan te berekennen
    int mod = deeltal % 97;

    // 97 verminderen met de restwaarde om de laatste 2 controle cijfers te bekomen
    int check = 97 - mod;

    return check;
  }

  // methode om terug te gaan naar de pagina waar men de informatie wilt wijzigen
  void overzichtEdit(String page) {
    setState(() {
      switch (page) {
        case 'profile':
          {
            _currentStep -= 8;
            _slider.currentState!.previous();
            _slider.currentState!.previous();
            _slider.currentState!.previous();

            _slider.currentState!.previous();
            _slider.currentState!.previous();
            _slider.currentState!.previous();

            _slider.currentState!.previous();
            //formSucces = _thisForm.currentState!.validate();
          }
          break;
        case 'parents':
          {
            _currentStep -= 6;
            _slider.currentState!.previous();
            _slider.currentState!.previous();
            _slider.currentState!.previous();

            _slider.currentState!.previous();
            _slider.currentState!.previous();
            //formSucces = _thisForm.currentState!.validate();
          }
          break;
        case 'parents2':
          {
            //formSucces = _thisForm.currentState!.validate();
          }
          break;
        case 'statements':
          {
            _currentStep -= 4;
            _slider.currentState!.previous();
            _slider.currentState!.previous();
            _slider.currentState!.previous();
            //formSucces = _thisForm.currentState!.validate();
          }
          break;
        case 'schoollist':
          {
            _currentStep -= 2;
            _slider.currentState!.previous();
            //formSucces = _thisForm.currentState!.validate();
          }
          break;
      }

      setpageHeight(_currentStep);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // step indicator widget
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ProgressStepper(
            stepCount: _stepCount,
            width: 200,
            height: 10,
            padding: 0,
            currentStep: _currentStep,
            onClick: (index) {},
          ),
        ),

        SizedBox(
          height: pageHeight,
          child: PageSlider(
              duration: const Duration(milliseconds: 400),
              initialPage: _currentStep,
              pages: [

                FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Column(

                        children: [
                          Text(
                            'Describe yourself',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Are you registering your child as a parent \n'
                                'or are you registering a student yourself?',
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 500),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(color: Colors.black45)
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      splashColor: Colors.indigo.shade800.withOpacity(0.5),
                                      onTap: () {userTypeBtn('parent');},
                                      child: Column(
                                        children:  [
                                          const Image(
                                            image: AssetImage('lib/images/parents2.png'),
                                            width: 150,
                                          ),
                                          Text(
                                            "I'm a parent",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          ),
                                          const SizedBox(height: 20,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              DelayedDisplay(
                                delay: const Duration(milliseconds: 500),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      border: Border.all(color: Colors.black45)
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                                      splashColor: Colors.indigo.shade800.withOpacity(0.5),
                                      onTap: () {userTypeBtn('student');},
                                      child: Column(
                                        children:  [
                                          const Image(
                                            image: AssetImage('lib/images/student2.png'),
                                            width: 150,
                                          ),
                                          Text(
                                            "I'm a student",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black45),
                                          ),
                                          const SizedBox(height: 20,)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    )),


                // profiel info
                FormBuilder(
                  key: _thisForm,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: Column(
                      children: [
                        Text(
                          'Profile information',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please fill in your private information',
                          style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 700),
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: FormBuilderTextField(
                                  name: 'voornaam',
                                  controller: voornaam,
                                  decoration: const InputDecoration(
                                      labelText: 'Firstname'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.notEqual(context, "")
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: FormBuilderTextField(
                                  name: 'naam',
                                  controller: naam,
                                  decoration: const InputDecoration(
                                      labelText: 'Lastname'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.notEqual(context, "")
                                  ]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 900),
                          child: FormBuilderTextField(
                            name: 'rijksNr',
                            controller: rijksNr,
                            decoration: const InputDecoration(
                                labelText: 'National Insurance number'),
                            keyboardType: TextInputType.number,
                            // enkel nummers kubben ingevoerd worden
                            // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            maxLength: 11,

                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.numeric(context),
                              FormBuilderValidators.minLength(context, 11),
                              FormBuilderValidators.maxLength(context, 11),
                              // custom validator om rijksregisternummer te checken
                              (value) {
                                if (int.parse(value!.substring(9, 11)) ==
                                    rijksnummerCheck(value)) {
                                  return null;
                                } else {
                                  return 'Invalid';
                                }
                              }
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                // adress info
                FormBuilder(
                  key: _thisForm2,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: Column(
                      children: [
                        Text(
                          'Address information',
                          style: GoogleFonts.montserrat(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              decoration: TextDecoration.underline),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please fill in your private address',
                          style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        FormBuilderTextField(
                          name: 'straat',
                          controller: straat,
                          decoration:
                              const InputDecoration(labelText: 'Street'),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(context),
                            FormBuilderValidators.notEqual(context, "")
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: FormBuilderTextField(
                              name: 'huisNr',
                              controller: huisNr,
                              decoration: const InputDecoration(
                                  labelText: 'House number'),
                              keyboardType: TextInputType.number,
                              // enkel nummers kubben ingevoerd worden
                              // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.numeric(context),
                                FormBuilderValidators.notEqual(context, '0')
                              ]),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            child: FormBuilderTextField(
                              name: 'busNr',
                              controller: busNr,
                              decoration: const InputDecoration(
                                  labelText: 'Additional'),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: FormBuilderTextField(
                                name: 'postcode',
                                controller: postcode,
                                decoration: const InputDecoration(
                                    labelText: 'Postal code'),
                                maxLength: 4,
                                keyboardType: TextInputType.number,
                                // enkel nummers kubben ingevoerd worden
                                // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.maxLength(context, 4)
                                ]),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 22.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: FormBuilderTextField(
                                  name: 'gemeente',
                                  controller: gemeente,
                                  decoration:
                                      const InputDecoration(labelText: 'City'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.notEqual(context, "")
                                  ]),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),


                // eerste ouder info
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 1,
                  child: SingleChildScrollView(
                    child: FormBuilder(
                      key: _thisForm3,
                      child: Column(
                        children: [
                          Text(
                            'Parent information',
                            style: GoogleFonts.montserrat(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Please fill in your parent information together\nwith the profession and it's address",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: FormBuilderTextField(
                                  name: 'oVoornaam1',
                                  controller: oVoornaam1,
                                  decoration: const InputDecoration(
                                      labelText: 'Parent firstname'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.notEqual(context, "")
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: FormBuilderTextField(
                                  name: 'oNaam1',
                                  controller: oNaam1,
                                  decoration: const InputDecoration(
                                      labelText: 'Parent lastname'),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.notEqual(context, "")
                                  ]),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: 'beroep1',
                            controller: beroep1,
                            decoration:
                                const InputDecoration(labelText: 'Profession'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.notEqual(context, "")
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            name: 'berStraat1',
                            controller: berStraat1,
                            decoration:
                                const InputDecoration(labelText: 'Street'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.notEqual(context, "")
                            ]),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2.4,
                              child: FormBuilderTextField(
                                name: 'berHuisNr1',
                                controller: berHuisNr1,
                                decoration: const InputDecoration(
                                    labelText: 'House number'),
                                keyboardType: TextInputType.number,
                                // enkel nummers kubben ingevoerd worden
                                // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.notEqual(context, '0')
                                ]),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              child: FormBuilderTextField(
                                name: 'berBusNr1',
                                controller: berBusNr1,
                                decoration: const InputDecoration(
                                    labelText: 'Additional'),
                              ),
                            ),
                          ]),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: FormBuilderTextField(
                                  name: 'berPostcode1',
                                  controller: berPostcode1,
                                  decoration: const InputDecoration(
                                      labelText: 'Postal code'),
                                  maxLength: 4,
                                  keyboardType: TextInputType.number,
                                  // enkel nummers kubben ingevoerd worden
                                  // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context),
                                    FormBuilderValidators.maxLength(context, 4)
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 22.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: FormBuilderTextField(
                                    name: 'berGemeente1',
                                    controller: berGemeente1,
                                    decoration: const InputDecoration(
                                        labelText: 'City'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.notEqual(
                                          context, "")
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),


                // tweede ouder info
                // enkel zichtbaar als 2e ouder knop wordt geklikt
                Visibility(
                  visible: secParent,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: SingleChildScrollView(
                      child: FormBuilder(
                        key: _thisForm4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Parent information',
                              style: GoogleFonts.montserrat(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Please fill in your parent information together\nwith the profession and it's address",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: FormBuilderTextField(
                                    name: 'oVoornaam2',
                                    controller: oVoornaam2,
                                    decoration: const InputDecoration(
                                        labelText: 'Parent firstname'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.notEqual(
                                          context, "")
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.3,
                                  child: FormBuilderTextField(
                                    name: 'oNaam2',
                                    controller: oNaam2,
                                    decoration: const InputDecoration(
                                        labelText: 'Parent lastname'),
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.notEqual(
                                          context, "")
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'beroep2',
                              controller: beroep2,
                              decoration: const InputDecoration(
                                  labelText: 'Profession'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'berStraat2',
                              controller: berStraat2,
                              decoration:
                                  const InputDecoration(labelText: 'Street'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: FormBuilderTextField(
                                  name: 'berHuisNr2',
                                  controller: berHuisNr2,
                                  decoration: const InputDecoration(
                                      labelText: 'House number'),
                                  keyboardType: TextInputType.number,
                                  // enkel nummers kubben ingevoerd worden
                                  // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(context),
                                    FormBuilderValidators.numeric(context),
                                    FormBuilderValidators.notEqual(context, '0')
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                child: FormBuilderTextField(
                                  name: 'berBusNr2',
                                  controller: berBusNr2,
                                  decoration: const InputDecoration(
                                      labelText: 'Additional'),
                                ),
                              ),
                            ]),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  child: FormBuilderTextField(
                                    name: 'berPostcode2',
                                    controller: berPostcode2,
                                    decoration: const InputDecoration(
                                        labelText: 'Postal code'),
                                    maxLength: 4,
                                    keyboardType: TextInputType.number,
                                    // enkel nummers kubben ingevoerd worden
                                    // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(context),
                                      FormBuilderValidators.numeric(context),
                                      FormBuilderValidators.maxLength(
                                          context, 4)
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 22.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    child: FormBuilderTextField(
                                      name: 'berGemeente2',
                                      controller: berGemeente2,
                                      decoration: const InputDecoration(
                                          labelText: 'City'),
                                      validator: FormBuilderValidators.compose([
                                        FormBuilderValidators.required(context),
                                        FormBuilderValidators.notEqual(
                                            context, "")
                                      ]),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 120,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // GOK vragen
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 1,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text('Do any of these statements apply to you?',
                          style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text('(Proof will be requested later)',
                          style: GoogleFonts.montserrat(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.black45)),
                      const SizedBox(
                        height: 10,
                      ),
                      const Expanded(
                        child: BulletList(
                          strings: [
                            'The family has received a school allowance in the 2019-2020 school year and/or in the 2020-2021 school year.',
                            'The mother of the pupil has a diploma of secondary education or a study certificate of the second year of the third degree of the secondary education or an associated equivalent study certificate.'
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // TN vragen
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text('Do any of these statements apply to you?',
                            style: GoogleFonts.montserrat(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87)),
                        const SizedBox(
                          height: 5,
                        ),
                        Text('(Proof will be requested later)',
                            style: GoogleFonts.montserrat(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45)),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 450,
                          child: const BulletList(strings: [
                            'At least a Dutch-language diploma of secondary education or an equivalent Dutch-language study certificate.',
                            'A Dutch-language certificate of the second year of the third stage of secondary education or an equivalent Dutch-language certificate.',
                            'Proof of at least sufficient knowledge of Dutch issued by Selor.',
                            'Proof of that one of them has attended 9 years of regular education in Dutch-language primary and secondary education.',
                            'Proof that one of them masters Dutch at at least level B2',
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),

                // school rangschik lijst
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 1,
                  child: SchoolList(),
                ),

                // overzicht
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //overzicht: Profile
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: InkWell(
                            onLongPress: () {
                              overzichtEdit('profile');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${voornaam.text} ${naam.text}',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey.shade700,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${straat.text} ${huisNr.text} ${busNr.text}',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '${postcode.text} ${gemeente.text}',
                                  style: GoogleFonts.montserrat(
                                      color: Colors.grey.shade700,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Divider(
                          thickness: 3,
                          height: 20,
                          indent: 50,
                          endIndent: 50,
                        ),

                        //overzicht:  statements
                        if (vraagGOK == true || vraagTN == true)
                          InkWell(
                            onLongPress: () {
                              overzichtEdit('statements');
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (vraagGOK == true)
                                  Chip(
                                    backgroundColor: Colors.orange.shade500,
                                    label: const Text(
                                      'GOK',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    elevation: 4,
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                if (vraagTN == true)
                                  Chip(
                                    backgroundColor: Colors.orange.shade500,
                                    label: const Text(
                                      'TN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    elevation: 4,
                                  ),
                              ],
                            ),
                          ),

                        //overzicht: parents
                        if (oVoornaam1.text != "")
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: FractionallySizedBox(
                              widthFactor: 0.4,
                              child: Column(
                                children: [
                                  Text('Parents',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (oVoornaam1.text != "")
                          Card(
                            elevation: 1,
                            shadowColor: Colors.lightBlueAccent,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onLongPress: () {
                                overzichtEdit('parents');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 10.0),
                                child: Table(
                                  defaultColumnWidth:
                                      const IntrinsicColumnWidth(),
                                  defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  children: [
                                    TableRow(children: [
                                      TableCell(
                                        child: Center(
                                          child: Text(
                                            '${oVoornaam1.text} ${oNaam1.text}',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.grey.shade700,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      if (oVoornaam2.text != "")
                                        const TableCell(
                                          child: SizedBox(
                                            width: 30,
                                          ),
                                        ),
                                      if (oVoornaam2.text != "")
                                        TableCell(
                                            child: Center(
                                          child: Text(
                                            '${oVoornaam2.text} ${oNaam2.text}',
                                            style: GoogleFonts.montserrat(
                                                color: Colors.grey.shade700,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                      const TableCell(
                                        child: SizedBox(
                                          height: 40,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                          child: Center(
                                        child: Text(
                                          beroep1.text.toString(),
                                          style: GoogleFonts.montserrat(
                                              color: Colors.grey.shade700,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      )),
                                      if (oVoornaam2.text != "")
                                        const TableCell(
                                          child: SizedBox(
                                            width: 30,
                                          ),
                                        ),
                                      if (oVoornaam2.text != "")
                                        TableCell(
                                          child: Center(
                                            child: Text(
                                              beroep2.text.toString(),
                                              style: GoogleFonts.montserrat(
                                                  color: Colors.grey.shade700,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      const TableCell(
                                        child: SizedBox(
                                          height: 40,
                                        ),
                                      )
                                    ]),
                                    TableRow(children: [
                                      TableCell(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                '${berStraat1.text} ${berHuisNr1.text} ${berBusNr1.text}',
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            Center(
                                              child: Text(
                                                '${berPostcode1.text} ${berGemeente1.text}',
                                                style: GoogleFonts.montserrat(
                                                    color: Colors.grey.shade700,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      if (oVoornaam2.text != "")
                                        const TableCell(
                                          child: SizedBox(
                                            width: 30,
                                          ),
                                        ),
                                      if (oVoornaam2.text != "")
                                        TableCell(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  '${berStraat2.text} ${berHuisNr2.text} ${berBusNr2.text}',
                                                  style: GoogleFonts.montserrat(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                              Center(
                                                child: Text(
                                                  '${berPostcode2.text} ${berGemeente2.text}',
                                                  style: GoogleFonts.montserrat(
                                                      color:
                                                          Colors.grey.shade700,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      const TableCell(
                                        child: SizedBox(
                                          height: 40,
                                        ),
                                      )
                                    ])
                                  ],
                                ),
                              ),
                            ),
                          ),

                        //overzicht: school lijst
                        if (SchoolList.schoolList != null &&
                            SchoolList.schoolList.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Column(
                                children: [
                                  Text('Schoollist',
                                      style: GoogleFonts.montserrat(
                                          color: Colors.grey.shade700,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500)),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (SchoolList.schoolList != null &&
                            SchoolList.schoolList.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: FractionallySizedBox(
                              widthFactor: 0.85,
                              child: Card(
                                elevation: 1,
                                shadowColor: Colors.lightBlueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  onLongPress: () {
                                    overzichtEdit('school list');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: List.generate(
                                        SchoolList.schoolList.length,
                                        (index) => Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                // verticaal centreren van circle avatar
                                                // https://stackoverflow.com/questions/55168962/listtile-heading-trailing-are-not-centered
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  // rangschiknummer
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        const Color.fromRGBO(
                                                            234, 144, 16, 1),
                                                    radius: 15,
                                                    // rang nummer
                                                    child: Text(
                                                      (index + 1).toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize: 15),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Flexible(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      SchoolList
                                                          .schoolList[index],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              color: Colors.grey
                                                                  .shade700,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                    Text(
                                                      'Straatnaan 12\nstadnaam postcode',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                          color: Colors.black45,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // succes / error pagina
                FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: regiSucces == true

                        // succes page
                        ? Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 500),
                                  child: Image(
                                    image: AssetImage('lib/images/succes.gif'),
                                    width: 250,
                                  ),
                                ),
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 900),
                                  child: Text(
                                      'Registration completed successfully'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 900),
                                  child:
                                      Text('You will be redirected shortly.'),
                                ),
                              ],
                            ),
                          )

                        // error page
                        : Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 500),
                                  child: Image(
                                    image: AssetImage('lib/images/error.gif'),
                                    width: 250,
                                  ),
                                ),
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 900),
                                  child: Text('Something went wrong'),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                DelayedDisplay(
                                  delay: Duration(milliseconds: 900),
                                  child: Text('Please try again later'),
                                ),
                              ],
                            ),
                          )),
              ],
              key: _slider),
        ),

        // toon enkel 2e ouder knop als men op de juiste pagina zit en 2e ouder nog niet aangeduid werd
        if (_currentStep == 3 && secParent == false)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  shape: const StadiumBorder(),
                  primary: Colors.grey),
              onPressed: () => {secParent = true, nextStep()},
              child: Text('Second parent',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )),
            ),
          ),

        // toon enkel 2e ouder verwijder knop als men op de juiste pagina zit en 2e ouder al aangeduid werd
        if (_currentStep == 4 && secParent == true)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  shape: const StadiumBorder(),
                  primary: Colors.redAccent),
              onPressed: removeParent,
              child: Text('Remove this parent',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  )),
            ),
          ),

        // toon de ja nee vragen enkel bij de GOK en TN vragen
        if (_currentStep == 5 || _currentStep == 6)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), primary: Colors.redAccent),

                  //color: Colors.red.shade100,
                  child: const Text('No'),
                  onPressed: () => {vraagYesNo(0)},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      primary: Colors.indigo.shade800),
                  child: const Text('Yes'),
                  onPressed: () => {vraagYesNo(1)},
                ),
              ],
            ),
          ),

        // back en next buttons
        //verberg als de registratie voltooid is
        if (regiSucces != true)
          DelayedDisplay(
            delay: const Duration(milliseconds: 1000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // verberg back button wanneer men op de eerste pagina is
                if (_currentStep != 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: const StadiumBorder(),
                        primary: Colors.grey),
                    child: Transform.rotate(
                        angle: 180 * math.pi / 180,
                        child: const Icon(Icons.forward)),
                    onPressed: () => {previousStep()},
                  ),
                // verberg next button wanneer men op de voorrangsvragen en de 2 laatste pagina's komt
                if (_currentStep != 5 &&
                    _currentStep != 6 &&
                    _currentStep != 8 &&
                    _currentStep != 9)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: const StadiumBorder(),
                        primary: Colors.indigo.shade800),
                    child: const Icon(Icons.forward),
                    onPressed: () => nextStep(),
                  ),
                if (_currentStep == 8)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        shape: const StadiumBorder(),
                        primary: Colors.indigo.shade800),
                    child: const Text('Finish'),
                    onPressed: () => nextStep(),
                  ),
              ],
            ),

            /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              /*
              // verberg back button wanneer men op de eerste pagina is
              if (_currentStep != 0)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: () => {previousStep()},
                ),
              if (_currentStep != 4 && _currentStep != 5)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                  ),
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => nextStep(),
                ),


               */

            ],
          ),*/
          ),
      ],
    );
  }
}

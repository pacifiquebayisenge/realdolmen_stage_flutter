import 'dart:async';
import 'dart:math' as math;
import 'package:schooler/widgets/widgets.dart';
import 'widgets.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_slider/page_slider.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/services/globals.dart' as globals;
import 'package:schooler/dummy_data/data.dart' as data;

import 'bullet_list.dart';

class FormQuestions extends StatefulWidget {
  const FormQuestions({Key? key}) : super(key: key);

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

  // Huidige stap aanwijzing
  int _currentStep = 0;

  // Huidige stap aanwijzing
  late int? _stepCount = 0;

  // bool om aan te duiden dat 2e ouder ook zal ingevoerd worden
  bool secParent = false;

  double pageHeight = 450;

  // methode om de GOK en TN vragen op te vragen
  // 2 knoppen = ja knop en nee knop
  // index als parameter om te weten welke knop gedrukt werd
  // 1 = true, 0 = nee
  void vraagYesNo(int index) {
    // aan de hand van welke pagina weten we over welke vragen het gaat
    switch (_currentStep) {
      case 4:
        {
          vraagGOK = index != 0;

          nextStep();
          print("vraagGOK $vraagGOK");
        }
        break;
      case 5:
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
          formSucces = _thisForm2.currentState!.validate();
        }
        break;

      case 2:
        {
          formSucces = _thisForm3.currentState!.validate();
        }
        break;

      case 3:
        {
          formSucces = _thisForm4.currentState!.validate();
        }
        break;
      case 4:
        {
          formSucces = true;
        }
        break;
      case 5:
        {
          pageHeight = 450;
          formSucces = true;
        }
        break;
      case 6:
        {
          formSucces = true;
        }
        break;
      case 7:
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

  setpageHeight(int page) {
    print('THIS IS THE ACTUAL PAGE NUMBER $page');
    if (page == 6 || page == 7) {
      setState(() {
        pageHeight = 550;
      });
    } else {
      setState(() {
        pageHeight = 450;
      });
    }
  }

  // Methode om naar volgende stap te gaan
  // ALs laatste stap is verstuur data naar server
  void nextStep() {
    print(checkStep());

    // als form op deze pagina niet juist is ingevoerd dan kan men niet verder
    if (!checkStep()) return;

    bool isLastStep =
        _currentStep == _slider.currentState!.widget.pages.length - 1;

    // als het de laatste stap is, vervoledig de wizart
    if (isLastStep) {
      print('Completed!');
      _thisForm.currentState!.save();


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
          schoolList: SearchPage.schoolList

      ).then((value)  {

        print('Succes animatie ');

      }).catchError(() {
        print('Error animatie');
      });

      /* globals.regi = new Registration(
        id: ,
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
          vraagTN: vraagTN); */


      //Navigator.pop(context);
    }
    //// Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina
    else if (_currentStep == 2 && secParent == false) {
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
    else if (_currentStep == 4 && secParent == false) {
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

  // key voor de page slider
  GlobalKey<PageSliderState> _slider = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Expanded widget gebruikt om de render layout overflow te fixen
    // bron: https://stackoverflow.com/questions/57203505/flutter-stretch-columns-to-full-screen-height

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
                // profiel info
                FormBuilder(
                  key: _thisForm,
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 700),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 22.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.5,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                                width: MediaQuery.of(context).size.width / 2.5,
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
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                      FormBuilderValidators.notEqual(
                                          context, '0')
                                    ]),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 22.0),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.5,
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
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                                      MediaQuery.of(context).size.width / 2.5,
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
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
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
                                        FormBuilderValidators.notEqual(
                                            context, '0')
                                      ]),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 22.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
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
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
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
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Text('Do any of these statements apply to you?'),
                      SizedBox(
                        height: 5,
                      ),
                      Text('(Proof will be requested later)'),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
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
                        const Text('Do any of these statements apply to you?'),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text('(Proof will be requested later)'),
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
                    widthFactor: 0.9, heightFactor: 1, child: SearchPage()),
                // overzicht
                FractionallySizedBox(
                    widthFactor: 0.9,
                    heightFactor: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                Text('${voornaam.text} ${naam.text}',
                                    style: TextStyle(
                                        color: Colors.grey.shade700,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            height: 20,
                            indent: 50,
                            endIndent: 50,
                          ),
                          Column(
                            children: [
                              Card(
                                elevation: 1,
                                shadowColor: Colors.lightBlueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  onLongPress: () {
                                    print('edit');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Table(
                                      defaultColumnWidth:
                                          IntrinsicColumnWidth(),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          TableCell(child: Text('Birthdate:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                            child: Text(
                                                '${rijksNr.text.substring(4, 6)}/${rijksNr.text.substring(2, 4)}/${rijksNr.text.substring(0, 2)}'),
                                          ),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('Address:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${straat.text} ${huisNr.text} ${busNr.text}'),
                                                Text(
                                                    '${gemeente.text} ${postcode.text}  ')
                                              ],
                                            ),
                                          ),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: FractionallySizedBox(
                                  widthFactor: 0.4,
                                  child: Column(
                                    children: [
                                      Text('Parents',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500)),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 1,
                                shadowColor: Colors.lightBlueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  onLongPress: () {
                                    print('edit');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Table(
                                      defaultColumnWidth:
                                          IntrinsicColumnWidth(),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('Full name:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                              child: Text(
                                                  '${oVoornaam1.text} ${oNaam1.text}')),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('Profession:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                              child: Text('${beroep1.text}')),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child:
                                                  Text('Profession address:')),
                                          const TableCell(
                                            child: SizedBox(
                                              width: 10,
                                            ),
                                          ),
                                          TableCell(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    '${berStraat1.text} ${berHuisNr1.text} ${berBusNr1.text} '),
                                                Text(
                                                    '${berGemeente1.text} ${berPostcode1.text}  ')
                                              ],
                                            ),
                                          ),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              if (secParent)
                                Card(
                                  elevation: 1,
                                  shadowColor: Colors.lightBlueAccent,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onLongPress: () {
                                      print('edit');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Table(
                                        defaultColumnWidth:
                                            const IntrinsicColumnWidth(),
                                        defaultVerticalAlignment:
                                            TableCellVerticalAlignment.middle,
                                        children: [
                                          TableRow(children: [
                                            const TableCell(
                                                child: Text('Full name:')),
                                            const TableCell(
                                                child: SizedBox(
                                              width: 10,
                                            )),
                                            TableCell(
                                                child: Text(
                                                    '${oVoornaam2.text} ${oNaam2.text}')),
                                            const TableCell(
                                              child: SizedBox(
                                                height: 30,
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const TableCell(
                                                child: Text('Profession:')),
                                            const TableCell(
                                              child: SizedBox(
                                                width: 10,
                                              ),
                                            ),
                                            TableCell(
                                                child: Text('${beroep2.text}')),
                                            const TableCell(
                                              child: SizedBox(
                                                height: 30,
                                              ),
                                            )
                                          ]),
                                          TableRow(children: [
                                            const TableCell(
                                                child: Text(
                                                    'Profession address:')),
                                            const TableCell(
                                              child: SizedBox(
                                                width: 10,
                                              ),
                                            ),
                                            TableCell(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      '${berStraat2.text} ${berHuisNr2.text} ${berBusNr2.text}'),
                                                  Text(
                                                      '${berGemeente2.text} ${berPostcode2.text}  ')
                                                ],
                                              ),
                                            ),
                                            const TableCell(
                                              child: SizedBox(
                                                height: 30,
                                              ),
                                            )
                                          ])
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: FractionallySizedBox(
                                  widthFactor: 0.4,
                                  child: Column(
                                    children: [
                                      Text('Statements',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500)),
                                      const Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 1,
                                shadowColor: Colors.lightBlueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: InkWell(
                                  onLongPress: () {
                                    print('edit');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Table(
                                      defaultColumnWidth:
                                          const IntrinsicColumnWidth(),
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('GOK statements:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                            child: vraagGOK == true
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color:
                                                        Colors.green.shade600,
                                                  )
                                                : Icon(
                                                    Icons.cancel,
                                                    color: Colors.red.shade600,
                                                  ),
                                          ),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('TN statements:')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                            child: vraagTN == true
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color:
                                                        Colors.green.shade600,
                                                  )
                                                : Icon(
                                                    Icons.cancel,
                                                    color: Colors.red.shade600,
                                                  ),
                                          ),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 30,
                                            ),
                                          )
                                        ])
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  child: Column(
                                    children: [
                                      Text('School list',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500)),
                                      Divider(
                                        thickness: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 50.0),
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
                                        print('edit');
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: List.generate(
                                            SearchPage.schoolList.length,
                                            (index) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
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
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Text(
                                                            SearchPage.schoolList[
                                                                index],
                                                            maxLines: 2,
                                                            overflow: TextOverflow
                                                                .ellipsis,
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                        const Text(
                                                            'Straatnaan 12, stadnaam postcode',
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                                fontSize: 11),),
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
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
              key: _slider),
        ),

        // toon enkel 2e ouder knop als men op de juiste pagina zit en 2e ouder nog niet aangeduid werd
        if (_currentStep == 2 && secParent == false)
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  shape: const StadiumBorder(),
                  primary: Colors.grey),
              onPressed: () => {secParent = true, nextStep()},
              child: const Text(
                'Second parent',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        // toon enkel 2e ouder verwijder knop als men op de juiste pagina zit en 2e ouder al aangeduid werd
        if (_currentStep == 3 && secParent == true)
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  alignment: Alignment.center,
                  shape: StadiumBorder(),
                  primary: Colors.redAccent),
              onPressed: () => {secParent = false, previousStep()},
              child: const Text(
                'remove this parent',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
          ),
        // toon de ja nee vragen enkel bij de GOK en TN vragen
        if (_currentStep == 4 || _currentStep == 5)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.redAccent),

                  //color: Colors.red.shade100,
                  child: const Text('No'),
                  onPressed: () => {vraagYesNo(0)},
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), primary: Colors.indigo.shade800),
                  child: const Text('Yes'),
                  onPressed: () => {vraagYesNo(1)},
                ),
              ],
            ),
          ),
        // back en next buttons
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
                      shape: StadiumBorder(),
                      primary: Colors.grey),
                  child: Transform.rotate(
                      angle: 180 * math.pi / 180,
                      child: const Icon(Icons.forward)),
                  onPressed: () => {previousStep()},
                ),
              // verberg next button wanneer men op de voorrangsvragen komt
              if (_currentStep != 4 && _currentStep != 5 && _currentStep != 7)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      shape: const StadiumBorder(),
                      primary: Colors.indigo.shade800),
                  child: const Icon(Icons.forward),
                  onPressed: () => nextStep(),
                ),
              if(_currentStep == 7)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    alignment: Alignment.center,
                    shape: const StadiumBorder(),
                    primary: Colors.indigo.shade800),
                child: Text('Finish'),
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

/*
* Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(1),
                  spreadRadius: -5,
                  blurRadius: 15,
                  offset: const Offset(6, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.arrow_forward_sharp),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add_circle),
                    label: 'New',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    label: 'Notifications',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school_sharp),
                    label: 'Schools',
                  ),
                ],
                currentIndex: 0,
                selectedItemColor: Colors.indigo.shade800,

              ),
            ),
          ),
        ))
* */

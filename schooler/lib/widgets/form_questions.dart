import 'dart:convert';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:page_slider/page_slider.dart';
import 'package:progress_stepper/progress_stepper.dart';
import 'package:schooler/services/user.dart';

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
  final rijksnr = TextEditingController();

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

  // Huidige stap aanwijzing
  int _currentStep = 0;

  // Huidige stap aanwijzing
  late int? _stepCount = 0;

  // bool om aan te duiden dat 2e ouder ook zal ingevoerd worden
  bool secParent = false;

  // methode om elke validator van elke formfield na te gaan
  // geeft bool terug om te zien of form juist is ingevoerd
  bool checkStep() {
    bool formSucces = false;

    switch (_currentStep) {
      case 0:
        {

          formSucces = _thisForm.currentState!.validate();
          if (formSucces) {
            _thisForm.currentState!.save();
            var t = json.encode(_thisForm.currentState!.value);
            print(t);
          }
        }
        break;

      case 1:
        {
          print(_thisForm2.currentState);
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
  void nextStep() {
    print(checkStep());

    // als form op deze pagina niet juist is ingevoerd dan kan men niet verder
    if (!checkStep()) return;

    bool isLastStep =
        _currentStep == _slider.currentState!.widget.pages.length - 1;

    // als het de laatste stap is, vervoledig de wizart
    if (isLastStep) {
      print('Completed!');

      // TODO:: send data to server
    }
    //// Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina
    else if (_currentStep == 2 && secParent == false) {
      setState(() => _currentStep += 2);

      _slider.currentState!.next();
      _slider.currentState!.next();
    } else {
      // step indicator verschijt => aantal stappen meegeven
      _stepCount = _slider.currentState!.widget.pages.length - 1;

      setState(() => _currentStep += 1);

      _slider.currentState!.next();
    }

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
          height: 450,
          child: PageSlider(
              duration: const Duration(milliseconds: 400),
              initialPage: _currentStep,
              pages: [
                // profiel info
                Padding(
                  padding: const EdgeInsets.fromLTRB(50.0, 00, 50, 0),
                  child: FormBuilder(
                    key: _thisForm,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          child: FormBuilderTextField(
                            name: 'voornaam',
                            controller: voornaam,
                            decoration:
                                const InputDecoration(labelText: 'Voornaam'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.notEqual(context, "")
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 700),
                          child: FormBuilderTextField(
                            name: 'naam',
                            controller: naam,
                            decoration:
                                const InputDecoration(labelText: 'Naam'),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                              FormBuilderValidators.notEqual(context, "")
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 900),
                          child: FormBuilderTextField(
                            name: 'rijksnr',
                            controller: rijksnr,
                            decoration: const InputDecoration(
                                labelText: 'Rijksregisternummer'),
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: FormBuilder(
                        key: _thisForm2,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            FormBuilderTextField(
                              name: 'straat',
                              controller: straat,
                              decoration:
                                  const InputDecoration(labelText: 'Straat'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'huisNr',
                              controller: huisNr,
                              decoration: const InputDecoration(
                                  labelText: 'Huisnummer'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'busNr',
                              controller: busNr,
                              decoration:
                                  const InputDecoration(labelText: 'Busnummer'),
                              
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'postcode',
                              controller: postcode,
                              decoration: const InputDecoration(
                                  labelText: 'Postcode'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'gemeente',
                              controller: gemeente,
                              decoration:
                                  const InputDecoration(labelText: 'Gemeente'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // eerste ouder info
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: FormBuilder(
                        key: _thisForm3,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: 'oVoornaam1',
                              controller: oVoornaam1,
                              decoration: const InputDecoration(
                                  labelText: 'Ouder voornaam'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'oNaam1',
                              controller: oNaam1,
                              decoration: const InputDecoration(
                                  labelText: 'Ouder naam'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'beroep1',
                              controller: beroep1,
                              decoration:
                                  const InputDecoration(labelText: 'Beroep'),
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
                                  const InputDecoration(labelText: 'Straat'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'berHuisNr1',
                              controller: berHuisNr1,
                              decoration: const InputDecoration(
                                  labelText: 'Huisnummer'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'berBusNr1',
                              controller: berBusNr1,
                              decoration:
                                  const InputDecoration(labelText: 'Busnummer'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'berPostcode1',
                              controller: berPostcode1,
                              decoration:
                                  const InputDecoration(labelText: 'Postcode'),
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
                            const SizedBox(
                              height: 20,
                            ),
                            FormBuilderTextField(
                              name: 'berGemeente1',
                              controller: berGemeente1,
                              decoration:
                                  const InputDecoration(labelText: 'Gemeente'),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                                FormBuilderValidators.notEqual(context, "")
                              ]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // tweede ouder info
                // enkel zichtbaar als 2e ouder knop wordt geklikt
                Visibility(
                  visible: secParent,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: FormBuilder(
                          key: _thisForm4,
                          child: Column(
                            children: [
                              FormBuilderTextField(
                                name: 'oVoornaam2',
                                controller: oVoornaam2,
                                decoration: const InputDecoration(
                                    labelText: 'Ouder voornaam'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.notEqual(context, "")
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'oNaam2',
                                controller: oNaam2,
                                decoration: const InputDecoration(
                                    labelText: 'Ouder naam'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.notEqual(context, "")
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'beroep2',
                                controller: beroep2,
                                decoration:
                                    const InputDecoration(labelText: 'Beroep'),
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
                                    const InputDecoration(labelText: 'Straat'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.notEqual(context, "")
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'berHuisNr2',
                                controller: berHuisNr2,
                                decoration: const InputDecoration(
                                    labelText: 'Huisnummer'),
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
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'berBusNr2',
                                controller: berBusNr2,
                                decoration:
                                    InputDecoration(labelText: 'Busnummer'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.notEqual(context, "")
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'berPostcode2',
                                controller: berPostcode2,
                                decoration: const InputDecoration(
                                    labelText: 'Postcode'),
                                keyboardType: TextInputType.number,
                                // enkel nummers kubben ingevoerd worden
                                // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                maxLength: 4,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.numeric(context),
                                  FormBuilderValidators.maxLength(context, 4)
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              FormBuilderTextField(
                                name: 'berGemeente2',
                                controller: berGemeente2,
                                decoration: const InputDecoration(
                                    labelText: 'Gemeente'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.notEqual(context, "")
                                ]),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // GOK vragen
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: const [
                      Text('Do any of these statements apply to you?'),
                      SizedBox(
                        height: 50,
                      ),
                      Expanded(
                        child: BulletList(
                          strings: [
                            '''The family has received a school allowance in the 2019-2020 school year and/or in the 2020-2021 school year.''',
                            '''The mother of the pupil has a diploma of secondary education or a study certificate of the second year of the third degree of the secondary education or an associated equivalent study certificate.'''
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // TN vragen
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                              'Do any of these statements apply to you?'),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 450,
                            child: const BulletList(strings: [
                              '''At least a Dutch-language diploma of secondary education or an equivalent Dutch-language study certificate.''',
                              '''A Dutch-language certificate of the second year of the third stage of secondary education or an equivalent Dutch-language certificate.''',
                              '''Proof of at least sufficient knowledge of Dutch issued by Selor.''',
                              '''Proof of that one of them has attended 9 years of regular education in Dutch-language primary and secondary education.''',
                              '''Proof that one of them masters Dutch at at least level B2''',
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
              key: _slider),
        ),

        // toon enkel 2 ouder knop als men op de juist pagina zit en 2e ouder nog niet aangeduid werd
        if (_currentStep == 2 && secParent == false)
          MaterialButton(
            elevation: 3,
            color: Colors.white54,
            // jump to zero-indexed page number
            onPressed: () => {
              secParent = true,
              nextStep()
            }, //_slider.currentState.setPage(3),
            child: const Text(
              'Second parent',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        // toon de ja nee vragen enkel bij de GOK en TN vragen
        if (_currentStep == 4 || _currentStep == 5)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // verberg back button wanneer men op de eerste pagina is

                MaterialButton(
                  color: Colors.red.shade100,
                  child: const Text('No'),
                  onPressed: () => {nextStep()},
                ),

                ElevatedButton(
                  child: const Text('Yes'),
                  onPressed: () => {nextStep()},
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
                  child: const Icon(Icons.arrow_back_ios),
                  onPressed: () => {previousStep()},
                ),
              if (_currentStep != 4 && _currentStep != 5)
                ElevatedButton(
                  child: const Icon(Icons.arrow_forward_ios),
                  onPressed: () => nextStep(),
                )
            ],
          ),
        ),
      ],
    );
  }
}

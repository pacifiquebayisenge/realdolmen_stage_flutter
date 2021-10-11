import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:page_slider/page_slider.dart';
import 'package:progress_stepper/progress_stepper.dart';

import 'bullet_list.dart';

class FormQuestions extends StatefulWidget {
  const FormQuestions({Key? key}) : super(key: key);


  @override
  _FormQuestionsState createState() => _FormQuestionsState();







}

class _FormQuestionsState extends State<FormQuestions> {

  // --- De Forms

   // De  form velden controllers
  final voornaam = TextEditingController();
  final naam = TextEditingController();
  final rijksnr = TextEditingController();

  final straat = TextEditingController();
  final strNr = TextEditingController();
  final busNr = TextEditingController();
  final postcode = TextEditingController();
  final gemeente = TextEditingController();

  final oVoornaam1 = TextEditingController();
  final oNaam1 = TextEditingController();
  final beroep1 = TextEditingController();
  final berStraat1 = TextEditingController();
  final berStrNr1 = TextEditingController();
  final berBusNr1 = TextEditingController();
  final berPostcode1 = TextEditingController();
  final berGemeente1 = TextEditingController();

  final oVoornaam2 = TextEditingController();
  final oNaam2 = TextEditingController();
  final beroep2 = TextEditingController();
  final berStraat2 = TextEditingController();
  final berStrNr2 = TextEditingController();
  final berBusNr2 = TextEditingController();
  final berPostcode2 = TextEditingController();
  final berGemeente2 = TextEditingController();

  // bool om te weten of een 2e ouder verwacht wordt
  bool secParent = false;

  // --- De step indicator

  // Huidige stap aanwijzing
  int _currentStep = 0;

  // Huidige stap aanwijzing
  late int? _stepCount = 0;

  // Methode om naar volgende stap te gaan
  // ALs laatste stap is verstuur data naar server
  void nextStep() {

    _thisForm.currentState!.save();

    bool isLastStep =
        _currentStep == _slider.currentState!.widget.pages.length - 1;

    if (isLastStep) {
      print('Completed!');

      // TODO:: send data to server
    }
    // Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina => dubbele stap vooruit
    else if (_currentStep == 2 && secParent == false) {
      setState(() => _currentStep += 2);
      _slider.currentState!.next();
      _slider.currentState!.next();
    } else {
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
    // Waneer maar 1 ouder werd aangeduid verberg 2é ouder invul pagina => dubbele stap achteruit
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

  GlobalKey<PageSliderState> _slider = GlobalKey();
  final _thisForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // Expanded widget gebruikt om de render layout overflow te fixen
    // bron: https://stackoverflow.com/questions/57203505/flutter-stretch-columns-to-full-screen-height

    return Column(
      children: <Widget>[
        Container(
          child: Padding(
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
        ),
        Form(
          key: _thisForm,
          child: Container(
            height: 450,
            child: PageSlider(
                duration: Duration(milliseconds: 400),
                initialPage: _currentStep,
                pages: [
                  // profiel info
                  Padding(
                    padding: EdgeInsets.fromLTRB(50.0, 00, 50, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 500),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: voornaam,
                            decoration: InputDecoration(labelText: 'Voornaam'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: Duration(  milliseconds: 700),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: naam,
                            decoration: InputDecoration(labelText: 'Naam'),
                          ),
                        ),
                        SizedBox(
                          height: 20,


                        ),
                        DelayedDisplay(
                          delay: Duration(milliseconds: 900),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: rijksnr,
                            decoration:
                            InputDecoration(labelText: 'Rijksregisternummer'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // adress info
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: straat,
                              decoration: InputDecoration(labelText: 'Straat'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: strNr,
                              decoration:
                              InputDecoration(labelText: 'Huisnummer'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: busNr,
                              decoration: InputDecoration(labelText: 'Busnummer'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: postcode,
                              decoration: InputDecoration(labelText: 'Postcode'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: gemeente,
                              decoration: InputDecoration(labelText: 'Gemeente'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // eerste ouder info
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: oVoornaam1,
                              decoration:
                              InputDecoration(labelText: 'Ouder voornaam'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: oNaam1,
                              decoration:
                              InputDecoration(labelText: 'Ouder naam'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: beroep1,
                              decoration: InputDecoration(labelText: 'Beroep'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berStraat1,
                              decoration: InputDecoration(labelText: 'Straat'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berStrNr1,
                              decoration:
                              InputDecoration(labelText: 'Huisnummer'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berBusNr1,
                              decoration: InputDecoration(labelText: 'Busnummer'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berPostcode1,
                              decoration: InputDecoration(labelText: 'Postcode'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berGemeente1,
                              decoration: InputDecoration(labelText: 'Gemeente'),
                            ),
                            SizedBox(
                              height: 20,
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(30.0),
                          child: Column(
                            children: [
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: oVoornaam2,
                                decoration:
                                InputDecoration(labelText: 'Ouder voornaam'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: oNaam2,
                                decoration:
                                InputDecoration(labelText: 'Ouder naam'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: beroep2,
                                decoration: InputDecoration(labelText: 'Beroep'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berStraat2,
                                decoration: InputDecoration(labelText: 'Straat'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berStrNr2,
                                decoration:
                                InputDecoration(labelText: 'Huisnummer'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berBusNr2,
                                decoration:
                                InputDecoration(labelText: 'Busnummer'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berPostcode2,
                                decoration:
                                InputDecoration(labelText: 'Postcode'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berGemeente2,
                                decoration:
                                InputDecoration(labelText: 'Gemeente'),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // GOK vragen
                  Padding(
                    padding: EdgeInsets.all(50.0),
                    child: Column(
                      children: [
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
                    padding: EdgeInsets.all(40),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Text('Do any of these statements apply to you?'),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 450,
                              child: BulletList(strings: [
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
            child: Text(
              'Second parent',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
          ),
        if (_currentStep == 4 || _currentStep == 5)
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                // verberg back button wanneer men op de eerste pagina is

                MaterialButton(
                  color: Colors.red.shade100,
                  child: Text('No'),
                  onPressed: () => {nextStep()},
                ),

                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () => {nextStep()},
                ),
              ],
            ),
          ),
        DelayedDisplay(
          delay: Duration(milliseconds: 1000),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // verberg back button wanneer men op de eerste pagina is
              if (_currentStep != 0)
                ElevatedButton(
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: () => {previousStep()},
                ),
              if (_currentStep != 4 && _currentStep != 5)
                ElevatedButton(
                    child: Icon(Icons.arrow_forward_ios),
                    onPressed: () => {nextStep()}),
            ],
          ),
        ),
      ],
    );
  }
}

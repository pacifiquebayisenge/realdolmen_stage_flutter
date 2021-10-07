import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schooler/widgets/bullet_list.dart';

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
            ),
            Center(
              child: Container(
                child: Text(
                  'New Registration',
                ),
              ),
            ),
            Questions(),
          ],
        ),
      ),
    );
  }
}

class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  // huidide stap
  int currentStep = 0;

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

  // de form stappen samen met de vragen
  List<Step> getSteps() => [
        Step(
          // Aanduiden wanneer stap actief of voltooid is
          isActive: currentStep >= 0,
          title: Text(''),
          content: Column(
            children: [
              TextFormField(
                controller: voornaam,
                decoration: InputDecoration(labelText: 'Voornaam'),
              ),
              TextFormField(
                controller: naam,
                decoration: InputDecoration(labelText: 'Naam'),
              ),
              TextFormField(
                controller: rijksnr,
                decoration: InputDecoration(labelText: 'Rijksregisternummer'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 1,
          title: Text(''),
          content: Column(
            children: [
              TextFormField(
                controller: straat,
                decoration: InputDecoration(labelText: 'Straat'),
              ),
              TextFormField(
                controller: strNr,
                decoration: InputDecoration(labelText: 'Huisnummer'),
              ),
              TextFormField(
                controller: busNr,
                decoration: InputDecoration(labelText: 'Busnummer'),
              ),
              TextFormField(
                controller: postcode,
                decoration: InputDecoration(labelText: 'Postcode'),
              ),
              TextFormField(
                controller: gemeente,
                decoration: InputDecoration(labelText: 'Gemeente'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 2,
          title: Text(''),
          content: Column(
            children: [
              TextFormField(
                controller: oVoornaam1,
                decoration: InputDecoration(labelText: 'Ouder voornaam'),
              ),
              TextFormField(
                controller: oNaam1,
                decoration: InputDecoration(labelText: 'Ouder naam'),
              ),
              TextFormField(
                controller: beroep1,
                decoration: InputDecoration(labelText: 'Beroep'),
              ),
              TextFormField(
                controller: berStraat1,
                decoration: InputDecoration(labelText: 'Straat'),
              ),
              TextFormField(
                controller: berStrNr1,
                decoration: InputDecoration(labelText: 'Huisnummer'),
              ),
              TextFormField(
                controller: berBusNr1,
                decoration: InputDecoration(labelText: 'Busnummer'),
              ),
              TextFormField(
                controller: berPostcode1,
                decoration: InputDecoration(labelText: 'Postcode'),
              ),
              TextFormField(
                controller: berGemeente1,
                decoration: InputDecoration(labelText: 'Gemeente'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 3,
          title: Text(''),
          content: Column(
            children: [
              TextFormField(
                controller: oVoornaam2,
                decoration: InputDecoration(labelText: 'Ouder voornaam'),
              ),
              TextFormField(
                controller: oNaam2,
                decoration: InputDecoration(labelText: 'Ouder naam'),
              ),
              TextFormField(
                controller: beroep2,
                decoration: InputDecoration(labelText: 'Beroep'),
              ),
              TextFormField(
                controller: berStraat2,
                decoration: InputDecoration(labelText: 'Straat'),
              ),
              TextFormField(
                controller: berStrNr2,
                decoration: InputDecoration(labelText: 'Huisnummer'),
              ),
              TextFormField(
                controller: berBusNr2,
                decoration: InputDecoration(labelText: 'Busnummer'),
              ),
              TextFormField(
                controller: berPostcode2,
                decoration: InputDecoration(labelText: 'Postcode'),
              ),
              TextFormField(
                controller: berGemeente2,
                decoration: InputDecoration(labelText: 'Gemeente'),
              ),
            ],
          ),
        ),
        Step(
          isActive: currentStep >= 4,
          title: Text(''),
          content: Column(
            children: [
              Text('Do any of these statements apply to you?'),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 250,
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
        Step(
          isActive: currentStep >= 5,
          title: Text(''),
          content: Container(),
        ),
        Step(
          isActive: currentStep >= 6,
          title: Text(''),
          content: Column(
            children: [
              Text('Do any of these statements apply to you?'),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 350,
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
        Step(
          isActive: currentStep >= 7,
          title: Text(''),
          content: Container(),
        ),
      ];

  // Methode om naar volgende stap te gaan
  // ALs laatste stap is verstuur data naar server
  void nextStep() {
    bool isLastStep = currentStep == getSteps().length - 1;

    if (isLastStep) {
      print('Completed!');

      // TODO:: send data to server
    } else {
      setState(() => currentStep += 1);
    }
  }

  // Methode om naar vorige stap te gaan
  // ALs eerste stap is sluit de popup
  void previousStep() {
    bool isFirstStep = currentStep == 0;

    if (isFirstStep) {
      Navigator.pop(context);
    } else {
      setState(() => currentStep -= 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Expanded widget gebruikt om de render layout overflow te fixen
    // bron: https://stackoverflow.com/questions/57203505/flutter-stretch-columns-to-full-screen-height

    return Expanded(
      child: Container(
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () => nextStep(),
          onStepCancel:
              // Als het eerste stap is dissable cancel button
              currentStep == 0 ? null : () => previousStep(),
          controlsBuilder: (context, {onStepContinue, onStepCancel}) {
            return Container(
              margin: EdgeInsets.only(top: 25),
              child: Column(children: [
                if (currentStep == 2)
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        child: Text('2e ouder'),
                        onPressed: onStepCancel,
                      ),
                    ),
                  ]),
                Row(
                  children: [
                    // Back button enkel weergeven qls we niet meer op stap 1 zijn
                    if (currentStep != 0)
                      Expanded(
                        child: ElevatedButton(
                          child: Text('Back'),
                          onPressed: onStepCancel,
                        ),
                      ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: ElevatedButton(
                        child: Text('Next'),
                        onPressed: onStepContinue,
                      ),
                    ),

                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ]),
            );
          },
        ),
      ),
    );
  }
}
/*

Column(
children: [
Container(
child: Text(
'''- The family has received a school allowance in the 2019-2020 school year
  and/or in the 2020-2021 school year
 '''),
),
Container(
child: Text('''
  - The mother of the pupil has a diploma of secondary education or a
  study certificate of the second year of
  the third degree of the
  secondary education or an associated
  equivalent study certificate?'''),
)
],
) */

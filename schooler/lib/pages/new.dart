import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:schooler/widgets/widgets.dart';

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ervoor zorgen dat de popup niet wordt gesloten door de back button van de device
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.indigo.shade800,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.indigo.shade800),
          backgroundColor: Colors.indigo.shade800,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
          title: const Padding(
            padding: EdgeInsets.only(left: 40.0),
            child: Text(
              'New Registration',
            ),
          ),
        ),
        // Voorkomen dat knoppen mee omhoog springen door het toetstebord
        // bron https://stackoverflow.com/questions/54115269/keyboard-is-pushing-the-floatingactionbutton-upward-in-flutter-app/56196712
        resizeToAvoidBottomInset: false,
        body: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(color: Colors.white, child: FormQuestions())),
        /*
        bottomNavigationBar: Padding(
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
*/
    ));
  }
}

/*
class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  bool secParent = false;

  // De  form velden controllers + keys

  final _thisForm = GlobalKey<FormState>();
  final voornaam = TextEditingController();
  final naam = TextEditingController();
  final rijksnr = TextEditingController();

  final _thisForm2 = GlobalKey<FormState>();
  final straat = TextEditingController();
  final strNr = TextEditingController();
  final busNr = TextEditingController();
  final postcode = TextEditingController();
  final gemeente = TextEditingController();

  final _thisForm3 = GlobalKey<FormState>();
  final oVoornaam1 = TextEditingController();
  final oNaam1 = TextEditingController();
  final beroep1 = TextEditingController();
  final berStraat1 = TextEditingController();
  final berStrNr1 = TextEditingController();
  final berBusNr1 = TextEditingController();
  final berPostcode1 = TextEditingController();
  final berGemeente1 = TextEditingController();

  final _thisForm4 = GlobalKey<FormState>();
  final oVoornaam2 = TextEditingController();
  final oNaam2 = TextEditingController();
  final beroep2 = TextEditingController();
  final berStraat2 = TextEditingController();
  final berStrNr2 = TextEditingController();
  final berBusNr2 = TextEditingController();
  final berPostcode2 = TextEditingController();
  final berGemeente2 = TextEditingController();

  // Huidige stap aanwijzing
  int _currentStep = 0;

  // Huidige stap aanwijzing
  late int? _stepCount = 0;


  // methode om elke validator van elke formfield na te gaan
  // geeft bool terug om te zien of form juist is ingevoerd
  bool checkStep() {
    bool formSucces = false;

    switch (_currentStep) {
      case 0:
        {
          formSucces = _thisForm.currentState!.validate();
          if(formSucces) {


          }
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
                  child: Form(
                    key: _thisForm,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 500),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: voornaam,
                            decoration:
                                const InputDecoration(labelText: 'Voornaam'),
                            validator: (value) {
                              if (value == '' || value!.isEmpty) {
                                return 'Dit veld mag niet leeg zijn!';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 700),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: naam,
                            decoration:
                                const InputDecoration(labelText: 'Naam'),
                            validator: (value) {
                              if (value == '' || value!.isEmpty) {
                                return 'Dit veld mag niet leeg zijn!';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DelayedDisplay(
                          delay: const Duration(milliseconds: 900),
                          child: TextFormField(
                            onSaved: (value) => print(value),
                            controller: rijksnr,
                            decoration: const InputDecoration(
                                labelText: 'Rijksregisternummer'),
                            validator: (value) {
                              if (value == '' || value!.isEmpty) {
                                return 'Dit veld mag niet leeg zijn!';
                              } else {
                                return null;
                              }
                            },
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
                      child: Form(
                        key: _thisForm2,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 50,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: straat,
                              decoration:
                                  const InputDecoration(labelText: 'Straat'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: strNr,
                              decoration: const InputDecoration(
                                  labelText: 'Huisnummer'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: busNr,
                              decoration:
                                  const InputDecoration(labelText: 'Busnummer'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: postcode,
                              decoration:
                                  const InputDecoration(labelText: 'Postcode'),
                              maxLength: 4,
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: gemeente,
                              decoration:
                                  const InputDecoration(labelText: 'Gemeente'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
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
                      child: Form(
                        key: _thisForm3,
                        child: Column(
                          children: [
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: oVoornaam1,
                              decoration: const InputDecoration(
                                  labelText: 'Ouder voornaam'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: oNaam1,
                              decoration: const InputDecoration(
                                  labelText: 'Ouder naam'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: beroep1,
                              decoration:
                                  const InputDecoration(labelText: 'Beroep'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berStraat1,
                              decoration:
                                  const InputDecoration(labelText: 'Straat'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berStrNr1,
                              decoration: const InputDecoration(
                                  labelText: 'Huisnummer'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berBusNr1,
                              decoration:
                                  const InputDecoration(labelText: 'Busnummer'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berPostcode1,
                              decoration:
                                  const InputDecoration(labelText: 'Postcode'),
                              maxLength: 4,
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              onSaved: (value) => print(value),
                              controller: berGemeente1,
                              decoration:
                                  const InputDecoration(labelText: 'Gemeente'),
                              validator: (value) {
                                if (value == '' || value!.isEmpty) {
                                  return 'Dit veld mag niet leeg zijn!';
                                } else {
                                  return null;
                                }
                              },
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
                        child: Form(
                          key: _thisForm4,
                          child: Column(
                            children: [
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: oVoornaam2,
                                decoration: const InputDecoration(
                                    labelText: 'Ouder voornaam'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: oNaam2,
                                decoration: const InputDecoration(
                                    labelText: 'Ouder naam'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: beroep2,
                                decoration:
                                    const InputDecoration(labelText: 'Beroep'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berStraat2,
                                decoration:
                                    const InputDecoration(labelText: 'Straat'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berStrNr2,
                                decoration: const InputDecoration(
                                    labelText: 'Huisnummer'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berBusNr2,
                                decoration:
                                    InputDecoration(labelText: 'Busnummer'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berPostcode2,
                                decoration: const InputDecoration(
                                    labelText: 'Postcode'),
                                maxLength: 4,
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                onSaved: (value) => print(value),
                                controller: berGemeente2,
                                decoration: const InputDecoration(
                                    labelText: 'Gemeente'),
                                validator: (value) {
                                  if (value == '' || value!.isEmpty) {
                                    return 'Dit veld mag niet leeg zijn!';
                                  } else {
                                    return null;
                                  }
                                },
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


Stepper(
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

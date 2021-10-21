import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, required this.c}) : super(key: key);

  final CustomCard c;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Student Information'),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${c.registration.voornaam} ${c.registration.naam}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              thickness: 1,
              height: 20,
              indent: 50,
              endIndent: 50,
            ),
            Container(
              child: Column(
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
                          defaultColumnWidth: IntrinsicColumnWidth(),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              TableCell(child: Text('geboortedatum:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                  child: Text('${c.registration.getBDate()}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('geslacht:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                  child: Text('${c.registration.getGender()}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('adres:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${c.registration.straat} ${c.registration.huisNr} ${c.registration.busNr}'),
                                    Text(
                                        '${c.registration.gemeente} ${c.registration.postcode}  ')
                                  ],
                                ),
                              ),
                              TableCell(
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
                    padding: const EdgeInsets.only( top :10.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: Column(
                        children: [
                          Text('Ouders',style: TextStyle(  color: Colors.grey.shade700, fontSize: 17, fontWeight: FontWeight.w500)),
                          Divider(
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
                          defaultColumnWidth: IntrinsicColumnWidth(),
                          defaultVerticalAlignment:
                              TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              TableCell(child: Text('Volledige naam:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                  child: Text('${c.registration.oVoornaam1} ${c.registration.oNaam1}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('beroep:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                  child: Text('${c.registration.beroep1}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),

                            TableRow(children: [
                              TableCell(child: Text('beroep adres:')),
                              TableCell(
                                  child: SizedBox(
                                width: 10,
                              )),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${c.registration.berStraat1} ${c.registration.berHuisNr1} ${c.registration.berBusNr1}'),
                                    Text(
                                        '${c.registration.berGemeente1} ${c.registration.berPostcode1}  ')
                                  ],
                                ),
                              ),
                              TableCell(
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
                          defaultColumnWidth: IntrinsicColumnWidth(),
                          defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                          children: [
                            TableRow(children: [
                              TableCell(child: Text('Volledige naam:')),
                              TableCell(
                                  child: SizedBox(
                                    width: 10,
                                  )),
                              TableCell(
                                  child: Text('${c.registration.oVoornaam2} ${c.registration.oNaam2}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),
                            TableRow(children: [
                              TableCell(child: Text('beroep:')),
                              TableCell(
                                  child: SizedBox(
                                    width: 10,
                                  )),
                              TableCell(
                                  child: Text('${c.registration.beroep2}')),
                              TableCell(
                                child: SizedBox(
                                  height: 30,
                                ),
                              )
                            ]),

                            TableRow(children: [
                              TableCell(child: Text('beroep adres:')),
                              TableCell(
                                  child: SizedBox(
                                    width: 10,
                                  )),
                              TableCell(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${c.registration.berStraat2} ${c.registration.berHuisNr2} ${c.registration.berBusNr2}'),
                                    Text(
                                        '${c.registration.berGemeente2} ${c.registration.berPostcode2}  ')
                                  ],
                                ),
                              ),
                              TableCell(
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
                    padding: const EdgeInsets.only( top :10.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: Column(
                        children: [
                          Text('Voorangsvragen',style: TextStyle(  color: Colors.grey.shade700, fontSize: 17, fontWeight: FontWeight.w500)),
                          Divider(
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
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('GOK/TN vragen'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( top :10.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.4,
                      child: Column(
                        children: [
                          Text('Scholen voorkeur',style: TextStyle(  color: Colors.grey.shade700, fontSize: 17, fontWeight: FontWeight.w500)),
                          Divider(
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
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('Scholen voorkeur'),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
/*


Container(
padding: EdgeInsets.all(16),
child: Column(
children: [
Text('geboortedatum: ${c.registration.getBDate()}'),
Text('geslacht: ${c.registration.getGender()}'),
Text('adres : ${c.registration.straat}'),
],
),
),*/

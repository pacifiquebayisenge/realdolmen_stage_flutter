import 'package:flutter/material.dart';
import 'package:schooler/widgets/widgets.dart';

class CardDetail extends StatelessWidget {
  const CardDetail({Key? key, required this.card}) : super(key: key);

  Icon genderIcon(String rijksNr) {

    if (int.parse( card.registration.rijksNr.substring(6,9)) % 2 == 0) return const Icon(Icons.female);

    return const Icon(Icons.male);
  }


  final CustomCard card;
  @override
  Widget build(BuildContext context) {

    print(int.parse( card.registration.rijksNr.substring(6,9)) % 2 == 0);

    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        elevation: 0,
        centerTitle: true,
        title: Row(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text( '${card.registration.voornaam} ${card.registration.naam}'),
            genderIcon(card.registration.rijksNr)
          ],
        ),

      ),
      body:SafeArea(
        bottom: false,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30)),
          child: FractionallySizedBox(
            heightFactor: 1,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    const Divider(
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
                                      const TableCell(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      TableCell(
                                          child: Text('${card.registration.getBDate()}')),
                                      const TableCell(
                                        child: SizedBox(
                                          height: 30,
                                        ),
                                      )
                                    ]),

                                    TableRow(children: [
                                      TableCell(child: const Text('adres:')),
                                      const TableCell(
                                          child: SizedBox(
                                        width: 10,
                                      )),
                                      TableCell(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                '${card.registration.straat} ${card.registration.huisNr} ${card.registration.busNr}'),
                                            Text(
                                                '${card.registration.gemeente} ${card.registration.postcode}  ')
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
                                          child: Text('${card.registration.oVoornaam1} ${card.registration.oNaam1}')),
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
                                          child: Text('${card.registration.beroep1}')),
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
                                                '${card.registration.berStraat1} ${card.registration.berHuisNr1} ${card.registration.berBusNr1}'),
                                            Text(
                                                '${card.registration.berGemeente1} ${card.registration.berPostcode1}  ')
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
                                          child: Text('${card.registration.oVoornaam2} ${card.registration.oNaam2}')),
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
                                          child: Text('${card.registration.beroep2}')),
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
                                                '${card.registration.berStraat2} ${card.registration.berHuisNr2} ${card.registration.berBusNr2}'),
                                            Text(
                                                '${card.registration.berGemeente2} ${card.registration.berPostcode2}  ')
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
            ),
          ),
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
Text('geboortedatum: ${card.registration.getBDate()}'),
Text('geslacht: ${card.registration.getGender()}'),
Text('adres : ${card.registration.straat}'),
],
),
),*/

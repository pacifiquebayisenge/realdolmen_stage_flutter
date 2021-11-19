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
                                    //overzichtEdit('profile');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 30.0),
                                    child: Table(
                                      defaultColumnWidth:
                                      const IntrinsicColumnWidth(),
                                      defaultVerticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          const TableCell(child: Text('Birthdate:')),
                                          const TableCell(
                                              child: SizedBox(
                                                width: 10,
                                              )),
                                          TableCell(
                                            child:  card.registration.rijksNr.isNotEmpty ?
                                            Text(
                                                '${card.registration.rijksNr.substring(4, 6)}/${card.registration.rijksNr.substring(2, 4)}/${card.registration.rijksNr.substring(0, 2)}')
                                                : const Text(""),
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
                              // titel: Parent
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
                                        thickness: 2,
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
                                    //overzichtEdit('parents');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 30.0),
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
                                                  '${card.registration.oVoornaam1} ${card.registration.oNaam1}')),
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
                                            ),),
                                          TableCell(
                                              child: Text(card.registration.beroep1)),
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
                                                    '${card.registration.berStraat1} ${card.registration.berHuisNr1} ${card.registration.berBusNr1} '),
                                                Text(
                                                    '${card.registration.berGemeente1} ${card.registration.berPostcode1}  ')
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
                              //if (secParent)
                                Card(
                                  elevation: 1,
                                  shadowColor: Colors.lightBlueAccent,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: InkWell(
                                    onLongPress: () {
                                      //overzichtEdit('parents');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 30.0),
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
                                                    '${card.registration.oVoornaam2} ${card.registration.oNaam2}')),
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
                                                child: Text('')),
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
                                                      '${card.registration.berStraat2} ${card.registration.berHuisNr2} ${card.registration.berBusNr2}'),
                                                  Text(
                                                      '${card.registration.berGemeente2} ${card.registration.berPostcode2}  ')
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
                                        thickness: 2,
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
                                    //overzichtEdit('statements');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical:20.0, horizontal: 40.0),
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
                                            ),),
                                          TableCell(
                                            child: card.registration.vraagGOK == true
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
                                            child: card.registration.vraagTN == true
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
                                      const Divider(
                                        thickness: 2,
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
                                        //overzichtEdit('schoollist');
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
                                                            SchoolList.schoolList[
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

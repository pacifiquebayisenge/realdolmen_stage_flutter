import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/widgets/widgets.dart';

class CardDetail extends StatefulWidget {
  const CardDetail({Key? key, required this.card}) : super(key: key);

  final CustomCard card;

  @override
  State<CardDetail> createState() => _CardDetailState();
}

class _CardDetailState extends State<CardDetail>
    with SingleTickerProviderStateMixin {
  Icon genderIcon(String rijksNr) {
    if (int.parse(widget.card.registration.rijksNr.substring(6, 9)) % 2 == 0)
      return const Icon(Icons.female);

    return const Icon(Icons.male);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':{
        Navigator.pushNamed(context, 'new',arguments: widget.card.registration);
      }

        break;
      case 'Cancel': {
        widget.card.registration.deleteRegi();
        Navigator.pop(context);
      }
        break;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Registration _registration = widget.card.registration;
    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // sliver app bar work around om dubbele titels weer te geven
                // bron: https://stackoverflow.com/questions/56365534/hide-the-tabbar-like-a-sliverappbar
                SliverAppBar(
                  backgroundColor: Colors.indigo.shade800,
                  floating: true,
                  snap: true,
                  pinned: true,
                  expandedHeight: 130.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: _registration.rijksNr.isNotEmpty
                        ? Text(
                            '${_registration.rijksNr.substring(4, 6)}/${_registration.rijksNr.substring(2, 4)}/${_registration.rijksNr.substring(0, 2)}'
                            '\n${_registration.straat} ${_registration.huisNr} ${_registration.busNr}'
                            '\n${_registration.postcode} ${_registration.gemeente}',
                            style: const TextStyle(
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          )
                        : const Text(""),
                    background: const Image(
                      image: AssetImage(
                        'lib/images/81.png',
                      ),
                      repeat: ImageRepeat.repeat,
                    ),
                    centerTitle: true,
                  ),
                ),
              ];
            },
            body: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              child: Container(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          // statements
                          if (_registration.vraagGOK == true ||
                              _registration.vraagTN == true)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_registration.vraagGOK == true)
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
                                SizedBox(
                                  width: 10,
                                ),
                                if (_registration.vraagTN == true)
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
                          // titel: Parents
                          if (_registration.oVoornaam1 != null)
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
                          if (_registration.oVoornaam1 != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Card(
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 30.0),
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
                                            width: 0,
                                          )),
                                          TableCell(
                                              child: Text(
                                                  '${_registration.oVoornaam1} ${_registration.oNaam1}')),
                                          const TableCell(
                                              child: SizedBox(
                                            width: 10,
                                          )),
                                          TableCell(
                                              child: Text(
                                                  '${_registration.oVoornaam2} ${_registration.oNaam2}')),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 40,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child: Text('Profession:')),
                                          const TableCell(
                                            child: SizedBox(
                                              width: 0,
                                            ),
                                          ),
                                          TableCell(
                                              child: Text(widget
                                                  .card.registration.beroep1
                                                  .toString())),
                                          const TableCell(
                                            child: SizedBox(
                                              width: 10,
                                            ),
                                          ),
                                          TableCell(
                                              child: Text(widget
                                                  .card.registration.beroep2
                                                  .toString())),
                                          const TableCell(
                                            child: SizedBox(
                                              height: 40,
                                            ),
                                          )
                                        ]),
                                        TableRow(children: [
                                          const TableCell(
                                              child:
                                                  Text('Profession address:')),
                                          const TableCell(
                                            child: SizedBox(
                                              width: 0,
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
                                                    '${_registration.berStraat2} ${_registration.berHuisNr2} ${_registration.berBusNr2} '),
                                                Text(
                                                    '${_registration.berGemeente2} ${_registration.berPostcode2}  ')
                                              ],
                                            ),
                                          ),
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
                                                    '${_registration.berStraat1} ${_registration.berHuisNr1} ${_registration.berBusNr1} '),
                                                Text(
                                                    '${_registration.berGemeente1} ${_registration.berPostcode1}  ')
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
                            ),

                          // school lijst
                          if (_registration.schoolList.length > 0)
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
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: FractionallySizedBox(
                              widthFactor: 0.85,
                              child: Card(
                                elevation: 1,
                                shadowColor: Colors.lightBlueAccent,
                                clipBehavior: Clip.antiAlias,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    children: List.generate(
                                      _registration.schoolList.length,
                                      (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20.0),
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
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Text(
                                                      _registration
                                                          .schoolList[index],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const Text(
                                                    'Straatnaan 12, stadnaam postcode',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 11),
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
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: MediaQuery.removePadding(
              context: context,
              removeBottom: true,
              child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'lib/images/81.png',
                        ),
                        repeat: ImageRepeat.repeat,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  backgroundColor: Colors.indigo.shade800,
                  iconTheme: IconThemeData(color: Colors.white),
                  automaticallyImplyLeading: true,
                  leading: IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  leadingWidth: 20,
                  elevation: 0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${_registration.voornaam} ${_registration.naam}'),
                      const SizedBox(
                        width: 10,
                      ),
                      genderIcon(_registration.rijksNr)
                    ],
                  ),
                  centerTitle: true,
                  actions: [
                    PopupMenuButton<String>(
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {'Edit', 'Cancel'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        })
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

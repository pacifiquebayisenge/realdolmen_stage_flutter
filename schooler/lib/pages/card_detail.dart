import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Icon genderIcon() {
    if (widget.card.registration.getGender() == 'vrouw') {
      widget.card.registration.getGender();
      return const Icon(Icons.female);
    }

    return const Icon(Icons.male);
  }

  void handleClick(String value) {
    switch (value) {
      case 'Edit':
        {
          Navigator.pop(context);
          Navigator.pushNamed(context, 'new',
              arguments: widget.card.registration);
        }

        break;
      case 'Cancel':
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => DeleteDialog(widget: widget),
          );
        }
        break;
    }
  }

  late ScrollController _scrollController;
  double textOpacitiy = 1;

  @override
  void initState() {
    super.initState();

    // als sliverappbar colapsed is verberg profiel detail
    // als sliveappbar expanded is toon profiel detail

    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          if (textOpacitiy != 0) {
            setState(() {
              setState(() {
                textOpacitiy = 0;
              });
            });
          }
        } else {
          if (textOpacitiy != 1) {
            setState(() {
              setState(() {
                textOpacitiy = 1;
              });
            });
          }
        }
      });
  }

  // methode om te zien of sliverappbar exapned is of collapsed
  // bron: https://stackoverflow.com/questions/53372276/flutter-how-to-check-if-sliver-appbar-is-expanded-or-collapsed
  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (90 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Registration _registration = widget.card.registration;
    return Scaffold(
      backgroundColor: Colors.indigo.shade800,
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                // sliver app bar work around om dubbele titels weer te geven
                // bron: https://stackoverflow.com/questions/56365534/hide-the-tabbar-like-a-sliverappbar
                SliverAppBar(
                  leadingWidth: 20,
                  leading: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  backgroundColor: Colors.indigo.shade800,
                  floating: false,
                  snap: false,
                  pinned: true,
                  expandedHeight: 130.0,
                  flexibleSpace: Stack(
                    children: [
                      const Positioned.fill(
                        child: Image(
                          image: AssetImage(
                            'lib/images/81.png',
                          ),
                          repeat: ImageRepeat.repeat,
                          fit: BoxFit.contain,
                        ),
                      ),
                      FlexibleSpaceBar(
                        title: _registration.rijksNr.isNotEmpty
                            ? Text(
                                '${_registration.rijksNr.substring(4, 6)}/${_registration.rijksNr.substring(2, 4)}/${_registration.rijksNr.substring(0, 2)}'
                                '\n${_registration.straat} ${_registration.huisNr} ${_registration.busNr}'
                                '\n${_registration.postcode} ${_registration.gemeente}',
                                style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Colors.white.withOpacity(textOpacitiy)),
                                textAlign: TextAlign.center,
                              )
                            : const Text(""),
                        centerTitle: true,
                      ),
                    ],
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
                                const SizedBox(
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
                                          const IntrinsicColumnWidth(),
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
                                                    '${_registration.berStraat1} ${_registration.berHuisNr1} ${_registration.berBusNr1} '),
                                                Text(
                                                    '${_registration.berPostcode1} ${_registration.berGemeente1}')
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
                                                    '${_registration.berStraat2} ${_registration.berHuisNr2} ${_registration.berBusNr2} '),
                                                Text(
                                                    '${_registration.berPostcode2} ${_registration.berGemeente2}   ')
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
                          if (_registration.schoolList != null &&
                              _registration.schoolList.length > 0)
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
                          if (_registration.schoolList != null &&
                              _registration.schoolList.length > 0)
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
                                                        _registration
                                                            .schoolList[index],
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 11),
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
                  backgroundColor: Colors.transparent,
                  iconTheme: const IconThemeData(color: Colors.white),
                  automaticallyImplyLeading: true,
                  leading: IconButton(
                    icon: const Icon(Icons.close_rounded),
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
                      genderIcon()
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


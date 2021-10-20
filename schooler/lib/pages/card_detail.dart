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
      ),
      body: Container(
        child: Hero(
          tag: 'test-${c.voornaam}',
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${c.voornaam} ${c.naam}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('geboortedatum'),
                              Text('geslacht'),
                              Text('adres'),
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
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Ouder 1 info'),
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
                        child: Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Text('Ouder 2 info'),
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
    );
  }
}

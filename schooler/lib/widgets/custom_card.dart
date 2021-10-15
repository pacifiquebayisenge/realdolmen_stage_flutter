import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:schooler/dummy_data/data.dart' as dummy;

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key,required this.voornaam, required this.naam}) : super(key: key);
  final String voornaam;
  final String naam;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: Colors.lightBlueAccent,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(16),
          child: CardContent(voornaam, naam)

        ),
      ),
    );
  }
}

class CardContent extends StatefulWidget {
  const CardContent(  this.voornaam,this.naam, {Key? key }) : super(key: key);
  final String voornaam;
  final String naam;


  @override
  _CardContentState createState() => _CardContentState();
}

class _CardContentState extends State<CardContent> {


  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        '${this.widget.voornaam} ${this.widget.naam}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 20),
      Text(
          'Lorem Ipsum is slechts een proeftekst uit het drukkerij- en zetterijwezen. '
              'Lorem Ipsum is de standaard proeftekst in deze bedrijfstak sinds de 16e eeuw, '
              'toen een onbekende drukker een zethaak met letters nam en ze door elkaar husselde om een font-catalogus te maken.  '),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: LinearPercentIndicator(
          padding: EdgeInsets.only(top: 10,bottom: 20),

          lineHeight: 4.0,
          percent: 0.7,
          animation: true,
          animationDuration: 1000,


          linearStrokeCap: LinearStrokeCap.roundAll,
          backgroundColor: Colors.grey,
          progressColor: Colors.blue,
        ),
      ),
    ]);
  }
}


import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.deepPurpleAccent,
        width: 300,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            radius: 30,
            splashColor: Colors.blue.withAlpha(255),
            onTap: () {
              print('Card tapped.');
            },
            child: Text('A card that can be tapped'),
          ),
        ),
      ),
    );
  }
}

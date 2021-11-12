

import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint(
      {Key? key,
      required this.text,
      })
      : super(key: key);
  final String text;


  @override
  Widget build(BuildContext context) {


    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          String.fromCharCode(0x2022),
          style: const TextStyle(
            fontSize: 20
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(

          child: Text(
            text,

          ),
        )
      ],
    );
  }
}

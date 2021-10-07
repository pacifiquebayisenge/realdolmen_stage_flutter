

import 'package:flutter/material.dart';

class BulletPoint extends StatelessWidget {
  const BulletPoint(
      {Key? key,
      required this.text,
      required this.animationController,
      required this.index})
      : super(key: key);
  final String text;
  final AnimationController animationController;
  final int index;

  @override
  Widget build(BuildContext context) {
    double _animationStart = 0.1 * index;
    double _animationEnd = _animationStart + 0.4;

    return SlideTransition(
      position: Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0)).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval(_animationStart, _animationEnd, curve: Curves.ease),
        ),
      ),
      child: FadeTransition(
        opacity: animationController,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              String.fromCharCode(0x2022),
            ),
            SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                text,
              ),
            )
          ],
        ),
      ),
    );
  }
}

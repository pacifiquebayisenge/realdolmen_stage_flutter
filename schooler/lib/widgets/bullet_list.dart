import 'dart:async';

import 'package:flutter/material.dart';
import 'widgets.dart';

class BulletList extends StatefulWidget {
  const BulletList({Key? key, required this.strings}) : super(key: key);
  final List<String> strings;

  @override
  State<BulletList> createState() => _BulletListState();
}

class _BulletListState extends State<BulletList>
    with SingleTickerProviderStateMixin {
   late AnimationController _animatedController;

  @override
  void initState() {
    _animatedController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    Timer(Duration(milliseconds: 200), () => _animatedController.forward());

     

    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.strings.length * 2, (index) {
          if (index.isEven) {
            return Flexible(
              flex: 3,
              child: BulletPoint(
                text: widget.strings[index ~/ 2],
                animationController: _animatedController,
                index: index ~/ 2,
              ),
            );
          } else {
            return Spacer(
              flex: 1,
            );
          }
        }),
      ),
    );
  }
}

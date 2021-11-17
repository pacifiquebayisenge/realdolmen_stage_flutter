import 'dart:math';

import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/widgets/map_view.dart';
import 'package:schooler/widgets/school_search.dart';
class Schools extends StatefulWidget {
  const Schools({Key? key}) : super(key: key);

  @override
  State<Schools> createState() => _SchoolsState();
}

class _SchoolsState extends State<Schools> {

  bool mapMode = false;

  void changeMode() {
    if(mapMode == false){
      setState(() {
        mapMode = true;
      });
    }else {
      setState(() {
        mapMode = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: mapMode == true ? MapView(modeChanger: changeMode,) : SchoolSearch(modeChanger: changeMode)
    );
  }
}


/*

 height: 112,



* List.generate(widget.strings.length * 2, (index) {
          if (index.isEven) {
            return Flexible(
              flex: 3,
              child: BulletPoint(
                text: widget.strings[index ~/ 2],

              ),
            );
          } else {
            return Spacer(
              flex: 1,
            );
          }
        }),
*
*
* scholen.map((t) {
              return InkWell(
                onTap: () {print(t);},
                child: Container(
                    color: Colors.transparent,
                    height: 112,
                    child: Center(child: Text(t))),
              );
            }).toList(),
* */

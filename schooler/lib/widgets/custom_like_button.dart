import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:schooler/classes/school.dart';
import 'package:schooler/dummy_data/data.dart';
import 'package:schooler/services/globals.dart';

class CustomLikeButton extends StatefulWidget {
  CustomLikeButton({Key? key, required this.school, required this.refresh}) : super(key: key);
  late final SchoolObject school;
  final Function refresh;

  @override
  _CustomLikeButtonState createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton> {


   _changeLikeState(bool likeState) {
    print(thisUser.favoSchoolsList.indexOf(widget.school));

    setState(() {

      if(!likeState)
      {
        _addToFavList(widget.school);

        print('ADD SCHOOL');
      }
      else
      {
        _removeFromFavList(widget.school);

        print('REMOVE SCHOOL');
      }
    });



   print('Favo school list length => ${thisUser.favoSchoolsList.length}');

  }


  _addToFavList(SchoolObject school) async {
     setState(() {
       thisUser.favoSchoolsList.add(school);
     });

    await school.addSchoolFavo();
    //thisUser.updateSchoolList(schoolList:  thisUser.favoSchoolsList);

  }

  _removeFromFavList(SchoolObject school) async {
     setState(() {
       thisUser.favoSchoolsList.removeAt(thisUser.favoSchoolsList.indexOf(school));
     });



    await school.removeSchoolFavo();
    //thisUser.updateSchoolList(schoolList:  thisUser.favoSchoolsList);
  }

  @override
  Widget build(BuildContext context) {

    return LikeButton(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        isLiked: thisUser.favoSchoolsList.contains(widget.school) ? true : false,
        size: 24,
        onTap: (isLiked) async {
          _changeLikeState(isLiked);
          widget.refresh();
          return !isLiked;
        },
        circleColor: CircleColor(
            start: const Color(0xff00ddff), end: Colors.indigo.shade800),
        likeBuilder: (isLiked) {
          return Icon(
            Icons.favorite_rounded,
            color: isLiked ? Colors.redAccent : Colors.grey,
            size: 24,
          );
        });
  }
}

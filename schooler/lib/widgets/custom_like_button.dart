
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatefulWidget {
  const CustomLikeButton({Key? key}) : super(key: key);

  @override
  _CustomLikeButtonState createState() => _CustomLikeButtonState();
}

class _CustomLikeButtonState extends State<CustomLikeButton> {


  bool isLiked = false;


  @override
  Widget build(BuildContext context) {
    return LikeButton(
      padding: const EdgeInsets.symmetric(horizontal: 15),
        isLiked: isLiked,
        size: 24,
        onTap: (bool l) async {
          this.isLiked = !l;
          setState(() {
            //resultList[index].isFavo = !l;

            // if(resultList[index].isFavo) _addToFavList(resultList[index]);
            //if(resultList[index].isFavo) _removeFromFavList(resultList[index]);
          });

          //print('it was ${resultList[index].isFavo}');
          //print('it isn now ${resultList[index].isFavo}');
          return !l;
        },
        circleColor: CircleColor(
            start: const Color(0xff00ddff),
            end: Colors.indigo.shade800),
        likeBuilder: (isFavo) {
          return Icon(
            Icons.favorite_rounded,
            color: isLiked
                ? Colors.redAccent
                : Colors.grey,
            size: 24,
          );
        });
  }
}



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/pages/card_detail.dart';

class DeleteDialog extends StatefulWidget {
  const DeleteDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CardDetail widget;

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {

  _confirm() async {
    String? result = await widget.widget.card.registration.deleteRegi();

    if(result == null) return;

    _showSnackbar(result);

    Navigator.pop(context);
    Navigator.pop(context);
  }


  _showSnackbar(String text) {

    final snackBar = SnackBar(
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          color: const Color.fromRGBO(54, 60, 69, 1),
          child:  Text(
            text,
            style:  GoogleFonts.montserrat(color: Colors.orange, fontWeight: FontWeight.w600 ),textAlign: TextAlign.center,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),

      title: Center(child: Text('Are you sure ?',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
      content: Text('This action will parmanently delete '
          'and cancel the registration.',style: GoogleFonts.montserrat(),),
      actions: [



        TextButton(
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.redAccent.withOpacity(0.7))),
          child: Text('No',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.redAccent)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.indigo.shade800.withOpacity(0.7))),
          child: Text('Yes',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.indigo.shade800,)),
          onPressed: _confirm,
        ),
      ],
    );
  }
}

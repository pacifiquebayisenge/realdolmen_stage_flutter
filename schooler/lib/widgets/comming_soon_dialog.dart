import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommingSoonDialog extends StatefulWidget {
  const CommingSoonDialog({Key? key}) : super(key: key);

  @override
  State<CommingSoonDialog> createState() => _CommingSoonDialogState();
}

class _CommingSoonDialogState extends State<CommingSoonDialog> {
  _confirm() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),

      title: Center(child: Text('THis page is still in development',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
      content: Text('Come back later ',style: GoogleFonts.montserrat(),),
      actions: [




        TextButton(
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.indigo.shade800.withOpacity(0.7))),
          child: Text('Ok',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.indigo.shade800,)),
          onPressed: _confirm,
        ),
      ],
    );
  }
}

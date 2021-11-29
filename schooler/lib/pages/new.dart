

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/widgets/widgets.dart';

class New extends StatelessWidget {
  const New({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final editRegi = ModalRoute.of(context)!.settings.arguments as Registration;


    // ervoor zorgen dat de popup niet wordt gesloten door de back button van de device
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.indigo.shade800,
        appBar: AppBar(
centerTitle: true,
          flexibleSpace: const Image(
            image: AssetImage('lib/images/81.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
          elevation: 0,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarColor: Colors.indigo.shade800),
          backgroundColor: Colors.indigo.shade800,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title:  Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              'New Registration',style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Colors.white),
            ),
          ),
        ),
        // Voorkomen dat knoppen mee omhoog springen door het toetstebord
        // bron https://stackoverflow.com/questions/54115269/keyboard-is-pushing-the-floatingactionbutton-upward-in-flutter-app/56196712
        resizeToAvoidBottomInset: false,
        body: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            child: Container(color: Colors.white, child: FormQuestions(editRegi: editRegi,))),
      ),
    );
  }
}

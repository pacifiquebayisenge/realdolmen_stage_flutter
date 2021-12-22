import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolDetailPage extends StatelessWidget {
  const SchoolDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.black12),
          backgroundColor: Colors.indigo.shade800,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: Text(
              'School Info',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(

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
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Container(

                  color: Colors.white,
               child: Column(
                 children: [
                    Text('Parents',
                       style: GoogleFonts.montserrat(
                           color: Colors.grey.shade700,
                           fontSize: 17,
                           fontWeight: FontWeight.w500)),
                 ],
               ),
                  ),
            )),
      ),
    );
  }
}

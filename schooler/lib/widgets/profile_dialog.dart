import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/classes/registration.dart';
import 'package:schooler/services/globals.dart';

class ProfileDialog extends StatefulWidget {
  ProfileDialog({Key? key}) : super(key: key);

  @override
  _ProfileDialogState createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  // De  form velden controllers + keys
  final _thisForm = GlobalKey<FormBuilderState>();
  final voornaam = TextEditingController();
  final naam = TextEditingController();
  final rijksNr = TextEditingController();

  @override
  void dispose() {
    voornaam.dispose();
    naam.dispose();
    rijksNr.dispose();

    super.dispose();
  }



  _submit() async {
    // methode om de keybo
    FocusScope.of(context).requestFocus(FocusNode());
    if (_thisForm.currentState!.validate() == false) return;

    bool result = await thisUser.updateUserProfile(
        voornaam: voornaam.text, naam: naam.text, rijksNr: rijksNr.text);
    Navigator.of(context).pop();
    if (result == true) return _showSnackbar("User Successfully Updated");
    _showSnackbar("Failed to update user");
  }

  // snackbar widget om verwijdering van de registratie te bevestigen
  _showSnackbar(String text) {
    final snackBar = SnackBar(
      content: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          color: const Color.fromRGBO(54, 60, 69, 1),
          child: Text(
            text,
            style: GoogleFonts.montserrat(
                color: Colors.orange, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        "Complete profile info",
        style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
      ),
      content: SizedBox(
        height: 270,
        child: FormBuilder(
          key: _thisForm,
          child: Column(
            children: [
              DelayedDisplay(
                delay: const Duration(milliseconds: 700),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: FormBuilderTextField(
                    name: 'voornaam',
                    controller: voornaam,
                    decoration: const InputDecoration(labelText: 'Firstname'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.notEqual(context, "")
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 700),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: FormBuilderTextField(
                    name: 'naam',
                    controller: naam,
                    decoration: const InputDecoration(labelText: 'Lastname'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.notEqual(context, "")
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DelayedDisplay(
                delay: const Duration(milliseconds: 900),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: FormBuilderTextField(
                    name: 'rijksNr',
                    controller: rijksNr,
                    decoration: const InputDecoration(
                        labelText: 'National Insurance number'),
                    keyboardType: TextInputType.number,
                    // enkel nummers kubben ingevoerd worden
                    // bron: https://stackoverflow.com/questions/49577781/how-to-create-number-input-field-in-flutter/49578197
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 11,

                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.minLength(context, 11),
                      FormBuilderValidators.maxLength(context, 11),
                      // custom validator om rijksregisternummer te checken
                      (value) {
                        if (int.parse(value!.substring(9, 11)) ==
                            Registration.rijksNrCheck(value)) {
                          return null;
                        } else {
                          return 'Invalid';
                        }
                      }
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Container(
          width: 120,
          height: 40,
          decoration: BoxDecoration(
              color: Colors.indigo.shade800,
              borderRadius: const BorderRadius.all(
                Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(1),
                  spreadRadius: -5,
                  blurRadius: 15,
                  offset: const Offset(6, 6),
                )
              ]),
          child: MaterialButton(
            onPressed: () {
              _submit();
            },
            elevation: 2,
            child: Text(
              'Submit',
              style: GoogleFonts.montserrat(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

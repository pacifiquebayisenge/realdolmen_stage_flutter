import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:schooler/services/globals.dart';

//ignore: must_be_immutable
class FilterDialog extends StatefulWidget {
   FilterDialog({Key? key, required this.applyFilter}) : super(key: key);

   static String selectedType = 'All';
  static String selectedPlace = 'All';
  late Function applyFilter;
  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {

   List<String> types = [ 'All','Basisonderwijs','Secundair onderwijs'];
   List<String> places = [ 'All'];



  _getTypes(){


    schools.forEach((element) {
      if(types.contains(element.type)) return;
      types.add(element.type);
    });



  }

   _getPlaces(){


     schools.forEach((element) {
       if(places.contains(element.adres.split(',')[1].split(' ')[2])) return;
       places.add(element.adres.split(',')[1].split(' ')[2]);
     });



   }

  @override
  void initState() {
    _getPlaces();

    super.initState();
  }

  _confirm() {
    widget.applyFilter();
    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),

      title: Center(child: Text('Filter',style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            const Text('Type : '),

              CustomDropdownButton2(
               buttonWidth: 180,
                itemWidth: 180,
                iconSize: 15,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                hint: 'Select type',
                valueAlignment: Alignment.center,
                dropdownItems: types,
                value: FilterDialog.selectedType,
                onChanged: (value) {
                  setState(() {
                    FilterDialog.selectedType = value!;
                  });
                },
              ),

          ],),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Place : '),

              CustomDropdownButton2(
                buttonWidth: 180,
                itemWidth: 180,
                iconSize: 15,
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                hint: 'Select place',
                valueAlignment: Alignment.center,
                dropdownItems: places,
                value: FilterDialog.selectedPlace,
                onChanged: (value) {
                  setState(() {
                    FilterDialog.selectedPlace = value!;
                  });
                },
              ),

            ],),
          const SizedBox(height: 20,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 10),
                alignment: Alignment.center,
                shape: const StadiumBorder(),
                primary: Colors.redAccent,
              ),
              onPressed: () {
                setState(() {
                  FilterDialog. selectedType = 'All';
                  FilterDialog.selectedPlace = 'All';
                });
              },
              child: Text('Reset', style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.white),)
          )

        ],),
      actions: [
        TextButton(
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.redAccent.withOpacity(0.7))),
          child: Text('Cancel',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.redAccent)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.indigo.shade800.withOpacity(0.7))),
          child: Text('Apply',style: GoogleFonts.montserrat(fontWeight: FontWeight.w500,color: Colors.indigo.shade800,)),
          onPressed: _confirm,
        ),
      ],
    );
  }
}

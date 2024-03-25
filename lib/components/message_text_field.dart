import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyMessageTextField extends StatelessWidget {

  final String hintText;
  final FocusNode? focusNode;

  final bool obsecure;
  final TextEditingController controller;
  MyMessageTextField({this.focusNode,required this.hintText,required this.obsecure,required this.controller,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(

        controller: controller,
        focusNode: focusNode,
        obscureText: obsecure,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(18),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color:Theme.of(context).colorScheme.tertiary )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color:Theme.of(context).colorScheme.primary )
            ),
            fillColor: Theme.of(context).colorScheme.secondary,
            filled: true,
            hintText: hintText,




            hintStyle: GoogleFonts.montserrat(color:Theme.of(context).colorScheme.primary,fontSize: 12)
        ),


      ),

    );
  }
}

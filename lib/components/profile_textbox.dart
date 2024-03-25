import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class ProfileTextBox extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String sectionname;



 ProfileTextBox({required this.onPressed,required this.text,required this.sectionname,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade200
      ),
      padding: EdgeInsets.only(left: 15,bottom: 15,),
      margin: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          //sectionname
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(sectionname,style: GoogleFonts.montserrat(color: Colors.grey.shade500),),
              IconButton(onPressed: onPressed, icon: Icon(Ionicons.pencil_sharp,color: Colors.grey.shade400,))
            ],
          ),
          


          //text
          Text(text)


        ],
      ),


    );
  }
}

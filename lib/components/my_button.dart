import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
final String text;
final bool loading;

  const MyButton({required this.loading,required this.text,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap ,
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10.0),

        ),
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        child:Center(child: loading? CircularProgressIndicator(strokeWidth: 3,color: Colors.black54,):Text(text,style: TextStyle(color: Colors.black54),)) ,
      ),
    );
  }
}

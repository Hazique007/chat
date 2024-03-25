import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {


  final String hintText;
  final String validator;
  final bool obsecure;
  final TextEditingController controller;
  MyTextField({required this.validator,required this.hintText,required this.obsecure,required this.controller,super.key});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),

        child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return validator;
              }
              else if(value.length < 6){
                return 'Password must be greater than 6 letters';
              }
            },
            controller: controller,
            obscureText: obsecure,
            decoration: InputDecoration(
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
              hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 13.0)
            ),


          ),


    );
  }
}

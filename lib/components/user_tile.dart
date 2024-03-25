import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const UserTile({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        margin: EdgeInsets.symmetric(vertical:5,horizontal: 25),
        padding:EdgeInsets.all(20) ,
        child: Row( children: [
          //icon
          Icon(Icons.person),
          SizedBox(width: 20,),

          //user name
          Text(text),
        ],),
      ),
    );
  }
}

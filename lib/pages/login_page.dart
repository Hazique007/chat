import 'package:chatting/auth/auth_service.dart';
import 'package:chatting/components/my_button.dart';
import 'package:chatting/components/mytext_field.dart';
import 'package:chatting/pages/home_page.dart';
import 'package:chatting/pages/register_pages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/toast.dart';

class LoginPage extends StatefulWidget {

  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final _formkey =GlobalKey<FormState>();
  final TextEditingController _emailitingcontroller = TextEditingController();

  final TextEditingController _passwordeditingcontroller = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 void login() async{
    if (_formkey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      UserCredential userCredential =

      await _auth
          .signInWithEmailAndPassword(
          email: _emailitingcontroller.text.toString(),
          password: _passwordeditingcontroller.text.toString());
          _firestore.collection("Users").doc(userCredential.user!.uid).set(
            {
              'uid':userCredential.user!.uid,
              'email': _emailitingcontroller.text.toString(),
            }

          )
          .then((value) {
        // Utils().toastMessage(value.user!.email.toString());
            setState(() {
              loading = false;

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
            });

      }).onError((error, stackTrace) {
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;

        });

      });
    }
  }


  // void login(BuildContext context) async{
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.messenger,
                size: 60, color: Theme.of(context).colorScheme.primary),
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Glad to see you again',
              style: GoogleFonts.montserrat(
                  fontSize: 16.0, color: Theme.of(context).colorScheme.primary),
            ),
            SizedBox(
              height: 25.0,
            ),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  MyTextField(
                    hintText: 'Email',
                    obsecure: false,
                    controller: _emailitingcontroller,
                    validator: 'Please enter email',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),

                  MyTextField(
                    hintText: 'Password',
                    validator: 'Please enter password',
                    obsecure: true,
                    controller: _passwordeditingcontroller,
                  ),

                ],
              ),
            ),



            SizedBox(
              height: 25.0,
            ),
            MyButton(text: 'Login', onTap:()=>login(),loading: loading,),
            SizedBox(
              height: 30.0,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'New member?',
                style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12.0),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                },
                  child: Text(
                ' Register now',
                style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ))
            ])
          ],
        ),
      ),
    );
  }
}

import 'package:chatting/auth/auth_service.dart';
import 'package:chatting/pages/home_page.dart';
import 'package:chatting/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utils/toast.dart';
import '../components/my_button.dart';
import '../components/mytext_field.dart';

class SignUp extends StatefulWidget {

  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool loading = false;
  final _formkey =GlobalKey<FormState>();
   FirebaseAuth _auth =FirebaseAuth.instance;
   final FirebaseFirestore _firestore =FirebaseFirestore.instance;
  final TextEditingController _emailitingcontroller = TextEditingController();

  final TextEditingController _passwordeditingcontroller = TextEditingController();

  final TextEditingController _confirmpasswordeditingcontroller = TextEditingController();

   void signup() async{
     if(_formkey.currentState!.validate() && _passwordeditingcontroller.text == _confirmpasswordeditingcontroller.text ) {
       setState(() {
         loading = true;
       });


       UserCredential userCredential =

       await _auth
           .createUserWithEmailAndPassword(
           email: _emailitingcontroller.text.toString(),
           password: _passwordeditingcontroller.text.toString());
      _firestore.collection("Users").doc(userCredential.user!.uid).set(
           {
             'uid':userCredential.user!.uid,

             'email': _emailitingcontroller.text.toString(),
             'username':_emailitingcontroller.text.split('@')[0] ,
             'bio': 'Empty bio...'
           }

       )
       // after creatig user create a new doc in firestor
       // FirebaseFirestore .instance.collection('Userdata').doc(userCredential.user!.email!)
           .then((value) {
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
     } else{
       showDialog(context: context, builder: (context)=>AlertDialog(
                 title: Text("Passwords dont match")),
               );

     }



  }



  // void register(BuildContext context) {
  //   // get auth service
  //   final _auth =AuthService();
  //   if(_passwordeditingcontroller.text == _confirmpasswordeditingcontroller.text){
  //     try{
  //       _auth.signUpwithemailandPass(_emailitingcontroller.text, _passwordeditingcontroller.text);
  //     }catch (e){
  //       showDialog(context: context, builder: (context)=>AlertDialog(
  //         title: Text(e.toString()),
  //       )
  //       );
  //     }
  //   }
  //   else{
  //     showDialog(context: context, builder: (context)=>AlertDialog(
  //       title: Text("Passwords dont match")),
  //     );
  //
  //   }
  //
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
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
                'Let\'s create an account for you',
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
                      obsecure: true,
                      controller: _passwordeditingcontroller,
                      validator: 'Please enter password',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    MyTextField(
                        hintText: 'Confirm Password',
                        validator: 'Please enter password',
                        obsecure: true,
                        controller: _confirmpasswordeditingcontroller),

                  ],
                ),
              ),





              SizedBox(
                height: 25.0,
              ),
              MyButton(text: 'Register', onTap: ()=>signup(),loading:loading ,),
              SizedBox(
                height: 30.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Already a member?',
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                  },
                    child: Text(
                  ' Login',
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ))
              ])
            ],
          ),
        ),
      ),
    );
  }
}

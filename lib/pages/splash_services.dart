import 'dart:async';

import 'package:chatting/pages/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';


class SplashServices{




  void isLogin(BuildContext context){
    final auth =FirebaseAuth.instance;

    final user = auth.currentUser;
    if(user!=null){
      Timer(Duration(seconds: 2), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage())));
    }
    else{
      Timer(Duration(seconds: 2), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage())));
    }




  }

}
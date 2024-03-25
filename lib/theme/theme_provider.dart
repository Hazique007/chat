import 'package:chatting/theme/dark_mode.dart';
import 'package:chatting/theme/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
  ThemeData _themeData = lightmode;

  ThemeData get themeData => _themeData;

  bool get isDark=> _themeData==darkmode;

  set themeData( ThemeData themeData){
    _themeData=themeData;
    notifyListeners();
  }

  void toggletheme(){
    if(_themeData== lightmode){
      themeData=darkmode;
    }else{
      themeData= lightmode;
    }
  }





}
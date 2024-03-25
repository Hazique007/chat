import 'package:chatting/auth/auth_gate.dart';
import 'package:chatting/firebase_options.dart';
import 'package:chatting/pages/home_page.dart';
import 'package:chatting/pages/login_page.dart';
import 'package:chatting/pages/register_pages.dart';
import 'package:chatting/pages/splash_screen.dart';
import 'package:chatting/theme/light_theme.dart';
import 'package:chatting/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
      create:(context)=> ThemeProvider() ,
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SplashScreen(),

    );
  }
}


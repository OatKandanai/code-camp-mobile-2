import 'package:flutter/material.dart';
import 'package:mini_project/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foods Menu',
      home: Home(),
      theme: ThemeData(textTheme: GoogleFonts.kanitTextTheme()),
    );    
  }
}

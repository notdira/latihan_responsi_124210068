import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latihankuis_prakpam/tampilan/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SPACE FLIGHT NEWS',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        //font
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: MyHomePage(),
    );
  }
}
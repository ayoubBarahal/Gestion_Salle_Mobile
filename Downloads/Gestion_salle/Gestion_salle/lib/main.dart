import 'package:flutter/material.dart';
import 'package:gestion_salle/pages/Professeurpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion des Salles',
      theme: ThemeData(
        primaryColor: Color(0xFFD4A017),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFD4A017),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFD4A017),
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      // Change `home` to ProfesseurPage for testing.
      home: ProfesseurPage(),
    );
  }
}

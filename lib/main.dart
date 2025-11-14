import 'package:flutter/material.dart';

import 'Views/home/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Definition de mes elements qui vont me servir dans tous le code
  @override
  Widget build(BuildContext context) {
    const Color lightBlue=Color(0xFFC1E8FF);
    const Color pastelBlue = Color(0xFF7DA0C4);
    const Color mediumBlue = Color(0xFF5483B4);
    const Color deepBlue = Color(0xFF052659);
    const Color darkBlue = Color(0xFF021024);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'convertBase',
      theme: ThemeData(
        // Couleurs principales
        primaryColor: mediumBlue,
        scaffoldBackgroundColor: lightBlue.withOpacity(0.8),

        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: mediumBlue,
          onPrimary: Colors.white,
          secondary: deepBlue,
          onSecondary: Colors.white,
          error: Colors.red,
          onError: Colors.white,
          background: lightBlue,
          onBackground: darkBlue,
          surface: Colors.white,
          onSurface: deepBlue,
        ),

        // Textes
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: darkBlue,fontFamily: 'Mamba'),
          bodyMedium: TextStyle(color: deepBlue,fontFamily: 'Mamba'),
          titleLarge: TextStyle(color: mediumBlue,fontFamily: 'Mamba', fontWeight: FontWeight.bold),
        ),

        // Boutons
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: deepBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
          ),
        ),

        // Champs de texte
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: pastelBlue),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: mediumBlue, width: 2),
          ),
          hintStyle: TextStyle(color: pastelBlue),
          labelStyle: TextStyle(color: deepBlue),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: darkBlue,
          foregroundColor: Colors.white,
          elevation: 4,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontFamily: 'Mamba',
            fontWeight: FontWeight.bold,

          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/':(context)=>HomePage(),
      },
    );
  }
}


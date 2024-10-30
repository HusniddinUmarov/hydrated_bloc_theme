import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get dark =>
      ThemeData(
        useMaterial3: true,
        appBarTheme:
        const AppBarTheme(backgroundColor: Colors.deepPurpleAccent),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo, brightness: Brightness.dark),
      );

  static ThemeData get light =>
      ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.orange,
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),),
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange, brightness: Brightness.light)
      );
}
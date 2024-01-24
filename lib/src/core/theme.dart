import 'package:flutter/material.dart';

final theme = ThemeData(
  fontFamily: 'Quicksand',

  // Define the default brightness and colors.
  scaffoldBackgroundColor: const Color(0xFFF1F4F8),

  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF226A6D), // Primary color
    onPrimary: Colors.white, // Text color on primary color
    secondary: Color(0xffFFE6CE), // Your secondary color
    onSecondary: Colors.black, // Text color on secondary color
  ),

  primaryColorLight: const Color(0xFFbcd2d3),

  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    bodyMedium: TextStyle(fontSize: 16.0, height: 2),
  ),

  // Define the default button theme
  buttonTheme: const ButtonThemeData(
    buttonColor: Color(0xFF226A6D), // Primary color
    textTheme: ButtonTextTheme.primary,
  ),

  // Define the default input (form fields) theme
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    filled: true,
    fillColor: Colors.white,
  ),

  // Define other app-wide styles
  appBarTheme: const AppBarTheme(
    // color: Color(0xFF226A6D),
    color: Color(0xFFF1F4F8),
    titleTextStyle: TextStyle(
      fontFamily: 'Quicksand',
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Color(0xFF226A6D),
    ),
    iconTheme: IconThemeData(color: Color(0xFF226A6D)),
  ),

  bottomAppBarTheme: const BottomAppBarTheme(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.grey,
    elevation: 100,
  ),

  cardTheme: const CardTheme(
    elevation: 0,
    color: Colors.white,
  ),

  // Define the color of icons within the app
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
);

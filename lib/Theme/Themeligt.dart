import 'package:flutter/material.dart';

ThemeData dirkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade800,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade500,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
        bodyColor: Colors.grey.shade300,
        displayColor: Colors.white,
      ),
);

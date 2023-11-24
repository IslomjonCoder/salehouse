import 'package:flutter/material.dart';

class TButtonTheme {
  static final ButtonThemeData buttonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
  );
  static final FilledButtonThemeData filledButtonTheme = FilledButtonThemeData(
      style: ButtonStyle(
        shape:
        MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ));
  static final ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
      style: ButtonStyle(
        shape:
        MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ));
  static final OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
      style: ButtonStyle(
        shape:
        MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
      ));
}
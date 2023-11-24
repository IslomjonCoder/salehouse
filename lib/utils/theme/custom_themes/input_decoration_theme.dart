import 'package:flutter/material.dart';

class TInputDecorationTheme {
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    prefixIconColor: Colors.black.withOpacity(0.54),
    suffixIconColor: Colors.black.withOpacity(0.54),
    iconColor: Colors.black.withOpacity(0.54),
    // hintStyle: const TextStyle(fontSize: 14),
  );
}
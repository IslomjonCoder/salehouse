import 'package:flutter/material.dart';

class TCardTheme {
  static final CardTheme cardTheme = CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0),
      side: const BorderSide(color: Color(0xFFeedff6)),
    ),
    surfaceTintColor:  Colors.white,
    elevation: 20.0,
    margin: EdgeInsets.zero,
    color: Colors.white,
    shadowColor: const Color(0xFFeedff6),
  );
}
import 'package:flutter/material.dart';

class TCardTheme {
  static final CardTheme cardTheme = CardTheme(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    surfaceTintColor: const Color(0xFFeedff6),
    elevation: 1.0,
    margin: EdgeInsets.zero,
    color: Colors.white,
    shadowColor: const Color(0xFFeedff6),
  );
}
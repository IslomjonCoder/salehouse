import 'package:crm/utils/theme/custom_themes/button_theme.dart';
import 'package:crm/utils/theme/custom_themes/card_theme.dart';
import 'package:crm/utils/theme/custom_themes/input_decoration_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TAppTheme {
  static final ThemeData theme = ThemeData(
    primaryColor: const Color(0xFF32064a),
    primaryColorLight: const Color(0xFF8e2bc4),
    disabledColor: const Color(0xFfbb8cd3),
    hoverColor: const Color(0xFF7e1bb4),
    focusColor: const Color(0xFF360052),

    // create custom theme
    cardTheme: TCardTheme.cardTheme,
    buttonTheme: TButtonTheme.buttonTheme,
    filledButtonTheme: TButtonTheme.filledButtonTheme,
    elevatedButtonTheme: TButtonTheme.elevatedButtonTheme,
    outlinedButtonTheme: TButtonTheme.outlinedButtonTheme,
    inputDecorationTheme: TInputDecorationTheme.inputDecorationTheme,
    textTheme: GoogleFonts.interTextTheme(),
  );
}
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:crm/presentations/common_widgets/rounded_container.dart';
import 'package:crm/utils/theme/app_theme.dart';
import 'package:crm/presentations/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.theme,
      home: const SplashScreen()
    );
  }
}


import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/api_constants.dart';
import 'package:crm/utils/constants/colors.dart';
import 'package:crm/utils/constants/image_strings.dart';
import 'package:crm/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:awesome_extensions/awesome_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start the animation
    _animationController.forward();

    check();
  }

  void check() async {
    // await TLocalStorage.remove(tokenKey);
    await Future.delayed(const Duration(seconds: 3));

    TLocalStorage.getString(tokenKey).then((value) {
      if (value != null) {
        context.pushReplacementNamed(RouteNames.tabBox);
      } else {
        context.pushReplacementNamed(RouteNames.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(fadeAnimation: _fadeAnimation),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class GradientBackground extends StatelessWidget {
  final Animation<double> fadeAnimation;

  const GradientBackground({super.key, required this.fadeAnimation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FadeTransition(
        opacity: fadeAnimation,
        child: Center(child: Text('SaleHouse',style: context.displaySmall?.copyWith(color: TColors.tPrimaryColor),)),
      ),
    );
  }
}

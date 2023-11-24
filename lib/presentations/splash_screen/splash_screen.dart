import 'package:crm/presentations/routes/routes.dart';
import 'package:crm/utils/constants/api_constants.dart';
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
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    // Start the animation
    _animationController.forward();

    check();
  }

  void check() async {
    // await TLocalStorage.remove(tokenKey);
    await Future.delayed(const Duration(seconds: 2));

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
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(TImages.appLogo, height: 300),
              Text(
                "CRM ga xush kelibsiz",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              // const Gap(20),
              // CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

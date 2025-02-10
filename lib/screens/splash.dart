import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:tour_aid/screens/onboarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final String splashImage = 'assets/images/splash.png';
  final Color backgroundColor = const Color.fromARGB(255, 218, 227, 250);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: splashImage,
      nextScreen: const OnboardingPage(),
      centered: true,
      backgroundColor: const Color.fromARGB(255, 218, 227, 250),
      splashIconSize: 220.0,
      duration: 2800,
    );
  }
}

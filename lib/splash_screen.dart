import 'package:flutter/material.dart';

import 'auth_repository.dart';
import 'home_screen.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthRepository _auth = AuthRepository();
  @override
  void initState() {
    super.initState();
    _decidirDestino();
  }

  Future<void> _decidirDestino() async {
    final sesionFuture = _auth.cambiosDeSesion.first;
    await Future.delayed(const Duration(seconds: 2));
    final usuario = await sesionFuture;
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            usuario != null ? const HomeScreen() : const OnboardingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 175, 76, 102),
      body: Center(
        child: Image.asset(
          'img/planta_2-removebg-preview.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}

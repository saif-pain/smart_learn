import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_learn/core/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    await Future.delayed(const Duration(seconds: 1)); // Keep the brief splash delay
    
    // Check if a user is already signed in
    final User? currentUser = FirebaseAuth.instance.currentUser;
    
    if (currentUser != null) {
      // User is signed in, navigate directly to main screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } else {
      // User is not signed in, check if it's first launch
      final bool isFirstLaunch = await SharedPrefs.isFirstLaunch();
      
      if (mounted) {
        if (isFirstLaunch) {
          // Show onboarding for first-time users
          Navigator.pushReplacementNamed(context, '/onboarding');
        } else {
          // Not first launch, but not logged in, go to welcome screen
          Navigator.pushReplacementNamed(context, '/welcome');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/splash_bg.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/smartlearn_logo.png',
                  height: 200,
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

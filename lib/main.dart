import 'package:flutter/material.dart';
import 'package:smart_learn/core/shared_prefs.dart';
import 'package:smart_learn/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartLearnApp());
}

class SmartLearnApp extends StatelessWidget {
  const SmartLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLearn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: const SplashScreen(),
    );
  }
}

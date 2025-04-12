import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_learn/core/shared_prefs.dart';
import 'package:smart_learn/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartLearnApp());
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDxOfB37ntJ97MHHMIs6oN3I66wUJR3l8E",
          authDomain: "smart-learn-2ae2a.firebaseapp.com",
          projectId: "smart-learn-2ae2a",
          storageBucket: "smart-learn-2ae2a.firebasestorage.app",
          messagingSenderId: "445120191852",
          appId: "1:445120191852:web:90ab361ceaf20ac1e0e749",
          measurementId: "G-Y48577JRRM"));

  }
  else{
    await Firebase.initializeApp();
  }
  
}

class SmartLearnApp extends StatelessWidget {
  const SmartLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartLearn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      home: const SplashScreen(),
    );
  }
}

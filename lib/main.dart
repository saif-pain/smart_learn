import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_learn/screens/login_screen.dart';
import 'package:smart_learn/screens/main_screen.dart';
import 'package:smart_learn/screens/onboarding_screen.dart';
import 'package:smart_learn/screens/splash_screen.dart';
import 'package:smart_learn/screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDxOfB37ntJ97MHHMIs6oN3I66wUJR3l8E",
        authDomain: "smart-learn-2ae2a.firebaseapp.com",
        projectId: "smart-learn-2ae2a",
        storageBucket: "smart-learn-2ae2a.appspot.com",
        messagingSenderId: "445120191852",
        appId: "1:445120191852:web:90ab361ceaf20ac1e0e749",
        measurementId: "G-Y48577JRRM",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const SmartLearnApp());
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
        // Adding platform-specific back button handling
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      // Set up proper navigation with named routes
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main': (context) => const MainScreen(),
        '/login': (context) => const LoginScreen(),
        '/onboarding': (context) => const OnboardingScreen(),
        '/welcome': (context) => const WelcomeScreen(),
      },
      // Handle Android back button behavior
      navigatorKey: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const SplashScreen(),
        );
      },
    );
  }
}

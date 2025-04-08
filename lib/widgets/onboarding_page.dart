import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String image, title, description;

  const OnboardingPage({super.key, required this.image, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image, width: 250),
          const SizedBox(height: 30),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 15),
          Text(description, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

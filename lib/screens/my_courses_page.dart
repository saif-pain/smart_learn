import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';

class MyCoursesPage extends StatelessWidget {
  const MyCoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of enrolled courses
    final myCourses = [
      {
        'title': 'Compiler Design',
        'image': 'assets/images/compiler.png', 
        'progress': 0.5,
      },
      {
        'title': 'Mobile App Design',
        'image': 'assets/images/MAD.png', 
        'progress': 0.7,
      },
      {
        'title': 'Mobile App Design Lab',
        'image': 'assets/images/mad_lab.png', 
        'progress': 0.7,
      },
      {
        'title': 'Artificial Intelligence',
        'image': 'assets/images/opp.png',
        'progress': 0.8,
      },
      {
        'title': 'Computer Architecture & Organization',
        'image': 'assets/images/cao.png',
        'progress': 0.9,
      },
      {
        'title': 'Artificial Intelligence Lab',
        'image': 'assets/images/ai_lab.png',
        'progress': 0.9,
      },
      {
        'title': 'Compiler Design Lab',
        'image': 'assets/images/cd_lab.png',
        'progress': 0.9,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Courses'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView.builder(
        itemCount: myCourses.length,
        itemBuilder: (context, index) {
          final course = myCourses[index];
          final String title = course['title'] as String;
          final String image = course['image'] as String;
          final double progress = course['progress'] as double;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Course Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Course Title and Progress
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Progress Bar
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            color: AppColors.primary,
                            minHeight: 6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(progress * 100).toInt()}% Done',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow Icon for details
                  const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

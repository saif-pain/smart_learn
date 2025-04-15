import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/screens/lessons_page.dart';
import 'package:smart_learn/screens/questions.dart';


class CourseDetailsPage extends StatelessWidget {
  final String title;
  
  const CourseDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(
          0xFFE9DED3),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseBanner(),
            _buildTabBar(context),
            const SizedBox(height: 16),
            _buildCourseTitle(),
            const SizedBox(height: 8),
            _buildCourseDescription(),
            const SizedBox(height: 16),
            _buildCourseDetails(),
            const SizedBox(height: 16),
            _buildSkills(),
            const SizedBox(height: 16),
            _buildStartCourseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseBanner() {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.secondary,
            image: const DecorationImage(
              // Using a placeholder since course_banner.png might not exist
              image: AssetImage('assets/images/onboarding1.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: IconButton(
            icon: Icon(
              Icons.play_circle_fill,
              color: AppColors.white,
              size: 60,
            ),
            onPressed: () {
              // Play video action
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem('Overview',
              isSelected: true, onTap: () {}),
          _buildTabItem('Lessons', isSelected: false,
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonsPage(
                  title: title,
                ),
              ),
            );
          }),
          _buildTabItem('Questions', isSelected: false,
              onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuestionsPage(
                  title: title,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }


  Widget _buildTabItem(String title, {required bool isSelected, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
          if (isSelected)
            Container(
              margin: const EdgeInsets.only(top: 4),
              height: 2,
              width: 50,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  Widget _buildCourseTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'CSE413',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
          children: [
            const TextSpan(
              text:
                  'Welcome to the Mobile Application Development course! This course covers mobile platforms (Android, iOS), UX/UI design principles, prototyping, application design, data handling, advanced features, and testing and deployment. ',
            ),
            TextSpan(
              text: 'Read More',
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
              // Add action for "Read More"
              recognizer: null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseDetails() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailItem(Icons.book, '7 Chapters'),
            _buildDetailItem(Icons.menu_book, '2 Books'),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String title) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primary,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSkills() {
    final skills = ['UI/UX', 'App Design', 'Figma', 'XD', 'Animation'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Skills',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) {
              return Chip(
                label: Text(skill),
                backgroundColor: AppColors.secondary,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildStartCourseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Navigate to LessonsPage when START COURSE is pressed
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LessonsPage(
                  title: title,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'START COURSE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
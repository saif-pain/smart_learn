import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';

class LessonsPage extends StatefulWidget {
  final String title;
  
  const LessonsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  final List<bool> _isExpandedList = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.title,
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseBanner(),
            _buildTabBar(),
            const SizedBox(height: 16),
            _buildLessonsList(),
            const SizedBox(height: 16),
            _buildStartCourseButton(),
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
              // Using a placeholder from your assets
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

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTabItem('Overview', isSelected: false, onTap: () {
            Navigator.pop(context);
          }),
          _buildTabItem('Lessons', isSelected: true, onTap: () {}),
          _buildTabItem('Questions', isSelected: false, onTap: () {}),
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

  Widget _buildLessonsList() {
    final lessons = [
      {
        'title': 'Lesson 1: Introduction to Mobile Application Development Tools',
        'content': <String>[
          'Introduction to Mobile Application Design and Development',
          'Overview of mobile platforms (Android, iOS)',
          'Understanding the roles of design and development in mobile app creation',
          'Lecture Slide',
        ],
      },
      {
        'title': 'Lesson 2: User-Centered Design Principle',
        'content': <String>[],
      },
      {
        'title': 'Lesson 3: Prototyping and Wireframing',
        'content': <String>[],
      },
      {
        'title': 'Lesson 4: App Design Process',
        'content': <String>[],
      },
      {
        'title': 'Lesson 5: App Design Process',
        'content': <String>[],
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(lessons.length, (index) {
          return _buildLessonItem(
            title: lessons[index]['title'] as String,
            content: List<String>.from(lessons[index]['content'] as List),
            isExpanded: _isExpandedList[index],
            onExpansionChanged: (isExpanded) {
              setState(() {
                _isExpandedList[index] = isExpanded;
              });
            },
          );
        }),
      ),
    );
  }

  Widget _buildLessonItem({
    required String title,
    required List<String> content,
    required bool isExpanded,
    required ValueChanged<bool> onExpansionChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: content.isNotEmpty
            ? content.map((item) {
                return ListTile(
                  leading: Icon(
                    item == 'Lecture Slide'
                        ? Icons.picture_as_pdf
                        : Icons.play_circle_outline,
                    color: AppColors.primary,
                  ),
                  title: Text(
                    item,
                    style: const TextStyle(fontSize: 14),
                  ),
                  onTap: () {
                    // Handle item click
                  },
                );
              }).toList()
            : [],
        onExpansionChanged: onExpansionChanged,
        initiallyExpanded: isExpanded,
      ),
    );
  }

  Widget _buildStartCourseButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // Start course action
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
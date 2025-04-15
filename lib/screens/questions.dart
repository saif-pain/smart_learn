import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/screens/resources_page.dart';
import 'package:smart_learn/screens/que_page.dart';
import 'package:smart_learn/screens/home_screen.dart';
import 'package:smart_learn/screens/course_details_page.dart'; // Added import for CourseDetailsPage

class QuestionsPage extends StatelessWidget {
  final String title;

  const QuestionsPage({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () {
            // Return to home screen instead of previous screen
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
        title: Text(
          title,
          style:
              const TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCourseBanner(),
            _buildTabBar(context),
            const SizedBox(height: 16),
            _buildQuestionCard(
              title: 'Mid Term Questions',
              subtitle:
                  'Check all previous year Mid-term exam questions.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MidTermQuestionsPage(),
                  ),
                );
                
              },
            ),
            _buildQuestionCard(
              title: 'Final Exam Questions',
              subtitle:
                  'Explore all previous Final exam questions.',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const FinalExamQuestionsPage(),
                  ),
                );
               
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseBanner() {
    String bannerImage = 'assets/images/onboarding1.png';
    
    // Select appropriate banner image based on course title
    if (title.toLowerCase().contains('mobile')) {
      bannerImage = 'assets/images/MAD.png';
    } else if (title.toLowerCase().contains('compiler')) {
      bannerImage = 'assets/images/compiler.png';
    } else if (title.toLowerCase().contains('math')) {
      bannerImage = 'assets/images/mat.png';
    } else if (title.toLowerCase().contains('physics')) {
      bannerImage = 'assets/images/phy.png';
    }
    
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bannerImage),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: IconButton(
            icon: const Icon(Icons.help_outline,
                color: Colors.white, size: 60),
            onPressed: () {
             
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
          _buildTabItem('Overview', isSelected: false,
              onTap: () {
            // Navigate to CourseDetailsPage (Overview) and specify it's not coming from home
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CourseDetailsPage(
                  title: title,
                  fromHome: false, // Specify this navigation is not from home
                ),
              ),
            );
          }),
          _buildTabItem('Resources', isSelected: false,
              onTap: () {
            // Navigate to ResourcesPage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResourcesPage(
                  title: title,
                ),
              ),
            );
          }),
          _buildTabItem('Questions',
              isSelected: true, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title,
      {required bool isSelected,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected
                  ? AppColors.primary
                  : AppColors.textSecondary,
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

  Widget _buildQuestionCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16, vertical: 8),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: const Icon(Icons.article_outlined,
              color: AppColors.primary),
          title: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitle),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }
}

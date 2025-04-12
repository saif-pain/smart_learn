import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';

class MidTermQuestionsPage extends StatelessWidget {
  const MidTermQuestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'title': 'Fpring 2025',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Fall 2025',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Spring 2024',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Fall 2024',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Spring 2023',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Fall 2023',
        'icon': 'assets/images/que.jpg',
      },
      {
        'title': 'Spring 2022',
        'icon': 'assets/images/que.jpg',
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 206, 185, 247),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mid Term Questions',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: items.map((item) {
            return _buildCard(
              title: item['title']!,
              iconPath: item['icon']!,
              onTap: () {
                // Navigate to detailed question screen or show alert
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class MidTermQuestionsPage extends StatelessWidget {
//   const MidTermQuestionsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text(
//           'Mid Term Questions',
//           style: TextStyle(color: AppColors.textPrimary),
//         ),
//       ),
//       body: const Center(
//         child: Text(
//           'List of Mid Term Questions',
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }
// }

class FinalExamQuestionsPage extends StatelessWidget {
  const FinalExamQuestionsPage({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> items = [
      {
        'title': 'Fpring 2025',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Fall 2025',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Spring 2024',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Fall 2024',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Spring 2023',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Fall 2023',
        'icon': 'assets/images/final.png',
      },
      {
        'title': 'Spring 2022',
        'icon': 'assets/images/final.png',
      },
    ];

    return Scaffold(
      backgroundColor:
          const Color.fromARGB(255, 206, 185, 247),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Mid Term Questions',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
          children: items.map((item) {
            return _buildCard(
              title: item['title']!,
              iconPath: item['icon']!,
              onTap: () {
                // Navigate to detailed question screen or show alert
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

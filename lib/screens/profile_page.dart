import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: AppColors.textPrimary),
            onPressed: () {
              // Handle notifications icon action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileSection(),
            const SizedBox(height: 24),
            _buildSettingsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 180,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _WavePainter(),
          ),
        ),
        Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.secondary,
              child: Icon(
                Icons.person,
                size: 50,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'User Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Text(
              'user@example.com',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsList() {
    final settings = [
      {'icon': Icons.person, 'title': 'Edit Profile'},
      {'icon': Icons.check_circle, 'title': 'My Completed Courses'},
      {'icon': Icons.school, 'title': 'My Certificates'},
      {'icon': Icons.menu_book, 'title': 'Academic Results'},
      {'icon': Icons.policy, 'title': 'Terms & Conditions'},
      {'icon': Icons.send, 'title': 'Invite Friends'},
      {'icon': Icons.logout, 'title': 'Logout'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: settings.map((setting) {
          return ListTile(
            leading: Icon(setting['icon'] as IconData, color: AppColors.primary),
            title: Text(
              setting['title'] as String,
              style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary),
            onTap: () {
              // Handle navigation for each setting
            },
          );
        }).toList(),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.8,
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
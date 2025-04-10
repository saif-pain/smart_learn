import 'package:flutter/material.dart';
import 'package:smart_learn/screens/profile_page.dart';

class AccountSettingsPage extends StatelessWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(width: 8),
            // You can replace this with your actual settings icon
            const Icon(Icons.settings, color: Colors.black),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {
              // Handle settings icon action
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
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
            _buildSettingsList(context),
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
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    final settings = [
      {
        'icon': Icons.person, 
        'title': 'Edit Profile',
        'onTap': () {
          // Navigate to Edit Profile page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          );
        }
      },
      {
        'icon': Icons.check_circle, 
        'title': 'My Completed Courses',
        'onTap': () {
          // Handle navigation for completed courses
        }
      },
      {
        'icon': Icons.school, 
        'title': 'My Certificates',
        'onTap': () {
          // Handle navigation for certificates
        }
      },
      {
        'icon': Icons.menu_book, 
        'title': 'Academic Results',
        'onTap': () {
          // Handle navigation for academic results
        }
      },
      {
        'icon': Icons.policy, 
        'title': 'Terms & Conditions',
        'onTap': () {
          // Handle navigation for terms and conditions
        }
      },
      {
        'icon': Icons.send, 
        'title': 'Invite Friends',
        'onTap': () {
          // Handle navigation for invite friends
        }
      },
      {
        'icon': Icons.logout, 
        'title': 'Logout',
        'onTap': () {
          // Handle logout
        }
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: settings.map((setting) {
          return ListTile(
            leading: Icon(setting['icon'] as IconData, color: Colors.blue),
            title: Text(
              setting['title'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onTap: setting['onTap'] as VoidCallback,
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
      ..color = Colors.blue.withOpacity(0.1)
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
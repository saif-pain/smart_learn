import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_learn/core/shared_prefs.dart';
import 'package:smart_learn/screens/login_screen.dart';
import 'package:smart_learn/screens/profile_page.dart';
import 'package:smart_learn/screens/academic_results_page.dart';
import 'package:smart_learn/services/student_service.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({Key? key}) : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final StudentService _studentService = StudentService();
  String _studentName = 'Loading...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudentInfo();
  }

  // Load student information when page initializes
  Future<void> _loadStudentInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final name = await _studentService.getStudentName();

      if (mounted) {
        setState(() {
          _studentName = name;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading student info: $e');
      if (mounted) {
        setState(() {
          _studentName = 'Student';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // Remove the back button as this is a main tab in bottom navigation
        automaticallyImplyLeading: false,
        title: const Text(
          'Profile',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
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
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 8),
            if (_isLoading)
              const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Text(
                _studentName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
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
          // Navigate to Academic Results page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AcademicResultsPage(),
            ),
          );
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
        'onTap': () async {
          // Show confirmation dialog
          bool confirm = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Logout"),
                content: const Text("Are you sure you want to logout?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Logout", style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          ) ?? false;

          if (confirm) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            try {
              // Clear the stored student ID
              await SharedPrefs.clearStudentId();
              
              // Sign out from Firebase
              await FirebaseAuth.instance.signOut();
              
              // Close loading dialog
              Navigator.of(context).pop();
              
              // Navigate to login screen and remove all previous routes
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (Route<dynamic> route) => false,
              );
            } catch (e) {
              // Close loading dialog
              Navigator.of(context).pop();
              
              // Show error
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logout failed: ${e.toString()}")),
              );
            }
          }
        },
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

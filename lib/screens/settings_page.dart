import 'package:flutter/material.dart';
import 'package:smart_learn/services/student_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
      backgroundColor: const Color(
          0xFFE9DED3), // Match the background style
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('SETTINGS',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Profile Header
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 12),
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 24),

            // Personal Info Button
            _buildButtonCard(
              context,
              title: 'Personal info',
              icon: Icons.person,
              onTap: () {},
            ),

            const SizedBox(height: 16),

            // Settings Group 1
            _buildSettingsGroup([
              _buildSettingsItem(
                icon: Icons.security,
                title: 'Password and security',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.download,
                title: 'Downloads',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.palette,
                title: 'Themes',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.notifications,
                title: 'NOtifications',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.privacy_tip,
                title: 'Privacy',
                onTap: () {},
              ),
            ]),

            const SizedBox(height: 16),

            // Settings Group 2
            _buildSettingsGroup([
              _buildSettingsItem(
                icon: Icons.notifications,
                title: 'Notifications',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.help,
                title: 'Help',
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.info,
                title: 'About',
                onTap: () {},
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // Widget for the personal info button
  Widget _buildButtonCard(BuildContext context,
      {required String title,
      required IconData icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey),
            const SizedBox(width: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // Widget for grouped list of tiles
  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(children: children),
    );
  }

  // Each setting tile
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}

import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileImage =
        'assets/images/pp.jpg'; // Replace with actual image

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Profile Header
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImage),
            ),
            const SizedBox(height: 12),
            const Text(
              'Mahfuj',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              'Mahfuj@gmail.com',
              style: TextStyle(color: Colors.grey),
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

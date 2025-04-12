import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildAccountSection(),
          const SizedBox(height: 24),
          _buildSettingsSection(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.settings,
                color: AppColors.primary,
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 36,
            backgroundColor: AppColors.secondary,
            child: Icon(
              Icons.person,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'User',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Personal Info',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: AppColors.primary),
            onPressed: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildSettingsItem(
            icon: Icons.download,
            title: 'Downloads',
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary),
            onTap: () {
              // Navigate to downloads page
            },
          ),
          _buildSettingsItem(
            icon: Icons.palette,
            title: 'Themes',
            trailing: Switch(
              value: false,
              activeColor: AppColors.primary,
              onChanged: (value) {
              },
            ),
          ),
          _buildSettingsItem(
            icon: Icons.notifications,
            title: 'Notifications',
            trailing: Switch(
              value: true,
              activeColor: AppColors.primary,
              onChanged: (value) {
              },
            ),
          ),
          _buildSettingsItem(
            icon: Icons.policy,
            title: 'Privacy Policy',
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary),
            onTap: () {
              // Navigate to privacy policy page
            },
          ),
          _buildSettingsItem(
            icon: Icons.help_outline,
            title: 'Help',
            trailing: const Icon(Icons.arrow_forward_ios, color: AppColors.textSecondary),
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
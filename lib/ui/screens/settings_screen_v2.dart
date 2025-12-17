import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SettingsScreenV2 extends StatefulWidget {
  const SettingsScreenV2({super.key});

  static const String routeName = '/settings-v2';

  @override
  State<SettingsScreenV2> createState() => _SettingsScreenV2State();
}

class _SettingsScreenV2State extends State<SettingsScreenV2> {
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Settings', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            _buildSection('Preferences'),
            _buildSettingTile(
              Icons.volume_up,
              'Sound',
              'Enable quiz sound effects',
              _soundEnabled,
              (value) => setState(() => _soundEnabled = value),
            ),
            _buildSettingTile(
              Icons.vibration,
              'Vibration',
              'Enable haptic feedback',
              _vibrationEnabled,
              (value) => setState(() => _vibrationEnabled = value),
            ),
            _buildSettingTile(
              Icons.notifications,
              'Notifications',
              'Get quiz challenges and updates',
              _notificationsEnabled,
              (value) => setState(() => _notificationsEnabled = value),
            ),
            const SizedBox(height: 8),
            _buildSection('Appearance'),
            _buildNavigationTile(Icons.palette, 'Theme', 'Customize app appearance', () => Navigator.pushNamed(context, '/language-theme-selection')),
            _buildNavigationTile(Icons.language, 'Language', 'Change app language', () {}),
            const SizedBox(height: 8),
            _buildSection('Account'),
            _buildNavigationTile(Icons.person, 'Edit Profile', 'Update your information', () => Navigator.pushNamed(context, '/edit-profile-v2')),
            _buildNavigationTile(Icons.lock, 'Change Password', 'Update your password', () {}),
            _buildNavigationTile(Icons.delete, 'Delete Account', 'Permanently delete account', () {}, isDestructive: true),
            const SizedBox(height: 8),
            _buildSection('Support'),
            _buildNavigationTile(Icons.help, 'Help & Support', 'Get help and FAQs', () {}),
            _buildNavigationTile(Icons.privacy_tip, 'Privacy Policy', 'Read our privacy policy', () {}),
            _buildNavigationTile(Icons.description, 'Terms of Service', 'Read terms and conditions', () {}),
            _buildNavigationTile(Icons.info, 'About', 'App version and info', () {}),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IbeereButton(
                text: 'Logout',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Logout'),
                      content: Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamedAndRemoveUntil(context, '/phone-login', (route) => false);
                          },
                          child: Text('Logout', style: TextStyle(color: IbeereDesignTokens.primaryRed)),
                        ),
                      ],
                    ),
                  );
                },
                variant: IbeereButtonVariant.outlined,
                icon: Icons.logout,
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle, bool value, Function(bool) onChanged) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(title, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: IbeereDesignTokens.primaryPurple, size: 20),
        ),
        activeColor: IbeereDesignTokens.primaryPurple,
      ),
    );
  }

  Widget _buildNavigationTile(IconData icon, String title, String subtitle, VoidCallback onTap, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDestructive ? IbeereDesignTokens.primaryRed.withOpacity(0.1) : IbeereDesignTokens.primaryPurple.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: isDestructive ? IbeereDesignTokens.primaryRed : IbeereDesignTokens.primaryPurple, size: 20),
        ),
        title: Text(title, style: TextStyle(color: isDestructive ? IbeereDesignTokens.primaryRed : IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
        trailing: Icon(Icons.chevron_right, color: IbeereDesignTokens.textSecondary),
      ),
    );
  }
}

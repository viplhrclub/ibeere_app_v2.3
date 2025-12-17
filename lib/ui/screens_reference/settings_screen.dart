import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_inputs.dart';
import '../widgets/ibeere_navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _soundEnabled = true;
  String _selectedLanguage = 'English';
  bool _analyticsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Settings',
        centerTitle: false,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Notification Settings
            _SettingsSection(
              title: 'Notifications',
              children: [
                _SettingsToggle(
                  icon: Icons.notifications,
                  title: 'Push Notifications',
                  subtitle: 'Get notified about new quizzes',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() => _notificationsEnabled = value);
                  },
                ),
                _SettingsToggle(
                  icon: Icons.volume_up,
                  title: 'Sound Effects',
                  subtitle: 'Play sounds on actions',
                  value: _soundEnabled,
                  onChanged: (value) {
                    setState(() => _soundEnabled = value);
                  },
                ),
              ],
            ),

            // Display Settings
            _SettingsSection(
              title: 'Display',
              children: [
                _SettingsToggle(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  subtitle: 'Enable dark theme',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() => _darkModeEnabled = value);
                  },
                ),
                _SettingsDropdown(
                  icon: Icons.language,
                  title: 'Language',
                  value: _selectedLanguage,
                  items: ['English', 'Spanish', 'French', 'German', 'Arabic'],
                  onChanged: (value) {
                    setState(() => _selectedLanguage = value);
                  },
                ),
              ],
            ),

            // Privacy & Security
            _SettingsSection(
              title: 'Privacy & Security',
              children: [
                _SettingsTile(
                  icon: Icons.lock,
                  title: 'Change Password',
                  subtitle: 'Update your password',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.privacy_tip,
                  title: 'Privacy Policy',
                  subtitle: 'Read our privacy policy',
                  onTap: () {},
                ),
                _SettingsToggle(
                  icon: Icons.analytics,
                  title: 'Share Analytics',
                  subtitle: 'Help improve the app',
                  value: _analyticsEnabled,
                  onChanged: (value) {
                    setState(() => _analyticsEnabled = value);
                  },
                ),
              ],
            ),

            // About
            _SettingsSection(
              title: 'About',
              children: [
                _SettingsTile(
                  icon: Icons.info,
                  title: 'About Ibeere',
                  subtitle: 'Learn about the app',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.help,
                  title: 'Help & Support',
                  subtitle: 'Get help and FAQs',
                  onTap: () {},
                ),
                _SettingsTile(
                  icon: Icons.bug_report,
                  title: 'Report Bug',
                  subtitle: 'Report a problem',
                  onTap: () {},
                ),
                Padding(
                  padding: EdgeInsets.all(DesignTokens.spaceLg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'App Version',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightMedium,
                        ),
                      ),
                      SizedBox(height: DesignTokens.spaceSm),
                      Text(
                        'v1.0.0',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Logout
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: IbeereSecondaryButton(
                label: 'Logout',
                isFullWidth: true,
                textColor: DesignTokens.error,
                borderColor: DesignTokens.error,
                onPressed: () {
                  _showLogoutDialog();
                },
              ),
            ),
            SizedBox(height: DesignTokens.spaceLg),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog() {
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
              // Perform logout
            },
            child: Text(
              'Logout',
              style: TextStyle(color: DesignTokens.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            DesignTokens.spaceLg,
            DesignTokens.spaceLg,
            DesignTokens.spaceLg,
            DesignTokens.spaceMd,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.primary,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceMd),
          child: Row(
            children: [
              Icon(icon, color: DesignTokens.primary),
              SizedBox(width: DesignTokens.spaceLg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final Function(bool) onChanged;

  const _SettingsToggle({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceMd),
        child: Row(
          children: [
            Icon(icon, color: DesignTokens.primary),
            SizedBox(width: DesignTokens.spaceLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: DesignTokens.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsDropdown extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final List<String> items;
  final Function(String) onChanged;

  const _SettingsDropdown({
    required this.icon,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceMd),
        child: Row(
          children: [
            Icon(icon, color: DesignTokens.primary),
            SizedBox(width: DesignTokens.spaceLg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightMedium,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceSm),
                  DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    underline: SizedBox.shrink(),
                    items: items
                        .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                        .toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        onChanged(newValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

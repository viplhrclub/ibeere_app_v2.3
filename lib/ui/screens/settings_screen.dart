import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _darkModeEnabled = true;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _revealController.forward();
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _revealController,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            _SettingsSection(
              title: 'Preferences',
              children: [
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  title: 'Notifications',
                  subtitle: 'Receive quiz and achievement alerts',
                  trailing: Switch(
                    value: _notificationsEnabled,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6C63FF),
                  ),
                ),
                _SettingsTile(
                  icon: Icons.volume_up_outlined,
                  title: 'Sound Effects',
                  subtitle: 'Enable audio feedback',
                  trailing: Switch(
                    value: _soundEnabled,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _soundEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6C63FF),
                  ),
                ),
                _SettingsTile(
                  icon: Icons.vibration,
                  title: 'Vibration',
                  subtitle: 'Haptic feedback on interactions',
                  trailing: Switch(
                    value: _vibrationEnabled,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _vibrationEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6C63FF),
                  ),
                ),
                _SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: 'Dark Mode',
                  subtitle: 'Use dark theme',
                  trailing: Switch(
                    value: _darkModeEnabled,
                    onChanged: (value) {
                      HapticFeedback.lightImpact();
                      setState(() {
                        _darkModeEnabled = value;
                      });
                    },
                    activeColor: const Color(0xFF6C63FF),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'Account',
              children: [
                _SettingsTile(
                  icon: Icons.person_outline,
                  title: 'Edit Profile',
                  subtitle: 'Update your information',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pushNamed(context, '/editProfile');
                  },
                ),
                _SettingsTile(
                  icon: Icons.language,
                  title: 'Language',
                  subtitle: 'English',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pushNamed(context, '/language-select');
                  },
                ),
                _SettingsTile(
                  icon: Icons.lock_outline,
                  title: 'Privacy',
                  subtitle: 'Manage your privacy settings',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            _SettingsSection(
              title: 'Support',
              children: [
                _SettingsTile(
                  icon: Icons.help_outline,
                  title: 'Help & FAQ',
                  subtitle: 'Get help and answers',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                ),
                _SettingsTile(
                  icon: Icons.feedback_outlined,
                  title: 'Send Feedback',
                  subtitle: 'Share your thoughts',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                  },
                ),
                _SettingsTile(
                  icon: Icons.info_outline,
                  title: 'About',
                  subtitle: 'Version 2.3.7',
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Navigator.pushNamed(context, '/aboutApp');
                  },
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  HapticFeedback.mediumImpact();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: const Color(0xFF252542),
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(color: Colors.white70),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(context, '/login');
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
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
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF6C63FF),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (onTap != null)
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white.withOpacity(0.5),
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

/// Profile Screen for Ibeere
/// 
/// User profile with stats, achievements, and settings
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _editMode = false;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Anderson');
    _emailController = TextEditingController(text: 'john.anderson@email.com');
    _bioController = TextEditingController(text: 'Quiz enthusiast and lifelong learner');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Profile',
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(
              _editMode ? Icons.check : Icons.edit,
              color: DesignTokens.primary,
            ),
            onPressed: () {
              setState(() {
                _editMode = !_editMode;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section with Avatar
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF007AFF).withValues(alpha: 0.15),
                    DesignTokens.background,
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: const Color(0xFF007AFF),
                        child: const Text(
                          'JA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      if (_editMode)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color(0xFF007AFF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (!_editMode) ...[
                    Text(
                      _nameController.text,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _emailController.text,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _bioController.text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ] else ...[
                    const SizedBox(height: 24),
                  ],
                ],
              ),
            ),

            if (_editMode)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceMd),
                    TextField(
                      controller: _bioController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceXl),
                  ],
                ),
              ),

            // Stats Section
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: DesignTokens.spaceMd,
                    mainAxisSpacing: DesignTokens.spaceMd,
                    childAspectRatio: 1.2,
                    children: [
                      _StatTile(
                        label: 'Total Quizzes',
                        value: '24',
                        icon: Icons.quiz,
                        color: DesignTokens.primary,
                      ),
                      _StatTile(
                        label: 'Current Streak',
                        value: '12',
                        icon: Icons.local_fire_department,
                        color: DesignTokens.error,
                      ),
                      _StatTile(
                        label: 'Total Points',
                        value: '2,340',
                        icon: Icons.star,
                        color: DesignTokens.warning,
                      ),
                      _StatTile(
                        label: 'Rank',
                        value: '#42',
                        icon: Icons.trending_up,
                        color: DesignTokens.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Achievements Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Achievements',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _AchievementIcon(
                        emoji: '🏆',
                        label: 'Champion',
                      ),
                      _AchievementIcon(
                        emoji: '⭐',
                        label: 'Perfect',
                      ),
                      _AchievementIcon(
                        emoji: '🔥',
                        label: 'On Fire',
                      ),
                      _AchievementIcon(
                        emoji: '🎖️',
                        label: 'Expert',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            // Settings Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  _SettingsTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.language,
                    title: 'Language',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.help,
                    title: 'Help & Support',
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: Icons.info,
                    title: 'About App',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: IbeereSecondaryButton(
                label: 'Logout',
                isFullWidth: true,
                textColor: DesignTokens.error,
                borderColor: DesignTokens.error,
                onPressed: () {
                  _showLogoutDialog(context);
                },
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
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

/// Stat Tile Widget
class _StatTile extends StatelessWidget {

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: color.withOpacity(0.5),
      elevation: 1,
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXl,
              fontWeight: DesignTokens.fontWeightBold,
              color: color,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceSm),
          Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeSm,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Achievement Icon Widget
class _AchievementIcon extends StatelessWidget {

  const _AchievementIcon({
    required this.emoji,
    required this.label,
  });
  final String emoji;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 28)),
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        Text(
          label,
          style: const TextStyle(
            fontSize: DesignTokens.fontSizeSm,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
      ],
    );
  }
}

/// Settings Tile Widget
class _SettingsTile extends StatelessWidget {

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: DesignTokens.surface,
      borderColor: Colors.grey[300],
      padding: const EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceMd,
        vertical: DesignTokens.spaceMd,
      ),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: DesignTokens.primary),
              const SizedBox(width: DesignTokens.spaceMd),
              Text(
                title,
                style: const TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  fontWeight: DesignTokens.fontWeightMedium,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey[400],
          ),
        ],
      ),
    );
  }
}





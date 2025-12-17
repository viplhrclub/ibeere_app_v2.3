import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_navigation.dart';

/// Profile Screen for Ibeere
/// 
/// User profile with stats, achievements, and settings
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
        centerTitle: false,
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
                    DesignTokens.primary.withOpacity(0.1),
                    DesignTokens.background,
                  ],
                ),
              ),
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                children: [
                  SizedBox(height: DesignTokens.spaceLg),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: DesignTokens.primary,
                        child: Text(
                          'JA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DesignTokens.fontSizeXxxl,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ),
                      if (_editMode)
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: DesignTokens.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: DesignTokens.spaceLg),
                  if (!_editMode) ...[
                    Text(
                      _nameController.text,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeXl,
                        fontWeight: DesignTokens.fontWeightBold,
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      _emailController.text,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    Text(
                      _bioController.text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[700],
                      ),
                    ),
                  ] else ...[
                    SizedBox(height: DesignTokens.spaceXl),
                  ],
                ],
              ),
            ),

            if (_editMode)
              Padding(
                padding: EdgeInsets.all(DesignTokens.spaceLg),
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                      ),
                    ),
                    SizedBox(height: DesignTokens.spaceMd),
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
                    SizedBox(height: DesignTokens.spaceXl),
                  ],
                ),
              ),

            // Stats Section
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Statistics',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
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
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Achievements',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
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
            SizedBox(height: DesignTokens.spaceXl),

            // Settings Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Account Settings',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
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
            SizedBox(height: DesignTokens.spaceXl),

            // Logout Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: DesignTokens.spaceLg),
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
            SizedBox(height: DesignTokens.spaceXl),
          ],
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
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

/// Stat Tile Widget
class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: color.withOpacity(0.1),
      elevation: 1,
      padding: EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          SizedBox(height: DesignTokens.spaceSm),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXl,
              fontWeight: DesignTokens.fontWeightBold,
              color: color,
            ),
          ),
          SizedBox(height: DesignTokens.spaceSm),
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
  final String emoji;
  final String label;

  const _AchievementIcon({
    required this.emoji,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: TextStyle(fontSize: 28)),
        ),
        SizedBox(height: DesignTokens.spaceSm),
        Text(
          label,
          style: TextStyle(
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
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: DesignTokens.surface,
      elevation: 0,
      borderColor: Colors.grey[300],
      padding: EdgeInsets.symmetric(
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
              SizedBox(width: DesignTokens.spaceMd),
              Text(
                title,
                style: TextStyle(
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

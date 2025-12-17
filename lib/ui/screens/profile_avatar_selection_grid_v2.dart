import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class ProfileAvatarSelectionGridV2 extends StatefulWidget {
  const ProfileAvatarSelectionGridV2({super.key});

  @override
  State<ProfileAvatarSelectionGridV2> createState() => _ProfileAvatarSelectionGridV2State();
}

class _ProfileAvatarSelectionGridV2State extends State<ProfileAvatarSelectionGridV2> {
  int _selectedAvatar = 0;

  final List<Map<String, dynamic>> _avatars = [
    {'icon': Icons.person, 'color': Color(0xFFEC4899)},
    {'icon': Icons.face, 'color': Color(0xFF6366F1)},
    {'icon': Icons.account_circle, 'color': Color(0xFF10B981)},
    {'icon': Icons.mood, 'color': Color(0xFFFBBF24)},
    {'icon': Icons.sentiment_satisfied, 'color': Color(0xFFEF4444)},
    {'icon': Icons.person_outline, 'color': Color(0xFF06B6D4)},
    {'icon': Icons.face_outlined, 'color': Color(0xFF8B5CF6)},
    {'icon': Icons.supervised_user_circle, 'color': Color(0xFFF97316)},
    {'icon': Icons.account_box, 'color': Color(0xFF14B8A6)},
    {'icon': Icons.badge, 'color': Color(0xFFF59E0B)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Your Avatar',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select an avatar to personalize your profile',
                style: TextStyle(
                  fontSize: 16,
                  color: IbeereDesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: _avatars.length,
                  itemBuilder: (context, index) {
                    final avatar = _avatars[index];
                    final isSelected = _selectedAvatar == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatar = index;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? IbeereDesignTokens.primaryPurple
                                : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: IbeereDesignTokens.primaryPurple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ),
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    avatar['color'],
                                    avatar['color'].withOpacity(0.7),
                                  ],
                                ),
                              ),
                              child: Icon(
                                avatar['icon'],
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile-name-input');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IbeereDesignTokens.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

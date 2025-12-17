import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class SignUpProfileScreen extends StatefulWidget {
  const SignUpProfileScreen({super.key});

  static const String routeName = '/sign-up-profile';

  @override
  State<SignUpProfileScreen> createState() => _SignUpProfileScreenState();
}

class _SignUpProfileScreenState extends State<SignUpProfileScreen> {
  final _nameController = TextEditingController();
  final _referralController = TextEditingController();
  int _selectedAvatar = 0;
  bool _hasReferralCode = false;

  final List<Color> _avatarColors = [
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFF3B82F6),
    Color(0xFF8B5CF6),
    Color(0xFFEF4444),
    Color(0xFF06B6D4),
    Color(0xFFFBBF24),
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned(top: 40, right: -20, child: _DecorativeCircle(color: IbeereDesignTokens.decorativePink.withOpacity(0.3), size: 100)),
          Positioned(bottom: 120, left: -30, child: _DecorativeCircle(color: IbeereDesignTokens.decorativeYellow.withOpacity(0.3), size: 120)),
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Complete Your Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: IbeereDesignTokens.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Choose an avatar and enter your name',
                  style: TextStyle(
                    fontSize: 16,
                    color: IbeereDesignTokens.textSecondary,
                  ),
                ),
                const SizedBox(height: 32),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: IbeereDesignTokens.primaryPurple.withOpacity(0.2), width: 2),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
                    ),
                    child: Column(
                      children: [
                        Icon(Icons.add_photo_alternate, size: 32, color: IbeereDesignTokens.primaryPurple),
                        const SizedBox(height: 8),
                        Text(
                          'Choose image from Gallery',
                          style: TextStyle(color: IbeereDesignTokens.primaryPurple, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Or select an avatar',
                  style: TextStyle(fontSize: 14, color: IbeereDesignTokens.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedAvatar == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedAvatar = index),
                      child: Container(
                        decoration: BoxDecoration(
                          color: _avatarColors[index].withOpacity(0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? IbeereDesignTokens.primaryPurple : Colors.transparent,
                            width: 3,
                          ),
                          boxShadow: isSelected ? [BoxShadow(color: IbeereDesignTokens.primaryPurple.withOpacity(0.3), blurRadius: 8, offset: Offset(0, 4))] : [],
                        ),
                        child: Icon(Icons.person, size: 32, color: _avatarColors[index]),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    prefixIcon: Icon(Icons.person_outline, color: IbeereDesignTokens.primaryPurple),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(color: IbeereDesignTokens.primaryPurple, width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'I have an invitation Code',
                      style: TextStyle(fontSize: 14, color: IbeereDesignTokens.textPrimary, fontWeight: FontWeight.w500),
                    ),
                    Switch(
                      value: _hasReferralCode,
                      onChanged: (value) => setState(() => _hasReferralCode = value),
                      activeColor: IbeereDesignTokens.primaryPurple,
                    ),
                  ],
                ),
                if (_hasReferralCode) ...[
                  const SizedBox(height: 16),
                  TextField(
                    controller: _referralController,
                    decoration: InputDecoration(
                      hintText: 'Enter referral code',
                      prefixIcon: Icon(Icons.card_giftcard, color: IbeereDesignTokens.primaryPurple),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Color(0xFFE2E8F0), width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: IbeereDesignTokens.primaryPurple, width: 2),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 32),
                IbeereButton(
                  text: 'Continue',
                  onPressed: () => Navigator.pushNamed(context, '/home'),
                  icon: Icons.arrow_forward,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeCircle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  static const String routeName = '/edit-profile';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController(text: 'John Doe');
  final _emailController = TextEditingController(text: 'john.doe@example.com');
  final _phoneController = TextEditingController(text: '+229 12345678');
  int _selectedAvatar = 0;

  final List<Color> _avatarColors = [
    IbeereDesignTokens.primaryPurple,
    IbeereDesignTokens.primaryPink,
    IbeereDesignTokens.accentGreen,
    IbeereDesignTokens.accentYellow,
    IbeereDesignTokens.accentCyan,
    Color(0xFFF59E0B),
    Color(0xFF8B5CF6),
    IbeereDesignTokens.primaryRed,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

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
        title: Text('Edit Profile', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, size: 50, color: IbeereDesignTokens.primaryPurple),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.primaryPurple,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Icon(Icons.camera_alt, color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Choose Avatar', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 12),
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
                    ),
                    child: Icon(Icons.person, size: 32, color: _avatarColors[index]),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
            _buildTextField('Full Name', _nameController, Icons.person_outline),
            const SizedBox(height: 16),
            _buildTextField('Email Address', _emailController, Icons.email_outlined),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', _phoneController, Icons.phone_outlined),
            const SizedBox(height: 32),
            IbeereButton(
              text: 'Save Changes',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Profile updated successfully!')),
                );
                Navigator.pop(context);
              },
              icon: Icons.check,
            ),
            const SizedBox(height: 12),
            IbeereButton(
              text: 'Cancel',
              onPressed: () => Navigator.pop(context),
              variant: IbeereButtonVariant.outlined,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: IbeereDesignTokens.textPrimary)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: IbeereDesignTokens.primaryPurple),
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
    );
  }
}

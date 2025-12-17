import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_inputs.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;
  late TextEditingController _locationController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'John Doe');
    _emailController = TextEditingController(text: 'john@example.com');
    _bioController = TextEditingController(text: 'Quiz enthusiast and lifelong learner');
    _locationController = TextEditingController(text: 'New York, USA');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: DesignTokens.primary,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person_rounded,
                        color: Colors.grey[600],
                        size: 60,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Camera/Gallery action'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: DesignTokens.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Form Fields
            IbeereTextInput(
              label: 'Full Name',
              controller: _nameController,
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            IbeereTextInput(
              label: 'Email Address',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            IbeereTextInput(
              label: 'Location',
              controller: _locationController,
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            Text(
              'Bio',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                fontWeight: DesignTokens.fontWeightSemibold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceSm),
            TextField(
              controller: _bioController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tell us about yourself',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                  borderSide: BorderSide(color: DesignTokens.primary, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Save Button
            IbeerePrimaryButton(
              label: 'Save Changes',
              isFullWidth: true,
              isLoading: _isLoading,
              onPressed: _saveProfile,
            ),
          ],
        ),
      ),
    );
  }
}


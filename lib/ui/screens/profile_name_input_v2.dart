import 'package:flutter/material.dart';

class ProfileNameInput extends StatefulWidget {
  const ProfileNameInput({super.key});

  @override
  State<ProfileNameInput> createState() => _ProfileNameInputState();
}

class _ProfileNameInputState extends State<ProfileNameInput> {
  final TextEditingController _nameController = TextEditingController(text: 'fawazgladi...');

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFF8F9FE),
              Color(0xFFEEF2FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildTopBar(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      _buildAvatarSection(),
                      const SizedBox(height: 48),
                      _buildForm(),
                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF4A5F7F)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF6B7FA8),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Column(
      children: [
        Container(
          width: 140,
          height: 140,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF7C3AED).withOpacity(0.1),
                const Color(0xFF5B21B6).withOpacity(0.1),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF7C3AED).withOpacity(0.3),
              width: 3,
            ),
          ),
          child: const Icon(
            Icons.person,
            size: 80,
            color: Color(0xFF7C3AED),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Upload Profile Picture',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4A5F7F),
          ),
        ),
        const SizedBox(height: 8),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.camera_alt, size: 20),
          label: const Text('Choose Photo'),
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF7C3AED),
          ),
        ),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputField(
          label: 'Username',
          icon: Icons.person_outline,
          controller: _nameController,
          hint: 'Enter your username',
        ),
        const SizedBox(height: 24),
        _buildInputField(
          label: 'Email',
          icon: Icons.email_outlined,
          hint: 'Enter your email',
        ),
        const SizedBox(height: 24),
        _buildInputField(
          label: 'Phone Number',
          icon: Icons.phone_outlined,
          hint: 'Enter your phone number',
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Icon(Icons.card_giftcard, color: Color(0xFF7C3AED), size: 20),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'I have an invitation Code',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF4A5F7F),
                ),
              ),
            ),
            Switch(
              value: false,
              onChanged: (value) {},
              activeColor: const Color(0xFF7C3AED),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF7C3AED).withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: const Text(
              'OZ595393',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF4A5F7F),
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required IconData icon,
    String? hint,
    TextEditingController? controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF6B7FA8),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: const Color(0xFF7C3AED)),
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFF6B7FA8).withOpacity(0.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
          ],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF7C3AED),
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.play_arrow, size: 24),
                SizedBox(width: 12),
                Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

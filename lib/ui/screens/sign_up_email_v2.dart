import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class SignUpEmailV2 extends StatefulWidget {
  const SignUpEmailV2({super.key});

  @override
  State<SignUpEmailV2> createState() => _SignUpEmailV2State();
}

class _SignUpEmailV2State extends State<SignUpEmailV2> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Stack(
        children: [
          _buildDecorativeShapes(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5B6B7E),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We will be very happy to welcome you to the\nfamily ! A few more seconds and it\'s Ok !',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF9CA3AF),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  _buildLogoSection(),
                  const SizedBox(height: 56),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Your email address here',
                    icon: Icons.person_outline_rounded,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    controller: _passwordController,
                    hintText: 'Your Password here',
                    icon: Icons.lock_outline_rounded,
                    isPassword: true,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/sign-in-email'),
                        child: RichText(
                          text: TextSpan(
                            text: "Already have an account ? ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9CA3AF),
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                  color: Color(0xFF6B7280),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, '/forgot-password'),
                        child: Text(
                          'Password forgot ?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By SignUp, you agree to your\n',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF9CA3AF),
                          height: 1.6,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of services',
                            style: TextStyle(
                              color: Color(0xFFDC2626),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: ' & '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: Color(0xFFDC2626),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Center(
                    child: Text(
                      'You can connect faster with',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton(isGoogle: true),
                      const SizedBox(width: 32),
                      _buildSocialButton(isGoogle: false),
                    ],
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: _buildFloatingButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFE8E8F0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          Positioned(
            top: -15,
            left: 20,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Color(0xFF6366F1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 30,
            child: Icon(
              Icons.play_arrow_rounded,
              color: Color(0xFF1F2937),
              size: 16,
            ),
          ),
          Positioned(
            bottom: -8,
            right: 25,
            child: Icon(
              Icons.circle,
              color: Color(0xFF9333EA),
              size: 10,
            ),
          ),
          Positioned(
            top: 8,
            right: 50,
            child: Transform.rotate(
              angle: 0.6,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1F2937), width: 1.5),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'ibeere',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                  letterSpacing: -1,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Games',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 16,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF9CA3AF), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && _obscurePassword,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFBBBEC4),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Color(0xFF9CA3AF),
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({required bool isGoogle}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFE5E7EB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        isGoogle ? Icons.g_mobiledata_rounded : Icons.phone_iphone_rounded,
        color: isGoogle ? Color(0xFF4285F4) : Color(0xFF6B7280),
        size: isGoogle ? 36 : 26,
      ),
    );
  }

  Widget _buildFloatingButton() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEF4444),
            Color(0xFFDC2626),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEF4444).withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/profile-avatar'),
          borderRadius: BorderRadius.circular(34),
          child: Center(
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeShapes() {
    return Stack(
      children: [
        Positioned(top: 15, left: 20, child: _buildCircle(Color(0xFFFFD6D6), 28)),
        Positioned(top: 45, left: 80, child: _buildCircle(Color(0xFFFFF4CC), 18, outlined: true)),
        Positioned(top: 20, left: 160, child: _buildCircle(Color(0xFFD1FAE5), 14, outlined: true)),
        Positioned(top: 15, right: 80, child: _buildDiamond(Color(0xFF94A3B8), 14)),
        Positioned(top: 12, right: 20, child: _buildCircle(Color(0xFFD1FAE5), 20)),
        Positioned(top: 80, right: 25, child: _buildDiamond(Color(0xFF94A3B8), 18)),
        Positioned(top: 100, right: 100, child: _buildCircle(Color(0xFFFFF4CC), 22)),
        Positioned(top: -40, left: -60, child: _buildBlob(Color(0xFFFFE5E5), 180, 160)),
        Positioned(top: 150, right: -70, child: _buildBlob(Color(0xFFDEF7EC), 160, 200)),
        Positioned(bottom: 300, left: -30, child: _buildBlob(Color(0xFFFFF8DC), 120, 140)),
        Positioned(bottom: 100, left: 30, child: _buildCircle(Color(0xFFFFF4CC), 16)),
        Positioned(bottom: 200, left: 80, child: _buildDiamond(Color(0xFF94A3B8), 14)),
        Positioned(bottom: 140, left: 100, child: _buildCircle(Color(0xFFD1FAE5), 18)),
        Positioned(bottom: 280, right: 60, child: _buildCircle(Color(0xFFD1D5DB), 14, outlined: true)),
        Positioned(bottom: 190, right: 100, child: _buildTriangle(Color(0xFF7DD3FC), 16)),
        Positioned(bottom: 120, right: 30, child: _buildCircle(Color(0xFFFED7AA), 20)),
        Positioned(bottom: 240, right: 40, child: _buildCircle(Color(0xFFFFD6D6), 24, outlined: true)),
        Positioned(bottom: -60, right: -70, child: _buildBlob(Color(0xFFDEF7EC), 180, 190)),
        Positioned(bottom: -50, left: -60, child: _buildBlob(Color(0xFFFFE5E5), 170, 150)),
      ],
    );
  }

  Widget _buildLogoSection() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              color: Color(0xFFE8E8F0).withOpacity(0.5),
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          Positioned(
            top: -15,
            left: 20,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: Color(0xFF6366F1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 30,
            child: Icon(
              Icons.play_arrow_rounded,
              color: Color(0xFF1F2937),
              size: 16,
            ),
          ),
          Positioned(
            bottom: -8,
            right: 25,
            child: Icon(
              Icons.circle,
              color: Color(0xFF9333EA),
              size: 10,
            ),
          ),
          Positioned(
            top: 8,
            right: 50,
            child: Transform.rotate(
              angle: 0.6,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF1F2937), width: 1.5),
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                'ibeere',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6366F1),
                  letterSpacing: -1,
                  height: 1,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 16,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Games',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1F2937),
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 16,
                    height: 2,
                    decoration: BoxDecoration(
                      color: Color(0xFF1F2937),
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, color: Color(0xFF9CA3AF), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword && _obscurePassword,
              keyboardType: keyboardType,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFBBBEC4),
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (isPassword)
            IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Color(0xFF9CA3AF),
                size: 20,
              ),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
            ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({required bool isGoogle}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: Color(0xFFE5E7EB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        isGoogle ? Icons.g_mobiledata_rounded : Icons.phone_iphone_rounded,
        color: isGoogle ? Color(0xFF4285F4) : Color(0xFF6B7280),
        size: isGoogle ? 36 : 26,
      ),
    );
  }

  Widget _buildFloatingButton() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEF4444),
            Color(0xFFDC2626),
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEF4444).withOpacity(0.4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/profile-avatar'),
          borderRadius: BorderRadius.circular(34),
          child: Center(
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircle(Color color, double size, {bool outlined = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: outlined ? Colors.transparent : color.withOpacity(0.5),
        shape: BoxShape.circle,
        border: outlined ? Border.all(color: color.withOpacity(0.4), width: 2) : null,
      ),
    );
  }

  Widget _buildDiamond(Color color, double size) {
    return Transform.rotate(
      angle: 0.785398,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    );
  }

  Widget _buildTriangle(Color color, double size) {
    return Transform.rotate(
      angle: -0.785398,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color.withOpacity(0.4),
        ),
      ),
    );
  }

  Widget _buildBlob(Color color, double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(height * 0.7),
          topRight: Radius.circular(height * 0.3),
          bottomLeft: Radius.circular(height * 0.4),
          bottomRight: Radius.circular(height * 0.6),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_inputs.dart';

/// Sign In Screen for Ibeere
/// 
/// User login screen with email/password fields
/// Includes forgot password and sign up navigation
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    var isValid = true;
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    if (_emailController.text.isEmpty) {
      setState(() {
        _emailError = 'Email is required';
      });
      isValid = false;
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() {
        _emailError = 'Enter a valid email address';
      });
      isValid = false;
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      isValid = false;
    } else if (_passwordController.text.length < 6) {
      setState(() {
        _passwordError = 'Password must be at least 6 characters';
      });
      isValid = false;
    }

    return isValid;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  void _handleSignIn() {
    if (_validateForm()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Navigate to home screen
        // Navigator.of(context).pushReplacementNamed('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: DesignTokens.spaceXl),
              
            // Header
            Text(
              'Welcome Back',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF007AFF),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to your account to continue',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF6B7280),
              ),
            ),
            const SizedBox(height: 32),

              // Email Input
              IbeereTextInput(
                label: 'Email Address',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                errorText: _emailError,
                isRequired: true,
                onChanged: (value) {
                  setState(() {
                    _emailError = null;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Password Input
              IbeereTextInput(
                label: 'Password',
                hintText: 'Enter your password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outlined,
                obscureText: true,
                errorText: _passwordError,
                isRequired: true,
                onChanged: (value) {
                  setState(() {
                    _passwordError = null;
                  });
                },
              ),
              const SizedBox(height: DesignTokens.spaceMd),

              // Remember Me & Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IbeereCheckbox(
                    value: _rememberMe,
                    label: 'Remember me',
                    onChanged: (value) {
                      setState(() {
                        _rememberMe = value ?? false;
                      });
                    },
                  ),
                  IbeereTextButton(
                    label: 'Forgot Password?',
                    onPressed: () {
                      // Navigate to forgot password screen
                    },
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spaceXxl),

              // Sign In Button
              IbeerePrimaryButton(
                label: 'Sign In',
                isFullWidth: true,
                isLoading: _isLoading,
                onPressed: _handleSignIn,
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey[300])),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: DesignTokens.spaceMd),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey[300])),
                ],
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Social Login Buttons
              Row(
                children: [
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.g_mobiledata,
                      label: 'Google',
                      onPressed: () {
                        // Google login
                      },
                    ),
                  ),
                  const SizedBox(width: DesignTokens.spaceMd),
                  Expanded(
                    child: _SocialButton(
                      icon: Icons.facebook,
                      label: 'Facebook',
                      onPressed: () {
                        // Facebook login
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DesignTokens.spaceXxl),

              // Sign Up Link
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: DesignTokens.fontSizeBase,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: DesignTokens.primary,
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to sign up screen
                          },
                      ),
                    ],
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

/// Social Login Button Helper
class _SocialButton extends StatelessWidget {

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: DesignTokens.spaceMd,
        ),
        side: BorderSide(
          color: Colors.grey[300] ?? Colors.grey,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: DesignTokens.primary, size: 20),
          const SizedBox(width: DesignTokens.spaceSm),
          Text(
            label,
            style: TextStyle(
              color: DesignTokens.primary,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
        ],
      ),
    );
  }
}


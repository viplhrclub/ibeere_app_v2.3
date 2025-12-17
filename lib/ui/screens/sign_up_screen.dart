import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_inputs.dart';

/// Sign Up Screen for Ibeere
/// 
/// User registration screen with comprehensive form
/// Includes name, email, password, and terms acceptance
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  
  bool _agreeToTerms = false;
  bool _isLoading = false;
  
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _termsError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    var isValid = true;
    setState(() {
      _nameError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
      _termsError = null;
    });

    // Name validation
    if (_nameController.text.isEmpty) {
      setState(() => _nameError = 'Name is required');
      isValid = false;
    } else if (_nameController.text.length < 3) {
      setState(() => _nameError = 'Name must be at least 3 characters');
      isValid = false;
    }

    // Email validation
    if (_emailController.text.isEmpty) {
      setState(() => _emailError = 'Email is required');
      isValid = false;
    } else if (!_isValidEmail(_emailController.text)) {
      setState(() => _emailError = 'Enter a valid email address');
      isValid = false;
    }

    // Password validation
    if (_passwordController.text.isEmpty) {
      setState(() => _passwordError = 'Password is required');
      isValid = false;
    } else if (_passwordController.text.length < 8) {
      setState(() => _passwordError = 'Password must be at least 8 characters');
      isValid = false;
    } else if (!_isStrongPassword(_passwordController.text)) {
      setState(() => _passwordError =
          'Password must contain uppercase, lowercase, number and special character');
      isValid = false;
    }

    // Confirm password validation
    if (_confirmPasswordController.text.isEmpty) {
      setState(() => _confirmPasswordError = 'Please confirm your password');
      isValid = false;
    } else if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _confirmPasswordError = 'Passwords do not match');
      isValid = false;
    }

    // Terms validation
    if (!_agreeToTerms) {
      setState(() => _termsError = 'You must accept the terms and conditions');
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

  bool _isStrongPassword(String password) {
    return password.contains(RegExp('[A-Z]')) &&
        password.contains(RegExp('[a-z]')) &&
        password.contains(RegExp('[0-9]')) &&
        password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  void _handleSignUp() {
    if (_validateForm()) {
      setState(() => _isLoading = true);

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Navigate to verification or home screen
        // Navigator.of(context).pushReplacementNamed('/verify-email');
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
              const SizedBox(height: DesignTokens.spaceLg),
              
              // Header
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF007AFF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Join thousands learning with Ibeere',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 24),

              // Name Input
              IbeereTextInput(
                label: 'Full Name',
                hintText: 'Enter your full name',
                controller: _nameController,
                prefixIcon: Icons.person_outlined,
                errorText: _nameError,
                isRequired: true,
                onChanged: (value) => setState(() => _nameError = null),
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Email Input
              IbeereTextInput(
                label: 'Email Address',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                prefixIcon: Icons.email_outlined,
                errorText: _emailError,
                isRequired: true,
                onChanged: (value) => setState(() => _emailError = null),
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Password Input
              IbeereTextInput(
                label: 'Password',
                hintText: 'Create a strong password',
                controller: _passwordController,
                prefixIcon: Icons.lock_outlined,
                obscureText: true,
                errorText: _passwordError,
                isRequired: true,
                onChanged: (value) => setState(() => _passwordError = null),
              ),
              const SizedBox(height: DesignTokens.spaceMd),
              _PasswordStrengthIndicator(password: _passwordController.text),
              const SizedBox(height: DesignTokens.spaceXl),

              // Confirm Password Input
              IbeereTextInput(
                label: 'Confirm Password',
                hintText: 'Re-enter your password',
                controller: _confirmPasswordController,
                prefixIcon: Icons.lock_outlined,
                obscureText: true,
                errorText: _confirmPasswordError,
                isRequired: true,
                onChanged: (value) => setState(() => _confirmPasswordError = null),
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Terms and Conditions
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IbeereCheckbox(
                    value: _agreeToTerms,
                    label: 'I agree to the Terms and Conditions',
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                        _termsError = null;
                      });
                    },
                  ),
                  if (_termsError != null) ...[
                    const SizedBox(height: DesignTokens.spaceSm),
                    Text(
                      _termsError!,
                      style: TextStyle(
                        color: DesignTokens.error,
                        fontSize: DesignTokens.fontSizeSm,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: DesignTokens.spaceXxl),

              // Sign Up Button
              IbeerePrimaryButton(
                label: 'Create Account',
                isFullWidth: true,
                isLoading: _isLoading,
                onPressed: _handleSignUp,
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Sign In Link
              Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: DesignTokens.fontSizeBase,
                        ),
                      ),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                          color: DesignTokens.primary,
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spaceLg),
            ],
          ),
        ),
      ),
    );
  }
}

/// Password Strength Indicator
class _PasswordStrengthIndicator extends StatelessWidget {

  const _PasswordStrengthIndicator({required this.password});
  final String password;

  _PasswordStrength _getStrength() {
    if (password.isEmpty) return _PasswordStrength.none;
    
    var strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.contains(RegExp('[A-Z]'))) strength++;
    if (password.contains(RegExp('[a-z]'))) strength++;
    if (password.contains(RegExp('[0-9]'))) strength++;
    if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) strength++;

    if (strength <= 2) return _PasswordStrength.weak;
    if (strength <= 3) return _PasswordStrength.medium;
    return _PasswordStrength.strong;
  }

  @override
  Widget build(BuildContext context) {
    final strength = _getStrength();
    if (strength == _PasswordStrength.none) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(3, (index) {
            final isFilled = index < strength.value;
            return Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.only(right: DesignTokens.spaceSm),
                decoration: BoxDecoration(
                  color: isFilled
                      ? strength.color
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: DesignTokens.spaceSm),
        Text(
          strength.label,
          style: TextStyle(
            color: strength.color,
            fontSize: DesignTokens.fontSizeSm,
            fontWeight: DesignTokens.fontWeightMedium,
          ),
        ),
      ],
    );
  }
}

enum _PasswordStrength {
  none(0, 'No password', Colors.grey),
  weak(1, 'Weak password', Color(0xFFFF3B30)),
  medium(2, 'Medium strength', Color(0xFFFF9500)),
  strong(3, 'Strong password', Color(0xFF34C759));

  final int value;
  final String label;
  final Color color;

  const _PasswordStrength(this.value, this.label, this.color);
}


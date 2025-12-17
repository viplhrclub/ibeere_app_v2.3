import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_inputs.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() {
    if (_emailController.text.isNotEmpty) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(DesignTokens.spaceLg),
          child: _emailSent ? _buildEmailSentView(context) : _buildForgotPasswordView(context),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Forgot Password?',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF007AFF),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Enter your email address and we'll send you instructions to reset your password.",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: 32),

        // Email Input
        IbeereTextInput(
          label: 'Email Address',
          hintText: 'you@example.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: DesignTokens.spaceXxl),

        // Send Button
        IbeerePrimaryButton(
          label: 'Send Reset Link',
          isFullWidth: true,
          isLoading: _isLoading,
          onPressed: _sendResetEmail,
        ),
        const SizedBox(height: DesignTokens.spaceXl),

        // Back to Sign In
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: DesignTokens.primary,
                fontWeight: DesignTokens.fontWeightBold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailSentView(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: DesignTokens.spaceXxl),
        Container(
          width: 120,
          height: 120,
          decoration: const BoxDecoration(
            color: Color(0xFFE3F2FD),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.mail_outline_rounded,
              color: Color(0xFF007AFF),
              size: 60,
            ),
          ),
        ),
        const SizedBox(height: 32),
        Text(
          'Check Your Email',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Color(0xFF007AFF),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          "We've sent password reset instructions to\n${_emailController.text}",
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xFF6B7280),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Continue Button
        IbeerePrimaryButton(
          label: 'Back to Sign In',
          isFullWidth: true,
          onPressed: () => Navigator.pop(context),
        ),
        const SizedBox(height: DesignTokens.spaceLg),

        // Resend Email
        Center(
          child: Column(
            children: [
              const Text(
                "Didn't receive the email?",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  setState(() => _emailSent = false);
                  _sendResetEmail();
                },
                child: const Text(
                  'Resend Email',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF007AFF),
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}


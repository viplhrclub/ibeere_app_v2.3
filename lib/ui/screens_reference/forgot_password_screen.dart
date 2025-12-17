import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_inputs.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

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
      Future.delayed(Duration(seconds: 2), () {
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
          padding: EdgeInsets.all(DesignTokens.spaceLg),
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
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: DesignTokens.primary,
          ),
        ),
        SizedBox(height: DesignTokens.spaceSm),
        Text(
          'Enter your email address and we\'ll send you instructions to reset your password.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: DesignTokens.spaceXxl),

        // Email Input
        IbeereTextInput(
          label: 'Email Address',
          hintText: 'you@example.com',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: DesignTokens.spaceXxl),

        // Send Button
        IbeerePrimaryButton(
          label: 'Send Reset Link',
          isFullWidth: true,
          isLoading: _isLoading,
          onPressed: _sendResetEmail,
        ),
        SizedBox(height: DesignTokens.spaceXl),

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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: DesignTokens.spaceXxl),
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.blue[50],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              Icons.mail_outline_rounded,
              color: DesignTokens.primary,
              size: 60,
            ),
          ),
        ),
        SizedBox(height: DesignTokens.spaceXxl),
        Text(
          'Check Your Email',
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
            color: DesignTokens.primary,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: DesignTokens.spaceSm),
        Text(
          'We\'ve sent password reset instructions to\n${_emailController.text}',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: DesignTokens.spaceXxl),

        // Continue Button
        IbeerePrimaryButton(
          label: 'Back to Sign In',
          isFullWidth: true,
          onPressed: () => Navigator.pop(context),
        ),
        SizedBox(height: DesignTokens.spaceLg),

        // Resend Email
        Center(
          child: Column(
            children: [
              Text(
                'Didn\'t receive the email?',
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeBase,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: DesignTokens.spaceSm),
              GestureDetector(
                onTap: () {
                  setState(() => _emailSent = false);
                  _sendResetEmail();
                },
                child: Text(
                  'Resend Email',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    color: DesignTokens.primary,
                    fontWeight: DesignTokens.fontWeightBold,
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

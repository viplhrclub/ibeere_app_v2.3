import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_inputs.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_common.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({super.key});

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignIn() async {
    setState(() {
      _isLoading = true;
    });
    
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
    });
  }

  void _handleGoogleSignIn() {
  }

  void _handleAppleSignIn() {
  }

  void _navigateToSignUp() {
    Navigator.pushNamed(context, '/sign-up');
  }

  void _handleForgotPassword() {
    Navigator.pushNamed(context, '/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IbeereDecorativeBackground(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    
                    const Center(
                      child: IbeereLogo(
                        size: LogoSize.large,
                        showDecorations: true,
                      ),
                    ),
                    const SizedBox(height: 64),
                    
                    IbeereTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    
                    IbeereTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      prefixIcon: Icons.lock_outline,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: IbeereDesignTokens.textSecondary,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: _handleForgotPassword,
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    IbeereButton(
                      text: 'Sign In',
                      onPressed: _handleSignIn,
                      variant: IbeereButtonVariant.primary,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 32),
                    
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or continue with',
                            style: TextStyle(
                              fontSize: 13,
                              color: IbeereDesignTokens.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: const Color(0xFFE2E8F0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    IbeereSocialButton(
                      provider: SocialProvider.google,
                      onPressed: _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 12),
                    
                    IbeereSocialButton(
                      provider: SocialProvider.apple,
                      onPressed: _handleAppleSignIn,
                    ),
                    const SizedBox(height: 32),
                    
                    Center(
                      child: GestureDetector(
                        onTap: _navigateToSignUp,
                        child: RichText(
                          text: const TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: IbeereDesignTokens.textSecondary,
                            ),
                            children: [
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                  color: IbeereDesignTokens.primaryPurple,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
              
              Positioned(
                bottom: 24,
                right: 24,
                child: IbeereFloatingActionButton(
                  onPressed: _handleSignIn,
                  icon: Icons.arrow_forward_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

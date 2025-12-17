import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class OtpScreen extends StatefulWidget {

  const OtpScreen({required this.email, super.key});
  final String email;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late List<TextEditingController> _otpControllers;
  bool _isLoading = false;
  int _resendTimer = 0;

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(6, (index) => TextEditingController());
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendTimer = 30);
    Future.doWhile(() async {
      await Future<void>.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _resendTimer--);
      }
      return _resendTimer > 0;
    });
  }

  void _verifyOtp() {
    final otp = _otpControllers.map((c) => c.text).join();
    if (otp.length == 6) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Navigate to success or next screen
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Email',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF007AFF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Enter the code sent to ${_hiddenEmail(widget.email)}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 32),

              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => _OtpField(
                    controller: _otpControllers[index],
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      } else if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: DesignTokens.spaceXxl),

              // Verify Button
              IbeerePrimaryButton(
                label: 'Verify',
                isFullWidth: true,
                isLoading: _isLoading,
                onPressed: _verifyOtp,
              ),
              const SizedBox(height: DesignTokens.spaceXl),

              // Resend Code
              Center(
                child: Column(
                  children: [
                    Text(
                      "Didn't receive the code?",
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: DesignTokens.spaceSm),
                    if (_resendTimer > 0)
                      Text(
                        'Resend in ${_resendTimer}s',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeBase,
                          color: DesignTokens.primary,
                          fontWeight: DesignTokens.fontWeightSemibold,
                        ),
                      )
                    else
                      GestureDetector(
                        onTap: _startResendTimer,
                        child: Text(
                          'Resend Code',
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
          ),
        ),
      ),
    );
  }

  String _hiddenEmail(String email) {
    final parts = email.split('@');
    final localPart = parts[0];
    final domain = parts[1];
    final hidden = '${localPart[0]}${'*' * (localPart.length - 2)}${localPart[localPart.length - 1]}';
    return '$hidden@$domain';
  }
}

class _OtpField extends StatelessWidget {

  const _OtpField({
    required this.controller,
    required this.onChanged,
  });
  final TextEditingController controller;
  final void Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 60,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: onChanged,
        decoration: InputDecoration(
          counterText: '',
          fillColor: const Color(0xFFF9FAFB),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFF007AFF),
              width: 2,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}


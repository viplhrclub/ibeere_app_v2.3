import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({Key? key, required this.email}) : super(key: key);

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
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startResendTimer() {
    setState(() => _resendTimer = 30);
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 1));
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
      Future.delayed(Duration(seconds: 2), () {
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
          padding: EdgeInsets.all(DesignTokens.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Verify Email',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: DesignTokens.primary,
                ),
              ),
              SizedBox(height: DesignTokens.spaceSm),
              Text(
                'Enter the code sent to ${_hiddenEmail(widget.email)}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: DesignTokens.spaceXxl),

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
              SizedBox(height: DesignTokens.spaceXxl),

              // Verify Button
              IbeerePrimaryButton(
                label: 'Verify',
                isFullWidth: true,
                isLoading: _isLoading,
                onPressed: _verifyOtp,
              ),
              SizedBox(height: DesignTokens.spaceXl),

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
                    SizedBox(height: DesignTokens.spaceSm),
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
  final TextEditingController controller;
  final Function(String) onChanged;

  const _OtpField({
    required this.controller,
    required this.onChanged,
  });

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
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
          ),
            focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            borderSide: BorderSide(
              color: DesignTokens.primary,
              width: 2,
            ),
          ),
        ),
        style: TextStyle(
          fontSize: DesignTokens.fontSizeXl,
          fontWeight: DesignTokens.fontWeightBold,
        ),
      ),
    );
  }
}

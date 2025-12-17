import 'package:flutter/material.dart';
import 'package:flutterquiz/ui/screens/otp_screen.dart';

/// Otp - Variant 2
/// Screenshot: 17_otp_screen_2
class OtpScreenVariant2 extends StatelessWidget {

  const OtpScreenVariant2({required this.email, super.key});
  final String email;

  @override
  Widget build(BuildContext context) {
    return OtpScreen(email: email);
  }
}


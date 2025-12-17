import 'package:flutter/material.dart';
import 'dart:async';

class OtpVerificationScreenV2 extends StatefulWidget {
  final String? phoneNumber;
  
  const OtpVerificationScreenV2({super.key, this.phoneNumber});

  @override
  State<OtpVerificationScreenV2> createState() => _OtpVerificationScreenV2State();
}

class _OtpVerificationScreenV2State extends State<OtpVerificationScreenV2> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  int _secondsRemaining = 55;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumber = widget.phoneNumber ?? '+229 90 01 02 03';
    
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Stack(
        children: [
          _buildDecorativeShapes(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  _buildLogoSection(),
                  const SizedBox(height: 60),
                  Text(
                    'Enter the 6-digit Code sent to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF6B7280),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    phoneNumber,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF5B6B7E),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(6, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: _buildOtpBox(index),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Resend Code in ${_secondsRemaining}s ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF9CA3AF),
                      ),
                      children: [
                        TextSpan(
                          text: 'Resend OTP',
                          style: TextStyle(
                            color: Color(0xFFDC2626),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By Sign In, you agree to your\n',
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
                  Spacer(),
                  Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xFF64748B), width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 16,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(36),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: Color(0xFF64748B),
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Back',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 40),
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

  Widget _buildOtpBox(int index) {
    return Container(
      width: 48,
      height: 52,
      decoration: BoxDecoration(
        color: Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _controllers[index].text.isNotEmpty 
              ? Color(0xFF6366F1).withOpacity(0.3)
              : Color(0xFFE5E7EB),
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        obscureText: true,
        obscuringCharacter: '*',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
        ),
        decoration: InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
        onChanged: (value) => _onDigitChanged(index, value),
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
            child: Icon(Icons.play_arrow_rounded, color: Color(0xFF1F2937), size: 16),
          ),
          Positioned(
            bottom: -8,
            right: 25,
            child: Icon(Icons.circle, color: Color(0xFF9333EA), size: 10),
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
            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
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
        Positioned(bottom: 450, left: -30, child: _buildBlob(Color(0xFFFFF8DC), 120, 140)),
        Positioned(bottom: 300, left: 30, child: _buildCircle(Color(0xFFFFF4CC), 16)),
        Positioned(bottom: 400, left: 80, child: _buildDiamond(Color(0xFF94A3B8), 14)),
        Positioned(bottom: 340, left: 100, child: _buildCircle(Color(0xFFD1FAE5), 18)),
        Positioned(bottom: 480, right: 60, child: _buildCircle(Color(0xFFD1D5DB), 14, outlined: true)),
        Positioned(bottom: 390, right: 100, child: _buildTriangle(Color(0xFF7DD3FC), 16)),
        Positioned(bottom: 320, right: 30, child: _buildCircle(Color(0xFFFED7AA), 20)),
        Positioned(bottom: 440, right: 40, child: _buildCircle(Color(0xFFFFD6D6), 24, outlined: true)),
        Positioned(bottom: -60, right: -70, child: _buildBlob(Color(0xFFDEF7EC), 180, 190)),
        Positioned(bottom: -50, left: -60, child: _buildBlob(Color(0xFFFFE5E5), 170, 150)),
      ],
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
            child: Icon(Icons.play_arrow_rounded, color: Color(0xFF1F2937), size: 16),
          ),
          Positioned(
            bottom: -8,
            right: 25,
            child: Icon(Icons.circle, color: Color(0xFF9333EA), size: 10),
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
            child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}

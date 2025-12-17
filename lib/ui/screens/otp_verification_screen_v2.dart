import 'package:flutter/material.dart';
import 'dart:math' as math;

class OtpVerification extends StatefulWidget {
  const OtpVerification({super.key});

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  final List<TextEditingController> _otpControllers = 
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      20,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 200),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var controller in _decoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFAFAFA),
              Color(0xFFF5F5F5),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildFloatingDecorations(),
              SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const SizedBox(height: 120),
                    _buildLogo(),
                    const SizedBox(height: 100),
                    _buildOtpInstructions(),
                    const SizedBox(height: 40),
                    _buildOtpInputs(),
                    const SizedBox(height: 40),
                    _buildResendSection(),
                    const SizedBox(height: 40),
                    _buildTerms(),
                    const SizedBox(height: 120),
                    _buildBackButton(),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingDecorations() {
    final decos = [
      {'pos': Offset(60, 80), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(240, 60), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(180, 70), 'color': Color(0xFF94A3B8), 'shape': 'circle'},
      {'pos': Offset(420, 60), 'color': Color(0xFF94A3B8), 'shape': 'diamond'},
      {'pos': Offset(620, 50), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(680, 100), 'color': Color(0xFF94A3B8), 'shape': 'diamond'},
      {'pos': Offset(720, 60), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(40, 550), 'color': Color(0xFFFFEFD4), 'shape': 'blob'},
      {'pos': Offset(100, 1010), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(160, 980), 'color': Color(0xFF94A3B8), 'shape': 'diamond'},
      {'pos': Offset(420, 1000), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(580, 1030), 'color': Color(0xFF94A3B8), 'shape': 'circle'},
      {'pos': Offset(680, 990), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(620, 1030), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(100, 1280), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(580, 1300), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(180, 1250), 'color': Color(0xFF94A3B8), 'shape': 'circle'},
    ];

    return Stack(
      children: decos.asMap().entries.where((e) => e.key < _decoControllers.length).map((entry) {
        final shape = entry.value['shape'] as String;
        
        if (shape == 'blob') {
          return Positioned(
            left: (entry.value['pos'] as Offset).dx,
            top: (entry.value['pos'] as Offset).dy,
            child: Container(
              width: 100,
              height: 120,
              decoration: BoxDecoration(
                color: (entry.value['color'] as Color).withOpacity(0.3),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
          );
        }
        
        return AnimatedBuilder(
          animation: _decoControllers[entry.key],
          builder: (context, child) {
            return Positioned(
              left: (entry.value['pos'] as Offset).dx,
              top: (entry.value['pos'] as Offset).dy + 
                  math.sin(_decoControllers[entry.key].value * 2 * math.pi) * 10,
              child: _buildShape(entry.value['color'] as Color, shape),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildShape(Color color, String shape) {
    switch (shape) {
      case 'circle':
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      case 'diamond':
        return Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
        );
      case 'triangle':
        return CustomPaint(size: const Size(12, 12), painter: TrianglePainter(color: color));
      default:
        return const SizedBox();
    }
  }

  Widget _buildLogo() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'ibeere',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: Color(0xFF7C3AED),
              letterSpacing: -1,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF7C3AED),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'Games',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOtpInstructions() {
    return Column(
      children: const [
        Text(
          'Enter the 6-digit Code sent to',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF94A3B8),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          '+229 90 01 02 03',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7FA8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInputs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(6, (index) {
        return Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              '*',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF94A3B8),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildResendSection() {
    return RichText(
      text: const TextSpan(
        text: 'Resend Code in ',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFF94A3B8),
        ),
        children: [
          TextSpan(
            text: '55s ',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF94A3B8),
            ),
          ),
          TextSpan(
            text: 'Resend OTP',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTerms() {
    return RichText(
      text: const TextSpan(
        text: 'By Sign In, you agree to your\n',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Color(0xFF94A3B8),
        ),
        children: [
          TextSpan(
            text: 'Terms of services & Privacy Policy',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFFEF4444),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBackButton() {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF0),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF94A3B8),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Color(0xFF64748B),
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Back',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Positioned(
      right: 32,
      bottom: 32,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacementNamed('/home');
        },
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFDC2626),
                Color(0xFFEF4444),
              ],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFEF4444).withOpacity(0.4),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Stack(
            children: [
              ...List.generate(6, (i) => Positioned(
                top: 15 + (i % 3) * 20.0,
                left: 10 + (i % 2) * 40.0,
                child: Container(
                  width: 3,
                  height: 3,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              )),
              const Center(
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

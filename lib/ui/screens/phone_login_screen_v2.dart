import 'package:flutter/material.dart';
import 'dart:math' as math;

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  final TextEditingController _phoneController = TextEditingController(text: '+229 91952546');

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
    _phoneController.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    _buildHeader(),
                    const SizedBox(height: 60),
                    _buildLogo(),
                    const SizedBox(height: 80),
                    _buildPhoneInput(),
                    const SizedBox(height: 40),
                    _buildFooter(),
                    const SizedBox(height: 60),
                    _buildOtpNotice(),
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
      {'pos': Offset(40, 180), 'color': Color(0xFFFFE4E4), 'shape': 'blob'},
      {'pos': Offset(650, 190), 'color': Color(0xFFE4FFE4), 'shape': 'blob'},
      {'pos': Offset(50, 600), 'color': Color(0xFFFFEFD4), 'shape': 'blob'},
      {'pos': Offset(100, 1050), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(160, 1010), 'color': Color(0xFF94A3B8), 'shape': 'diamond'},
      {'pos': Offset(420, 1030), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(580, 1070), 'color': Color(0xFF94A3B8), 'shape': 'circle'},
      {'pos': Offset(680, 1020), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(620, 1070), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(40, 1380), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(180, 1400), 'color': Color(0xFF94A3B8), 'shape': 'diamond'},
      {'pos': Offset(580, 1380), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(680, 1360), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
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

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7FA8),
          ),
        ),
        SizedBox(height: 12),
        Text(
          'We happy to see you again.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF94A3B8),
          ),
        ),
        Text(
          'To use app you should login first',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
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

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose you country & Enter your phone\nnumber to continue !',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: const [
                    Text('🇬🇳', style: TextStyle(fontSize: 28)),
                    SizedBox(width: 8),
                  ],
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {},
              child: const Text(
                'Connect with others Methods ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Password forgot ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        RichText(
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
        ),
      ],
    );
  }

  Widget _buildOtpNotice() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Text(
          'A 6-digit OTP code will be sent to\nyour number!',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xFFE2E8F0),
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
    );
  }

  Widget _buildContinueButton() {
    return Positioned(
      right: 32,
      bottom: 32,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/otp-verification');
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

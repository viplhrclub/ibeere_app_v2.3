import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingKnowledge extends StatefulWidget {
  const OnboardingKnowledge({super.key});

  @override
  State<OnboardingKnowledge> createState() => _OnboardingKnowledgeState();
}

class _OnboardingKnowledgeState extends State<OnboardingKnowledge>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late AnimationController _rotationController;
  late List<AnimationController> _shapeControllers;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _shapeControllers = List.generate(
      8,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 200),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    _rotationController.dispose();
    for (var controller in _shapeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1E3A5F),
              Color(0xFF2A4A6F),
              Color(0xFF1E3A5F),
            ],
          ),
        ),
        child: Stack(
          children: [
            _buildFloatingShapes(),
            SafeArea(
              child: Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildUserCards(),
                        const SizedBox(height: 60),
                        _buildBottomCard(),
                      ],
                    ),
                  ),
                  _buildLogo(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingShapes() {
    return Stack(
      children: [
        _buildShape(0, Alignment.topLeft, 80, const Color(0xFF8B4A5F)),
        _buildShape(1, Alignment.topRight, 100, const Color(0xFF4A5F5F)),
        _buildShape(2, Alignment.centerLeft, 60, const Color(0xFF5F4A8B)),
        _buildShape(3, Alignment.bottomLeft, 90, const Color(0xFF6A5A4A)),
        _buildShape(4, Alignment.bottomRight, 110, const Color(0xFF8B4A5F)),
        _buildSmallCircle(5, const Offset(100, 250), Colors.cyan),
        _buildSmallCircle(6, const Offset(300, 450), Colors.yellow),
        _buildSmallCircle(7, const Offset(350, 600), Colors.red),
        _buildSmallDiamond(const Offset(150, 600), Colors.purple),
        _buildSmallSquare(const Offset(500, 350), Colors.grey),
        _buildSmallTriangle(const Offset(620, 720), Colors.cyan),
      ],
    );
  }

  Widget _buildShape(int index, Alignment alignment, double size, Color color) {
    return AnimatedBuilder(
      animation: _shapeControllers[index],
      builder: (context, child) {
        return Align(
          alignment: alignment,
          child: Transform.translate(
            offset: Offset(
              math.sin(_shapeControllers[index].value * 2 * math.pi) * 20,
              math.cos(_shapeControllers[index].value * 2 * math.pi) * 20,
            ),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: color.withOpacity(0.3),
                borderRadius: BorderRadius.circular(size / 3),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallCircle(int index, Offset position, Color color) {
    if (index >= _shapeControllers.length) return const SizedBox();
    return AnimatedBuilder(
      animation: _shapeControllers[index],
      builder: (context, child) {
        return Positioned(
          left: position.dx,
          top: position.dy + _shapeControllers[index].value * 10,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallDiamond(Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildSmallSquare(Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildSmallTriangle(Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: CustomPaint(
        size: const Size(12, 12),
        painter: TrianglePainter(color: color),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 35,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            child: Text(
              'Skip',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCards() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.translate(
              offset: Offset(
                -40 + math.sin(_floatingController.value * 2 * math.pi) * 5,
                math.cos(_floatingController.value * 2 * math.pi) * 8,
              ),
              child: Transform.rotate(
                angle: -0.15,
                child: _buildUserCard(
                  'Melissa_lin...',
                  'https://placeholder.com/150',
                  true,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(
                50 + math.sin((_floatingController.value + 0.5) * 2 * math.pi) * 5,
                20 + math.cos((_floatingController.value + 0.5) * 2 * math.pi) * 8,
              ),
              child: Transform.rotate(
                angle: 0.1,
                child: _buildUserCard(
                  'fawazgladi...',
                  'https://placeholder.com/150',
                  false,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserCard(String username, String imageUrl, bool isLeft) {
    return Container(
      width: 180,
      height: 220,
      decoration: BoxDecoration(
        color: isLeft ? const Color(0xFFFFE4E4) : const Color(0xFFE8D4B8),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.person, size: 80, color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 12,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      username,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A4A6F).withOpacity(0.6),
            const Color(0xFF1E3A5F).withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          const Text(
            'The Ultimate Quiz Challenge',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '"Think you\'re a genius ? Prove it\nwith our Challenge quizzes !"',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.white.withOpacity(0.8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/onboarding2');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE94560),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFE94560).withOpacity(0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.rocket_launch_outlined, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ibeere',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF7C3AED),
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

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

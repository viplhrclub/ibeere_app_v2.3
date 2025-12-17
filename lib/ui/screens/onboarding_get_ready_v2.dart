import 'package:flutter/material.dart';
import 'dart:math' as math;

class OnboardingGetReady extends StatefulWidget {
  const OnboardingGetReady({super.key});

  @override
  State<OnboardingGetReady> createState() => _OnboardingGetReadyState();
}

class _OnboardingGetReadyState extends State<OnboardingGetReady>
    with TickerProviderStateMixin {
  late List<AnimationController> _shapeControllers;
  late AnimationController _robotController;

  @override
  void initState() {
    super.initState();
    _shapeControllers = List.generate(
      6,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2500 + index * 300),
      )..repeat(reverse: true),
    );

    _robotController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    for (var controller in _shapeControllers) {
      controller.dispose();
    }
    _robotController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFAF5FF),
              Color(0xFFF5F3FF),
              Color(0xFFFFFBF5),
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
                        const SizedBox(height: 40),
                        _buildRobotImage(),
                        const SizedBox(height: 60),
                        _buildContent(),
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
        _buildShape(0, const Offset(30, 150), 100, const Color(0xFFFFE4E4)),
        _buildShape(1, const Offset(650, 250), 120, const Color(0xFFFFFFD4)),
        _buildShape(2, const Offset(100, 750), 90, const Color(0xFFFFFFD4)),
        _buildShape(3, const Offset(350, 800), 80, const Color(0xFFEFE4FF)),
        _buildShape(4, const Offset(580, 850), 100, const Color(0xFFFFE4E4)),
        _buildSmallCircle(5, const Offset(100, 350), Colors.cyan),
        _buildSmallCircle(0, const Offset(640, 310), Colors.yellow),
        _buildSmallSquare(const Offset(190, 1270), Colors.grey),
        _buildSmallDiamond(const Offset(270, 420), Colors.grey),
        _buildSmallCircle(1, const Offset(560, 430), const Color(0xFFE94560)),
        _buildSmallTriangle(const Offset(680, 930), Colors.cyan),
        _buildSmallCircle(2, const Offset(190, 1360), Colors.cyan),
        _buildSmallCircle(3, const Offset(680, 780), const Color(0xFFE94560)),
        _buildSmallDiamond(const Offset(670, 1350), const Color(0xFFE94560)),
        _buildSmallSquare(const Offset(410, 1320), Colors.cyan),
        _buildSmallCircle(4, const Offset(110, 1240), Colors.yellow),
        _buildSmallDiamond(const Offset(640, 1270), Colors.yellow),
      ],
    );
  }

  Widget _buildShape(int index, Offset position, double size, Color color) {
    if (index >= _shapeControllers.length) return const SizedBox();
    return AnimatedBuilder(
      animation: _shapeControllers[index],
      builder: (context, child) {
        return Positioned(
          left: position.dx,
          top: position.dy + _shapeControllers[index].value * 15,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(size / 2.5),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSmallCircle(int index, Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _buildSmallDiamond(Offset position, Color color) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          width: 10,
          height: 10,
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
        children: [
          Container(
            width: 50,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7FA8),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Color(0xFF6B7FA8),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: const Color(0xFF6B7FA8).withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRobotImage() {
    return AnimatedBuilder(
      animation: _robotController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            math.sin(_robotController.value * 2 * math.pi) * 10,
            math.cos(_robotController.value * 2 * math.pi) * 15,
          ),
          child: Transform.rotate(
            angle: math.sin(_robotController.value * 2 * math.pi) * 0.1,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -0.3,
                    child: Container(
                      width: 180,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    const Color(0xFFF8BBD0),
                                    const Color(0xFFCE93D8),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 30,
                              left: 30,
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE040FB),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 50,
                              right: 40,
                              child: Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCE93D8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 20,
                    child: Container(
                      width: 60,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 70,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          const Text(
            'Get Ready to Quiz',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Color(0xFF4A5F7F),
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            '"Discover exciting Quiz categories\nand improve your Skill !"',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF6B7FA8),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/language-selection');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE94560),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 8,
              shadowColor: const Color(0xFFE94560).withOpacity(0.5),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.rocket_launch_outlined, size: 20),
                const SizedBox(width: 12),
                const Text(
                  'Get Started',
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
    return Row(
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

import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuizDefeat extends StatefulWidget {
  const QuizDefeat({super.key});

  @override
  State<QuizDefeat> createState() => _QuizDefeatState();
}

class _QuizDefeatState extends State<QuizDefeat>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      15,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 150),
      )..repeat(reverse: true),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    for (var controller in _decoControllers) {
      controller.dispose();
    }
    _scaleController.dispose();
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
              Color(0xFFF8F9FA),
              Color(0xFFEEF2F7),
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
                    const SizedBox(height: 40),
                    _buildPlayerHeader(),
                    const SizedBox(height: 80),
                    _buildDefeatTitle(),
                    const SizedBox(height: 60),
                    _buildStatsCircle(),
                    const SizedBox(height: 40),
                    _buildLegend(),
                    const SizedBox(height: 60),
                    _buildEarnCoinsButton(),
                    const SizedBox(height: 60),
                    _buildActionButtons(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingDecorations() {
    final decos = [
      {'pos': Offset(100, 100), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(640, 130), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(100, 220), 'color': Color(0xFF64748B), 'shape': 'diamond'},
      {'pos': Offset(520, 230), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(650, 190), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
    ];

    return Stack(
      children: decos.asMap().entries.where((e) => e.key < _decoControllers.length).map((entry) {
        return AnimatedBuilder(
          animation: _decoControllers[entry.key],
          builder: (context, child) {
            return Positioned(
              left: (entry.value['pos'] as Offset).dx,
              top: (entry.value['pos'] as Offset).dy + 
                  math.sin(_decoControllers[entry.key].value * 2 * math.pi) * 10,
              child: _buildShape(
                entry.value['color'] as Color,
                entry.value['shape'] as String,
              ),
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

  Widget _buildPlayerHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xFFE8EAF0),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              '38',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF64748B), width: 3),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFE8EAF0),
              child: const Icon(Icons.person, size: 50, color: Color(0xFF94A3B8)),
            ),
          ),
        ),
        const SizedBox(width: 16),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Melissa',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
            SizedBox(height: 4),
            Text(
              '45k Kauris | 1500k Points',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDefeatTitle() {
    return Column(
      children: [
        ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
          ),
          child: const Text(
            'DEFEAT',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Color(0xFF5C6B7F),
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Congratulation',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCircle() {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(300, 300),
            painter: DefeatStatsCirclePainter(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                '-120',
                style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF7B8AA7),
                ),
              ),
              Text(
                'POINTS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '4/5',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7B8AA7),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
                Text(
                  '1/5',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7B8AA7),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            child: Column(
              children: const [
                Text(
                  '-60',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF7B8AA7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(const Color(0xFF7B8AA7), 'Correct'),
        const SizedBox(width: 40),
        _buildLegendItem(const Color(0xFF7B8AA7), 'Wrong'),
        const SizedBox(width: 40),
        _buildLegendItem(const Color(0xFF7B8AA7), 'Coins'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildEarnCoinsButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF5C6B7F),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5C6B7F).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(left: 140, top: 5, child: _buildButtonDeco(true)),
          Positioned(right: 160, top: 8, child: _buildButtonDeco(false)),
          Positioned(left: 180, bottom: 10, child: _buildButtonDeco(true)),
          Positioned(right: 200, bottom: 8, child: _buildButtonDeco(true)),
          Positioned(right: 280, top: 12, child: _buildButtonDeco(false)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_arrow, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'Earn Coins',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(Icons.refresh, 'Play again !'),
            _buildActionButton(Icons.remove_red_eye, 'Review Quiz'),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildActionButton(Icons.share, 'Share score'),
            _buildActionButton(Icons.home_outlined, 'Back home'),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF0),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF64748B), size: 20),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonDeco(bool isCircle) {
    return Container(
      width: isCircle ? 6 : 8,
      height: isCircle ? 6 : 8,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(2),
      ),
    );
  }
}

class DefeatStatsCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;
    final strokeWidth = 24.0;

    final grayPaint = Paint()
      ..color = const Color(0xFF7B8AA7)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final darkGrayPaint = Paint()
      ..color = const Color(0xFF5C6B7F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      math.pi * 0.8,
      false,
      darkGrayPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + math.pi * 0.82,
      math.pi * 0.2,
      false,
      grayPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2 + math.pi * 1.04,
      math.pi * 0.5,
      false,
      const Color(0xFFA1AABA),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

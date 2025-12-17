import 'package:flutter/material.dart';
import 'dart:math' as math;

class BattleModeSelection extends StatefulWidget {
  const BattleModeSelection({super.key});

  @override
  State<BattleModeSelection> createState() => _BattleModeSelectionState();
}

class _BattleModeSelectionState extends State<BattleModeSelection>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      10,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 200),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
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
              Color(0xFFF8F9FA),
              Color(0xFFEEF2F7),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildFloatingDecorations(),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildModeCard(
                      '1V/S1\nBATTLE',
                      const Color(0xFF10B981),
                      '/battle-1v1',
                    ),
                    const SizedBox(height: 40),
                    _buildModeCard(
                      'GROUP\nBATTLE',
                      const Color(0xFFD946EF),
                      '/battle-group',
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

  Widget _buildFloatingDecorations() {
    final decos = [
      {'pos': Offset(100, 200), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(640, 250), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(120, 450), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(620, 600), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(100, 950), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(660, 1050), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
    ];

    return Stack(
      children: decos.asMap().entries.where((e) => e.key < _decoControllers.length).map((entry) {
        return AnimatedBuilder(
          animation: _decoControllers[entry.key],
          builder: (context, child) {
            return Positioned(
              left: (entry.value['pos'] as Offset).dx,
              top: (entry.value['pos'] as Offset).dy + 
                  math.sin(_decoControllers[entry.key].value * 2 * math.pi) * 15,
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
          width: 12,
          height: 12,
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
        return CustomPaint(size: const Size(14, 14), painter: TrianglePainter(color: color));
      default:
        return const SizedBox();
    }
  }

  Widget _buildModeCard(String title, Color color, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(route);
      },
      child: Container(
        width: 500,
        height: 450,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(48),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              left: 40,
              child: Transform.rotate(
                angle: -0.2,
                child: Container(
                  width: 250,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(140),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(48),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 72,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 2,
                    height: 1.1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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

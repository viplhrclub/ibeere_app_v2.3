import 'package:flutter/material.dart';
import 'dart:math' as math;

class QuizPlaying extends StatefulWidget {
  const QuizPlaying({super.key});

  @override
  State<QuizPlaying> createState() => _QuizPlayingState();
}

class _QuizPlayingState extends State<QuizPlaying>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  int selectedAnswer = -1;

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      30,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 150),
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
              Column(
                children: [
                  _buildTopBar(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          _buildQuestionCard(),
                          const SizedBox(height: 32),
                          _buildAnswerOptions(),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomNav(),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingDecorations() {
    final decos = [
      {'pos': Offset(130, 220), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(100, 250), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(160, 310), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(120, 450), 'color': Color(0xFF64748B), 'shape': 'circle'},
      {'pos': Offset(620, 200), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(660, 390), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(610, 330), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(590, 450), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(470, 460), 'color': Color(0xFF64748B), 'shape': 'diamond'},
      {'pos': Offset(120, 540), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(160, 730), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(110, 840), 'color': Color(0xFF64748B), 'shape': 'circle'},
      {'pos': Offset(150, 1040), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(410, 520), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(600, 530), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(610, 730), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(600, 840), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(410, 1020), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(610, 1030), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(410, 1220), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(610, 1220), 'color': Color(0xFFEF4444), 'shape': 'circle'},
    ];

    return Stack(
      children: decos.asMap().entries.where((e) => e.key < _decoControllers.length).map((entry) {
        return AnimatedBuilder(
          animation: _decoControllers[entry.key],
          builder: (context, child) {
            return Positioned(
              left: (entry.value['pos'] as Offset).dx,
              top: (entry.value['pos'] as Offset).dy + 
                  math.sin(_decoControllers[entry.key].value * 2 * math.pi) * 8,
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

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF94A3B8), width: 2),
            ),
            child: const Icon(Icons.arrow_back, color: Color(0xFF64748B), size: 22),
          ),
          const Spacer(),
          Container(
            width: 400,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF94A3B8),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Stack(
              children: [
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4A5568),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                const Center(
                  child: Text(
                    '20',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EAF0),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF94A3B8), width: 2),
            ),
            child: const Icon(Icons.bookmark_outline, color: Color(0xFF64748B), size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildQuestionDecorations(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '1 | 5 Questions',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Qu\'est-ce que l\'indice des prix à la consommation (IPC) ? Qu\'est-ce que l\'indice des prix à la professe consommation (IPC) ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                        height: 1.4,
                      ),
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

  Widget _buildQuestionDecorations() {
    final decos = [
      {'pos': Offset(100, 30), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(140, 55), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(150, 100), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(380, 50), 'color': Color(0xFF64748B), 'shape': 'diamond'},
      {'pos': Offset(600, 40), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(120, 150), 'color': Color(0xFF64748B), 'shape': 'circle'},
    ];

    return Stack(
      children: decos.map((deco) {
        return Positioned(
          left: (deco['pos'] as Offset).dx,
          top: (deco['pos'] as Offset).dy,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: (deco['color'] as Color).withOpacity(0.5),
              shape: deco['shape'] == 'circle' ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: deco['shape'] == 'circle' ? null : BorderRadius.circular(2),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnswerOptions() {
    final options = [
      'Les mesures prises pour atténuer les fluctuations économiques.',
      'L\'ouverture des frontières aux flux migratoires.',
      'La mesure du chômage, une économie',
      'Allasane Ouatara',
    ];

    return Column(
      children: options.asMap().entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildAnswerOption(
            entry.value,
            entry.key == selectedAnswer,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnswerOption(String text, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedAnswer = isSelected ? -1 : 0;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected 
                ? const Color(0xFF7C3AED)
                : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF94A3B8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
            _buildOptionDecorations(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionDecorations() {
    final decos = [
      {'pos': Offset(120, 15), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(160, 30), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(100, 50), 'color': Color(0xFF64748B), 'shape': 'circle'},
      {'pos': Offset(120, 1040), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(410, 20), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(500, 30), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(610, 40), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(610, 1030), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(660, 830), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
    ];

    return Stack(
      children: decos.map((deco) {
        return Positioned(
          left: (deco['pos'] as Offset).dx,
          top: (deco['pos'] as Offset).dy,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: (deco['color'] as Color).withOpacity(0.5),
              shape: deco['shape'] == 'circle' ? BoxShape.circle : BoxShape.rectangle,
              borderRadius: deco['shape'] == 'circle' ? null : BorderRadius.circular(2),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(Icons.celebration, '50'),
          _buildNavButton(Icons.people, ''),
          _buildNavButton(Icons.refresh, ''),
          _buildNavButton(Icons.play_arrow, '', isPrimary: true),
        ],
      ),
    );
  }

  Widget _buildNavButton(IconData icon, String? badge, {bool isPrimary = false}) {
    return Container(
      width: isPrimary ? 80 : 70,
      height: isPrimary ? 80 : 70,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF7C3AED) : const Color(0xFFE8EAF0),
        shape: BoxShape.circle,
        border: isPrimary ? Border.all(color: const Color(0xFF6B4DFF), width: 3) : null,
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            icon,
            color: isPrimary ? Colors.white : const Color(0xFF64748B),
            size: isPrimary ? 36 : 28,
          ),
          if (badge != null && badge.isNotEmpty)
            Positioned(
              bottom: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
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

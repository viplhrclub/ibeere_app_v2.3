import 'package:flutter/material.dart';
import 'dart:math' as math;

class GuessWordGame extends StatefulWidget {
  const GuessWordGame({super.key});

  @override
  State<GuessWordGame> createState() => _GuessWordGameState();
}

class _GuessWordGameState extends State<GuessWordGame>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  final List<String> letters = ['M', 'O', 'R', 'N', '', 'N', 'G'];
  final int selectedLifeline = -1;

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      25,
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
                  const SizedBox(height: 40),
                  _buildCategoryHeader(),
                  const SizedBox(height: 40),
                  _buildWordBoard(),
                  const SizedBox(height: 40),
                  _buildActionButtons(),
                  const SizedBox(height: 40),
                  _buildLifelines(),
                  const SizedBox(height: 40),
                  _buildKeyboard(),
                  const SizedBox(height: 24),
                  _buildSubmitButton(),
                  const SizedBox(height: 24),
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
      {'pos': Offset(100, 210), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(170, 240), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(150, 310), 'color': Color(0xFF64748B), 'shape': 'circle'},
      {'pos': Offset(170, 450), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(620, 220), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(680, 290), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(650, 330), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(620, 450), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(480, 460), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(110, 920), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(170, 950), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(100, 1270), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(170, 1300), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(660, 920), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(610, 1300), 'color': Color(0xFFEF4444), 'shape': 'circle'},
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

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5C6B7F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.grid_3x3, color: Colors.white, size: 22),
          ),
          const Spacer(),
          Container(
            width: 400,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFF4A5568),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5C6B7F),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.timer, color: Colors.white, size: 18),
                ),
                const Text(
                  '20',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
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
              color: const Color(0xFF5C6B7F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.refresh, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader() {
    return Column(
      children: const [
        Text(
          'CATEGORIES',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.lightbulb_outline, color: Color(0xFFEF4444), size: 24),
            SizedBox(width: 8),
            Text(
              'Capitals',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWordBoard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: const Color(0xFF3A4A62),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3A4A62).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildBoardDecorations(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: letters.map((letter) {
              return Container(
                width: 70,
                height: 80,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: letter.isEmpty 
                      ? const Color(0xFF5C6B7F)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBoardDecorations() {
    final boardDecos = [
      {'pos': Offset(140, 20), 'color': Colors.white, 'shape': 'diamond'},
      {'pos': Offset(200, 30), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(80, 70), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(420, 25), 'color': Color(0xFF8B5CF6), 'shape': 'circle'},
      {'pos': Offset(520, 35), 'color': Colors.white, 'shape': 'diamond'},
      {'pos': Offset(550, 80), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(620, 70), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(650, 40), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(680, 90), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
    ];

    return Stack(
      children: boardDecos.map((deco) {
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

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildActionButton(Icons.refresh, 'Hint'),
        const SizedBox(width: 40),
        _buildActionButton(Icons.arrow_back, 'Back'),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
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

  Widget _buildLifelines() {
    final lifelines = [
      {'icon': Icons.remove_red_eye, 'count': 2, 'color': Color(0xFF9333EA)},
      {'icon': Icons.star, 'count': 4, 'color': Color(0xFF10B981)},
      {'icon': Icons.help_outline, 'count': 3, 'color': Color(0xFF3B82F6)},
      {'icon': Icons.add, 'count': 6, 'color': Color(0xFFEC4899)},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lifelines.map((lifeline) {
        return Container(
          width: 80,
          height: 90,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                lifeline['color'] as Color,
                (lifeline['color'] as Color).withOpacity(0.8),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: (lifeline['color'] as Color).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  lifeline['icon'] as IconData,
                  color: Colors.white,
                  size: 36,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      lifeline['count'].toString(),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: lifeline['color'] as Color,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyboard() {
    final row1 = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
    final row2 = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'];
    final row3 = ['Z', 'X', 'C', 'V', 'B', 'N', 'M'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildKeyboardRow(row1, true),
          const SizedBox(height: 12),
          _buildKeyboardRow(row2, false),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSpecialKey(Icons.arrow_upward, Colors.white),
              const SizedBox(width: 12),
              ..._buildKeyboardRow(row3, false, forRow: true),
              const SizedBox(width: 12),
              _buildSpecialKey(Icons.close, Colors.white),
            ],
          ),
          const SizedBox(height: 12),
          _buildSpaceBar(),
        ],
      ),
    );
  }

  List<Widget> _buildKeyboardRow(List<String> letters, bool isFirstRow, {bool forRow = false}) {
    return letters.map((letter) {
      final isUsed = this.letters.contains(letter);
      return Container(
        width: isFirstRow ? 60 : 62,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: isUsed ? const Color(0xFF10B981) : const Color(0xFFE8EAF0),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            letter,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: isUsed ? Colors.white : const Color(0xFF94A3B8),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildSpecialKey(IconData icon, Color iconColor) {
    return Container(
      width: 60,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Icon(icon, color: const Color(0xFF94A3B8), size: 22),
      ),
    );
  }

  Widget _buildSpaceBar() {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: Text(
          'Space',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
        ),
        borderRadius: BorderRadius.circular(50),
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
          Positioned(left: 140, top: 5, child: _buildButtonDeco(true)),
          Positioned(right: 160, top: 8, child: _buildButtonDeco(false)),
          Positioned(left: 180, bottom: 10, child: _buildButtonDeco(true)),
          Positioned(right: 200, bottom: 8, child: _buildButtonDeco(true)),
          Positioned(right: 280, top: 12, child: _buildButtonDeco(false)),
          Positioned(right: 340, bottom: 10, child: _buildButtonDeco(true)),
          Positioned(left: 100, top: 18, child: _buildButtonDeco(false)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_arrow, color: Colors.white, size: 28),
                SizedBox(width: 12),
                Text(
                  'Submit',
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

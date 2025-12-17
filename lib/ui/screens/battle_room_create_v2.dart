import 'package:flutter/material.dart';
import 'dart:math' as math;

class BattleRoomCreation extends StatefulWidget {
  const BattleRoomCreation({super.key});

  @override
  State<BattleRoomCreation> createState() => _BattleRoomCreationState();
}

class _BattleRoomCreationState extends State<BattleRoomCreation>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  final List<int> pinDigits = [2, 0, 4, 7, 8, 4];

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
              Color(0xFFFEF2F2),
              Color(0xFFEFF6FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              _buildFloatingDecorations(),
              Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          _buildPinCodeDisplay(),
                          const SizedBox(height: 60),
                          _buildVSPlayers(),
                          const SizedBox(height: 80),
                          _buildStartButton(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  _buildBottomCard(),
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
      {'pos': Offset(80, 110), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(200, 100), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(110, 150), 'color': Color(0xFF94A3B8), 'shape': 'circle'},
      {'pos': Offset(300, 95), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(400, 105), 'color': Color(0xFF94A3B8), 'shape': 'square'},
      {'pos': Offset(510, 110), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(590, 100), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(60, 280), 'color': Color(0xFF10B981), 'shape': 'circle'},
      {'pos': Offset(80, 450), 'color': Color(0xFF06B6D4), 'shape': 'diamond'},
      {'pos': Offset(540, 440), 'color': Color(0xFFFBBF24), 'shape': 'circle'},
      {'pos': Offset(620, 600), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(100, 750), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(600, 780), 'color': Color(0xFF10B981), 'shape': 'circle'},
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
      case 'square':
        return Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
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
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF9C6FFF)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'ENTRY FEES | 150',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 22),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinCodeDisplay() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'ROOM PIN CODE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                letterSpacing: 1,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.expand_more, color: Color(0xFF94A3B8), size: 20),
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          'Share this Room Code to Friends and Ask them to join !',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF94A3B8),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: pinDigits.map((digit) {
            return Container(
              width: 70,
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFCBD5E1), width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  digit.toString(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildVSPlayers() {
    return Column(
      children: [
        _buildPlayerAvatar('Melissa_lin...', true),
        const SizedBox(height: 24),
        const Text(
          'VS',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 24),
        _buildPlayerAvatar('fawazgladi...', false),
      ],
    );
  }

  Widget _buildPlayerAvatar(String username, bool isTop) {
    return Container(
      width: 200,
      height: 230,
      decoration: BoxDecoration(
        color: isTop ? const Color(0xFFD4C5F9) : const Color(0xFFE8DAA0),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.person, size: 100, color: Colors.grey),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
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
                    child: const Icon(Icons.person, size: 12, color: Colors.grey),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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

  Widget _buildStartButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      height: 70,
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
          Positioned(left: 140, top: 15, child: _buildButtonDeco(true)),
          Positioned(right: 160, top: 18, child: _buildButtonDeco(false)),
          Positioned(left: 180, bottom: 18, child: _buildButtonDeco(true)),
          Positioned(right: 200, bottom: 16, child: _buildButtonDeco(true)),
          Positioned(right: 280, top: 22, child: _buildButtonDeco(false)),
          Positioned(left: 100, top: 25, child: _buildButtonDeco(true)),
          Positioned(right: 140, bottom: 20, child: _buildButtonDeco(false)),
          Positioned(left: 230, top: 20, child: _buildButtonDeco(true)),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_arrow, color: Colors.white, size: 32),
                SizedBox(width: 16),
                Text(
                  'START',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF9C6FFF)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.share, color: Colors.white, size: 24),
                  SizedBox(width: 12),
                  Text(
                    'Share Code',
                    style: TextStyle(
                      fontSize: 20,
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

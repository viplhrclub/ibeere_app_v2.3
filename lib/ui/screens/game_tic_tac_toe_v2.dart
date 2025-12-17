import 'package:flutter/material.dart';
import 'dart:math' as math;

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  List<String> board = List.filled(9, '');
  
  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      12,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 200),
      )..repeat(reverse: true),
    );
    
    // Simulate game state
    board = ['X', 'O', 'X', 'O', 'X', 'X', 'O', 'X', 'O'];
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
              Color(0xFFE8EAF6),
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
                  _buildPlayerInfo(),
                  Expanded(
                    child: Center(
                      child: _buildGameBoard(),
                    ),
                  ),
                  _buildBottomPlayers(),
                  const SizedBox(height: 20),
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
    final shapes = [
      {'pos': const Offset(50, 200), 'color': Color(0xFF7C4DFF), 'shape': 'diamond'},
      {'pos': const Offset(650, 250), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': const Offset(100, 400), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
      {'pos': const Offset(620, 500), 'color': Color(0xFFE91E63), 'shape': 'diamond'},
      {'pos': const Offset(80, 700), 'color': Color(0xFF4CAF50), 'shape': 'circle'},
      {'pos': const Offset(660, 850), 'color': Color(0xFFFF5722), 'shape': 'circle'},
      {'pos': const Offset(120, 1000), 'color': Color(0xFF673AB7), 'shape': 'diamond'},
      {'pos': const Offset(600, 1150), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
    ];

    return Stack(
      children: shapes.asMap().entries.map((entry) {
        final index = entry.key;
        final shape = entry.value;
        if (index >= _decoControllers.length) return const SizedBox();
        
        return AnimatedBuilder(
          animation: _decoControllers[index],
          builder: (context, child) {
            return Positioned(
              left: (shape['pos'] as Offset).dx,
              top: (shape['pos'] as Offset).dy + 
                  math.sin(_decoControllers[index].value * 2 * math.pi) * 15,
              child: _buildShape(
                shape['color'] as Color,
                shape['shape'] as String,
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildShape(Color color, String shape) {
    Widget shapeWidget;
    switch (shape) {
      case 'circle':
        shapeWidget = Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        );
        break;
      case 'diamond':
        shapeWidget = Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
        break;
      case 'triangle':
        shapeWidget = CustomPaint(
          size: const Size(14, 14),
          painter: TrianglePainter(color: color),
        );
        break;
      default:
        shapeWidget = const SizedBox();
    }
    return shapeWidget;
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          _buildIconButton(Icons.grid_3x3, () {}),
          const Spacer(),
          _buildTimerBar(),
          const Spacer(),
          _buildIconButton(Icons.refresh, () {}),
        ],
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF5C6B7F),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 22),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildTimerBar() {
    return Container(
      width: 180,
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
    );
  }

  Widget _buildPlayerInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPlayerAvatar(true, 'Melissa_lin...', 102, 101),
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF7C4DFF),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.close, color: Colors.white, size: 40),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
          _buildPlayerAvatar(false, 'Isidore_Mban...', 101, 102),
        ],
      ),
    );
  }

  Widget _buildPlayerAvatar(bool isLeft, String username, int ties1, int ties2) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isLeft ? const Color(0xFF7C4DFF) : Colors.transparent,
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Container(
              color: isLeft ? const Color(0xFFFFE4E4) : const Color(0xFFFFD4D4),
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 60,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0xFF6B7FA8),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Center(
            child: Icon(Icons.circle, color: Colors.white, size: 18),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Ties $ties1 | Ties $ties2',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }

  Widget _buildGameBoard() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E8F0).withOpacity(0.6),
        borderRadius: BorderRadius.circular(30),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 9,
        itemBuilder: (context, index) {
          return _buildCell(board[index]);
        },
      ),
    );
  }

  Widget _buildCell(String value) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: value == 'X'
            ? const Icon(Icons.close, size: 50, color: Color(0xFF7C4DFF))
            : value == 'O'
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF5C6B7F),
                    ),
                  )
                : null,
      ),
    );
  }

  Widget _buildBottomPlayers() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPlayerCard(true, 'Melissa_lin...', 5),
              const SizedBox(width: 80),
              _buildPlayerCard(false, 'Isidore_Mban...', 2),
            ],
          ),
          const Text(
            'VS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(bool isWinning, String username, int wins) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: isWinning
            ? const LinearGradient(
                colors: [Color(0xFFFFC107), Color(0xFFFFD54F)],
              )
            : const LinearGradient(
                colors: [Color(0xFF4A5568), Color(0xFF5C6B7F)],
              ),
        borderRadius: BorderRadius.circular(20),
        border: isWinning
            ? Border.all(color: const Color(0xFFFF6F00), width: 2)
            : null,
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: ClipOval(
              child: Container(
                color: isWinning ? const Color(0xFFFFE4E4) : const Color(0xFFFFD4D4),
                child: const Icon(Icons.person, size: 45, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person, size: 12, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF4A5568),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.star, size: 14, color: Color(0xFFFFC107)),
                const SizedBox(width: 4),
                Text(
                  'x$wins Wins',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(
        color: Color(0xFF7C4DFF),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.grid_3x3, color: Colors.white, size: 30),
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

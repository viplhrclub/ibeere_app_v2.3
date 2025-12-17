import 'package:flutter/material.dart';
import 'dart:math' as math;

class NumberPuzzle extends StatefulWidget {
  const NumberPuzzle({super.key});

  @override
  State<NumberPuzzle> createState() => _NumberPuzzleState();
}

class _NumberPuzzleState extends State<NumberPuzzle> with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  final List<int> numbers = [15, 14, 1, 6, 9, 2, 12, 5, 8];

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
                  const SizedBox(height: 20),
                  _buildGameInfo(),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Center(
                      child: _buildGameGrid(),
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
    final decos = [
      {'pos': Offset(60, 220), 'color': Color(0xFF7C4DFF), 'shape': 'diamond'},
      {'pos': Offset(640, 240), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(110, 420), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
      {'pos': Offset(610, 520), 'color': Color(0xFFE91E63), 'shape': 'circle'},
      {'pos': Offset(90, 750), 'color': Color(0xFF4CAF50), 'shape': 'diamond'},
      {'pos': Offset(650, 900), 'color': Color(0xFFFF5722), 'shape': 'circle'},
      {'pos': Offset(130, 1050), 'color': Color(0xFF673AB7), 'shape': 'diamond'},
      {'pos': Offset(590, 1180), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
    ];

    return Stack(
      children: decos.asMap().entries.map((entry) {
        final index = entry.key;
        final deco = entry.value;
        if (index >= _decoControllers.length) return const SizedBox();
        
        return AnimatedBuilder(
          animation: _decoControllers[index],
          builder: (context, child) {
            return Positioned(
              left: (deco['pos'] as Offset).dx,
              top: (deco['pos'] as Offset).dy + 
                  math.sin(_decoControllers[index].value * 2 * math.pi) * 15,
              child: _buildShape(deco['color'] as Color, deco['shape'] as String),
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

  Widget _buildGameInfo() {
    return Column(
      children: [
        Text(
          'TOTAL',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF94A3B8),
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            '104',
            style: TextStyle(
              fontSize: 56,
              fontWeight: FontWeight.w900,
              color: Color(0xFF7B8AA7),
              letterSpacing: 2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGameGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 1.0,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          final colors = [
            Color(0xFF42A5F5),
            Color(0xFFEC407A),
            Color(0xFF9C27B0),
            Color(0xFFFFEE58),
            Color(0xFFEF5350),
            Color(0xFF283593),
          ];
          final shapes = ['triangle', 'circle', 'hexagon', 'parallelogram', 'diamond', 'square'];
          final values = [2, 20, 50, 3, 30, 1];
          
          return _buildNumberCard(colors[index], shapes[index], values[index]);
        },
      ),
    );
  }

  Widget _buildNumberCard(Color color, String shape, int value) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(150, 150),
            painter: ShapePainter(color: Colors.white.withOpacity(0.3), shape: shape),
          ),
          Text(
            value.toString(),
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomPlayers() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPlayerCard(true, 'Melissa_lin...', 5),
          const Text(
            'VS',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
          _buildPlayerCard(false, 'Isidore_Mban...', 2),
        ],
      ),
    );
  }

  Widget _buildPlayerCard(bool isWinning, String username, int wins) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: isWinning
            ? const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF9F7AEA)])
            : const LinearGradient(colors: [Color(0xFF4A5568), Color(0xFF5C6B7F)]),
        borderRadius: BorderRadius.circular(20),
        border: isWinning ? Border.all(color: Colors.white, width: 3) : null,
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 3),
            ),
            child: ClipOval(
              child: Container(
                color: const Color(0xFFFFE4E4),
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

class ShapePainter extends CustomPainter {
  final Color color;
  final String shape;
  
  ShapePainter({required this.color, required this.shape});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    switch (shape) {
      case 'triangle':
        final path = Path();
        path.moveTo(center.dx, center.dy - radius);
        path.lineTo(center.dx - radius * 0.866, center.dy + radius * 0.5);
        path.lineTo(center.dx + radius * 0.866, center.dy + radius * 0.5);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'circle':
        canvas.drawCircle(center, radius, paint);
        break;
      case 'hexagon':
        final path = Path();
        for (int i = 0; i < 6; i++) {
          final angle = (math.pi / 3) * i;
          final x = center.dx + radius * math.cos(angle);
          final y = center.dy + radius * math.sin(angle);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'parallelogram':
        final path = Path();
        path.moveTo(center.dx - radius * 0.6, center.dy - radius * 0.6);
        path.lineTo(center.dx + radius * 0.9, center.dy - radius * 0.6);
        path.lineTo(center.dx + radius * 0.6, center.dy + radius * 0.6);
        path.lineTo(center.dx - radius * 0.9, center.dy + radius * 0.6);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'diamond':
        final path = Path();
        path.moveTo(center.dx, center.dy - radius);
        path.lineTo(center.dx + radius, center.dy);
        path.lineTo(center.dx, center.dy + radius);
        path.lineTo(center.dx - radius, center.dy);
        path.close();
        canvas.drawPath(path, paint);
        break;
      case 'square':
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: center, width: radius * 1.6, height: radius * 1.6),
            const Radius.circular(12),
          ),
          paint,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

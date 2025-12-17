import 'package:flutter/material.dart';
import 'dart:math' as math;

class ScratchCardRewards extends StatefulWidget {
  const ScratchCardRewards({super.key});

  @override
  State<ScratchCardRewards> createState() => _ScratchCardRewardsState();
}

class _ScratchCardRewardsState extends State<ScratchCardRewards>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;

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
                  _buildHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          _buildRewardsCard(),
                          const SizedBox(height: 40),
                          _buildScratchCardsGrid(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
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
      {'pos': Offset(100, 180), 'color': Color(0xFF7C4DFF), 'shape': 'diamond'},
      {'pos': Offset(450, 170), 'color': Color(0xFFFFC107), 'shape': 'diamond'},
      {'pos': Offset(520, 180), 'color': Color(0xFFE91E63), 'shape': 'circle'},
      {'pos': Offset(640, 390), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
      {'pos': Offset(60, 400), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(100, 540), 'color': Color(0xFF7C4DFF), 'shape': 'diamond'},
      {'pos': Offset(450, 540), 'color': Color(0xFFE91E63), 'shape': 'diamond'},
      {'pos': Offset(60, 900), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(100, 1200), 'color': Color(0xFF4CAF50), 'shape': 'circle'},
      {'pos': Offset(450, 1220), 'color': Color(0xFFE91E63), 'shape': 'diamond'},
      {'pos': Offset(650, 1400), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          const Text(
            'Rewards',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
            ),
          ),
          IconButton(
            icon: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Color(0xFF94A3B8), size: 22),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '+500',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF475569),
                  ),
                ),
                const Text(
                  'Kauris',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Total Rewards earned',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 120,
            child: Image.asset(
              'assets/images/gift_box.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFEF4444),
                        Color(0xFFFBBF24),
                        Color(0xFF10B981),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.card_giftcard, size: 60, color: Colors.white),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScratchCardsGrid() {
    final cards = [
      {'color': Color(0xFF4C5A7D), 'revealed': false, 'amount': null},
      {'color': Color(0xFF2A3A5F), 'revealed': false, 'amount': null},
      {'color': Color(0xFF6B4A7D), 'revealed': false, 'amount': null},
      {'color': Color(0xFF7A5A6F), 'revealed': true, 'amount': 350},
      {'color': Color(0xFF2A3A5F), 'revealed': false, 'amount': null},
      {'color': Color(0xFF6B4DFF), 'revealed': false, 'amount': null},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.85,
      ),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return _buildScratchCard(
          cards[index]['color'] as Color,
          cards[index]['revealed'] as bool,
          cards[index]['amount'] as int?,
        );
      },
    );
  }

  Widget _buildScratchCard(Color color, bool isRevealed, int? amount) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
          children: [
            if (!isRevealed) ...[
              Positioned(
                top: 12,
                left: 16,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.celebration,
                      size: 40,
                      color: Colors.pink.withOpacity(0.8),
                    ),
                    const SizedBox(height: 12),
                    Icon(
                      Icons.favorite,
                      size: 30,
                      color: Colors.pink.withOpacity(0.6),
                    ),
                    const Spacer(),
                    const Text(
                      'Not Open',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            amount.toString(),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w900,
                              color: Color(0xFF6B4DFF),
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.star,
                            color: Color(0xFFFFC107),
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 100,
                      height: 80,
                      child: Image.asset(
                        'assets/images/gift.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFEF4444), Color(0xFFFBBF24)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.card_giftcard, color: Colors.white, size: 40),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
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

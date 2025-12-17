import 'package:flutter/material.dart';
import 'dart:math' as math;

class RewardsLeaderboard extends StatefulWidget {
  const RewardsLeaderboard({super.key});

  @override
  State<RewardsLeaderboard> createState() => _RewardsLeaderboardState();
}

class _RewardsLeaderboardState extends State<RewardsLeaderboard>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  String selectedTab = 'All Time';

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
                          const SizedBox(height: 32),
                          _buildTabs(),
                          const SizedBox(height: 32),
                          _buildPodium(),
                          const SizedBox(height: 40),
                          _buildLeaderboardList(),
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
      {'pos': Offset(100, 200), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(450, 210), 'color': Color(0xFF7C4DFF), 'shape': 'diamond'},
      {'pos': Offset(640, 410), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
      {'pos': Offset(60, 550), 'color': Color(0xFFE91E63), 'shape': 'circle'},
      {'pos': Offset(420, 570), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(620, 880), 'color': Color(0xFF4CAF50), 'shape': 'diamond'},
      {'pos': Offset(520, 1180), 'color': Color(0xFF00BCD4), 'shape': 'circle'},
      {'pos': Offset(100, 1240), 'color': Color(0xFFFFC107), 'shape': 'circle'},
      {'pos': Offset(610, 1260), 'color': Color(0xFFE91E63), 'shape': 'circle'},
      {'pos': Offset(520, 1480), 'color': Color(0xFF00BCD4), 'shape': 'triangle'},
      {'pos': Offset(100, 1500), 'color': Color(0xFF4CAF50), 'shape': 'diamond'},
      {'pos': Offset(540, 1280), 'color': Color(0xFFE91E63), 'shape': 'circle'},
    ];

    return Stack(
      children: decos.asMap().entries.map((entry) {
        final index = entry.key;
        if (index >= _decoControllers.length) return const SizedBox();
        
        return AnimatedBuilder(
          animation: _decoControllers[index],
          builder: (context, child) {
            return Positioned(
              left: (entry.value['pos'] as Offset).dx,
              top: (entry.value['pos'] as Offset).dy + 
                  math.sin(_decoControllers[index].value * 2 * math.pi) * 15,
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
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C4DFF),
            Color(0xFF9C27B0),
          ],
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7C4DFF).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  '+500',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Kauris',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Total Rewards earned',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: const Color(0xFF8B5CF6),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.emoji_events,
              size: 50,
              color: Color(0xFFFFC107),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final tabs = ['Weekly', 'All Time', 'Monthly'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: tabs.map((tab) {
        final isSelected = selectedTab == tab;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTab = tab;
            });
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            child: Text(
              tab,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF7C4DFF) : const Color(0xFF94A3B8),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPodium() {
    return Container(
      height: 320,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPodiumPlace(2, 'Lydia Bator', '13k', 140, const Color(0xFF64748B)),
              const SizedBox(width: 16),
              _buildPodiumPlace(1, 'Melissa', '63k', 180, const Color(0xFF7C4DFF)),
              const SizedBox(width: 16),
              _buildPodiumPlace(3, 'Omar Sy', '9.5k', 120, const Color(0xFF64748B)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPodiumPlace(int position, String name, String points, double height, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: position == 1 ? const Color(0xFF7C4DFF) : Colors.grey[300]!,
              width: 3,
            ),
            boxShadow: position == 1
                ? [
                    BoxShadow(
                      color: const Color(0xFF7C4DFF).withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFFFE4E4),
              child: const Icon(Icons.person, size: 60, color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          points,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 100,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: position == 1 ? const Color(0xFF7C4DFF) : const Color(0xFF5C6B7F),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  position.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeaderboardList() {
    final users = [
      {'rank': 4, 'name': 'Mamady Ro Keita', 'points': '8.6k'},
      {'rank': 5, 'name': 'Ibrahim Sylla', 'points': '8.4k'},
    ];

    return Column(
      children: users.map((user) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: user['rank'] == 5
                  ? [const Color(0xFF7B8AA7), const Color(0xFF6B7FA8)]
                  : [Colors.white, Colors.white],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: user['rank'] == 5 ? Colors.white.withOpacity(0.3) : const Color(0xFFE2E8F0),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    user['rank'].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: user['rank'] == 5 ? Colors.white : const Color(0xFF64748B),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: Container(
                    color: const Color(0xFFFFE4E4),
                    child: const Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: user['rank'] == 5 ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${user['points']} Points',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: user['rank'] == 5
                            ? Colors.white.withOpacity(0.8)
                            : const Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
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

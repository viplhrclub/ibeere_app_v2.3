import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeQuizFeed extends StatefulWidget {
  const HomeQuizFeed({super.key});

  @override
  State<HomeQuizFeed> createState() => _HomeQuizFeedState();
}

class _HomeQuizFeedState extends State<HomeQuizFeed>
    with TickerProviderStateMixin {
  late List<AnimationController> _decoControllers;
  String selectedTab = 'Quiz Zone';

  @override
  void initState() {
    super.initState();
    _decoControllers = List.generate(
      15,
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
              Color(0xFFFAFBFC),
              Color(0xFFF5F7FA),
            ],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  _buildTabBar(),
                  Expanded(
                    child: Stack(
                      children: [
                        _buildFloatingDecorations(),
                        _buildQuizFeed(),
                      ],
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
      {'pos': Offset(80, 20), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(140, 15), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(80, 80), 'color': Color(0xFFF59E0B), 'shape': 'circle'},
      {'pos': Offset(360, 15), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(640, 25), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(90, 170), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(640, 185), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(680, 180), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(690, 330), 'color': Color(0xFFF59E0B), 'shape': 'circle'},
      {'pos': Offset(640, 350), 'color': Color(0xFFEF4444), 'shape': 'circle'},
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

  Widget _buildTabBar() {
    final tabs = ['Quiz Zone', 'Guess the Word', 'Audio Quiz'];
    
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabs.map((tab) {
          final isSelected = selectedTab == tab;
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedTab = tab;
              });
            },
            child: Column(
              children: [
                Text(
                  tab,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? const Color(0xFF6B7FA8) : const Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(height: 8),
                if (isSelected)
                  Container(
                    width: 40,
                    height: 3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF6B7FA8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuizFeed() {
    final quizzes = [
      {
        'category': 'General Knowledge',
        'question': 'Qu\'est-ce que l\'indice des prix à la consommation (IPC) ?...',
        'hasRedBar': true,
      },
      {
        'category': 'Economy',
        'question': 'Qu\'est-ce que l\'externalité ?',
        'hasRedBar': false,
      },
      {
        'category': 'History',
        'question': 'Quel pays a construit le mur de Berlin en 1961 ?',
        'hasRedBar': false,
      },
      {
        'category': 'General Knowledge',
        'question': 'Qu\'est-ce que l\'indice des prix à la consommation (IPC) ?...',
        'hasRedBar': false,
      },
      {
        'category': 'General Knowledge',
        'question': 'Qu\'est-ce que le capital humain ?',
        'hasRedBar': false,
      },
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: quizzes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildQuizCard(
            quizzes[index]['category'] as String,
            quizzes[index]['question'] as String,
            quizzes[index]['hasRedBar'] as bool,
          ),
        );
      },
    );
  }

  Widget _buildQuizCard(String category, String question, bool hasRedBar) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
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
          _buildCardDecorations(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasRedBar)
                    Container(
                      width: 4,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  if (hasRedBar) const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 16,
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

  Widget _buildCardDecorations() {
    final decos = [
      {'pos': Offset(80, 10), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(140, 8), 'color': Color(0xFF06B6D4), 'shape': 'circle'},
      {'pos': Offset(80, 50), 'color': Color(0xFFF59E0B), 'shape': 'circle'},
      {'pos': Offset(100, 100), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(600, 10), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
      {'pos': Offset(660, 15), 'color': Color(0xFF06B6D4), 'shape': 'triangle'},
      {'pos': Offset(600, 65), 'color': Color(0xFFF59E0B), 'shape': 'circle'},
      {'pos': Offset(640, 100), 'color': Color(0xFFEF4444), 'shape': 'circle'},
      {'pos': Offset(360, 95), 'color': Color(0xFF8B5CF6), 'shape': 'diamond'},
    ];

    return Stack(
      children: decos.map((deco) {
        return Positioned(
          left: (deco['pos'] as Offset).dx,
          top: (deco['pos'] as Offset).dy,
          child: _buildStaticShape(
            deco['color'] as Color,
            deco['shape'] as String,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStaticShape(Color color, String shape) {
    switch (shape) {
      case 'circle':
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        );
      case 'diamond':
        return Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
          ),
        );
      case 'triangle':
        return CustomPaint(size: const Size(10, 10), painter: TrianglePainter(color: color));
      default:
        return const SizedBox();
    }
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

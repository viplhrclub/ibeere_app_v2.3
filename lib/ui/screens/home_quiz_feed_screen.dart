import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class HomeQuizFeedScreen extends StatefulWidget {
  const HomeQuizFeedScreen({super.key});

  static const String routeName = '/home-quiz-feed';

  @override
  State<HomeQuizFeedScreen> createState() => _HomeQuizFeedScreenState();
}

class _HomeQuizFeedScreenState extends State<HomeQuizFeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Quiz Feed', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 20, fontWeight: FontWeight.bold)),
        bottom: TabBar(
          controller: _tabController,
          labelColor: IbeereDesignTokens.primaryPurple,
          unselectedLabelColor: IbeereDesignTokens.textSecondary,
          indicatorColor: IbeereDesignTokens.primaryPurple,
          tabs: const [
            Tab(text: 'Quiz Zone'),
            Tab(text: 'Guess the Word'),
            Tab(text: 'Audio Quiz'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildQuizZone(),
          Center(child: Text('Guess the Word', style: TextStyle(color: IbeereDesignTokens.textSecondary))),
          Center(child: Text('Audio Quiz', style: TextStyle(color: IbeereDesignTokens.textSecondary))),
        ],
      ),
    );
  }

  Widget _buildQuizZone() {
    final questions = [
      {'category': 'Science', 'question': 'What is the powerhouse of the cell?', 'color': IbeereDesignTokens.primaryPurple},
      {'category': 'History', 'question': 'Who was the first president?', 'color': IbeereDesignTokens.primaryPink},
      {'category': 'Math', 'question': 'What is the square root of 144?', 'color': IbeereDesignTokens.accentCyan},
      {'category': 'Geography', 'question': 'What is the capital of France?', 'color': IbeereDesignTokens.accentGreen},
    ];

    return Stack(
      children: [
        Positioned(top: 40, right: 20, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.1), size: 80)),
        Positioned(bottom: 100, left: -20, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.1), size: 100)),
        ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            final q = questions[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 2))],
              ),
              child: Stack(
                children: [
                  Positioned(top: -10, right: 10, child: _DecorativeTriangle(color: (q['color'] as Color).withOpacity(0.1), size: 40)),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(left: BorderSide(color: q['color'] as Color, width: 4)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: (q['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            q['category'] as String,
                            style: TextStyle(color: q['color'] as Color, fontSize: 12, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          q['question'] as String,
                          style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.timer, size: 16, color: IbeereDesignTokens.textSecondary),
                            const SizedBox(width: 4),
                            Text('30s', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                            const SizedBox(width: 16),
                            Icon(Icons.help_outline, size: 16, color: IbeereDesignTokens.textSecondary),
                            const SizedBox(width: 4),
                            Text('4 options', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _DecorativeCircle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeCircle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
}

class _DecorativeTriangle extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeTriangle({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => CustomPaint(size: Size(size, size), painter: _TrianglePainter(color));
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill;
    final path = Path()..moveTo(size.width / 2, 0)..lineTo(size.width, size.height)..lineTo(0, size.height)..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

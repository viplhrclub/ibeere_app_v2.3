import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class CategorySelectionScreen extends StatelessWidget {
  const CategorySelectionScreen({super.key});

  static const String routeName = '/category-selection';

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Science', 'icon': Icons.science, 'color': IbeereDesignTokens.primaryPurple, 'questions': 250, 'locked': false},
      {'name': 'History', 'icon': Icons.history_edu, 'color': IbeereDesignTokens.primaryPink, 'questions': 180, 'locked': false},
      {'name': 'Geography', 'icon': Icons.public, 'color': IbeereDesignTokens.accentGreen, 'questions': 320, 'locked': false},
      {'name': 'Mathematics', 'icon': Icons.calculate, 'color': IbeereDesignTokens.accentYellow, 'questions': 290, 'locked': false},
      {'name': 'Sports', 'icon': Icons.sports_soccer, 'color': IbeereDesignTokens.accentCyan, 'questions': 150, 'locked': false},
      {'name': 'Entertainment', 'icon': Icons.movie, 'color': Color(0xFFF59E0B), 'questions': 200, 'locked': false},
      {'name': 'Technology', 'icon': Icons.computer, 'color': Color(0xFF3B82F6), 'questions': 180, 'locked': true},
      {'name': 'Literature', 'icon': Icons.menu_book, 'color': Color(0xFF8B5CF6), 'questions': 160, 'locked': true},
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Select Category', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: Stack(
        children: [
          Positioned(top: 20, right: -40, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPurple.withOpacity(0.05), size: 140)),
          Positioned(bottom: 60, left: -50, child: _DecorativeCircle(color: IbeereDesignTokens.primaryPink.withOpacity(0.05), size: 160)),
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final cat = categories[index];
              final isLocked = cat['locked'] as bool;

              return GestureDetector(
                onTap: () {
                  if (!isLocked) {
                    Navigator.pushNamed(context, '/quiz-playing');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Premium category - Unlock required')),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Stack(
                    children: [
                      if (isLocked)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: IbeereDesignTokens.accentYellow,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.lock, color: Colors.white, size: 16),
                          ),
                        ),
                      Opacity(
                        opacity: isLocked ? 0.5 : 1.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: (cat['color'] as Color).withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(cat['icon'] as IconData, size: 36, color: cat['color'] as Color),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              cat['name'] as String,
                              style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.question_answer, size: 14, color: IbeereDesignTokens.textSecondary),
                                const SizedBox(width: 4),
                                Text(
                                  '${cat['questions']} Q',
                                  style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
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

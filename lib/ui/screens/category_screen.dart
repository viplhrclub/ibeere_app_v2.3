import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final List<_Category> _categories = [
    _Category(
      id: '1',
      title: 'Science',
      description: 'Physics, Chemistry, Biology',
      quizzes: 45,
      icon: Icons.science,
      color: const Color(0xFF7C3AED),
      passRate: 92,
    ),
    _Category(
      id: '2',
      title: 'Mathematics',
      description: 'Algebra, Geometry, Calculus',
      quizzes: 52,
      icon: Icons.calculate,
      color: const Color(0xFF3B82F6),
      passRate: 88,
    ),
    _Category(
      id: '3',
      title: 'History',
      description: 'World, Ancient, Modern',
      quizzes: 38,
      icon: Icons.history,
      color: const Color(0xFFDC2626),
      passRate: 85,
    ),
    _Category(
      id: '4',
      title: 'Geography',
      description: 'Countries, Capitals, Maps',
      quizzes: 42,
      icon: Icons.public,
      color: const Color(0xFF059669),
      passRate: 87,
    ),
    _Category(
      id: '5',
      title: 'Literature',
      description: 'Books, Authors, Classics',
      quizzes: 35,
      icon: Icons.library_books,
      color: const Color(0xFFEA580C),
      passRate: 78,
    ),
    _Category(
      id: '6',
      title: 'Technology',
      description: 'IT, Programming, Networks',
      quizzes: 48,
      icon: Icons.computer,
      color: const Color(0xFF8B5CF6),
      passRate: 91,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: const IbeereAppBar(
        title: 'Quiz Categories',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose a category to begin',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: DesignTokens.spaceMd,
                mainAxisSpacing: DesignTokens.spaceMd,
              ),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return _CategoryCard(category: category);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {

  const _CategoryCard({required this.category});
  final _Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to quizzes in category
      },
      child: IbeereCard(
        backgroundColor: category.color,
        elevation: 2,
        padding: const EdgeInsets.all(DesignTokens.spaceMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              category.icon,
              size: 32,
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightBold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Text(
                  '${category.quizzes} quizzes',
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Row(
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    const SizedBox(width: DesignTokens.spaceSm),
                    Text(
                      '${category.passRate}% pass',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {

  _Category({
    required this.id,
    required this.title,
    required this.description,
    required this.quizzes,
    required this.icon,
    required this.color,
    required this.passRate,
  });
  final String id;
  final String title;
  final String description;
  final int quizzes;
  final IconData icon;
  final Color color;
  final int passRate;
}


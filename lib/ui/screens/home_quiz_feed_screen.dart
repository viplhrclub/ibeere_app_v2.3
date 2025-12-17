import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeQuizFeedScreen extends StatefulWidget {
  const HomeQuizFeedScreen({super.key});

  @override
  State<HomeQuizFeedScreen> createState() => _HomeQuizFeedScreenState();
}

class _HomeQuizFeedScreenState extends State<HomeQuizFeedScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  bool _isLoading = false;
  String _errorMessage = '';
  int _selectedTab = 0;

  final List<_QuizCard> _quizzes = [
    _QuizCard(
      title: 'Science Challenge',
      category: 'Science',
      questions: 20,
      difficulty: 'Medium',
      participants: '2.5K',
      color: const Color(0xFF6C63FF),
      icon: Icons.science,
    ),
    _QuizCard(
      title: 'History Trivia',
      category: 'History',
      questions: 15,
      difficulty: 'Easy',
      participants: '1.8K',
      color: const Color(0xFFEC4899),
      icon: Icons.history_edu,
    ),
    _QuizCard(
      title: 'Math Masters',
      category: 'Math',
      questions: 25,
      difficulty: 'Hard',
      participants: '3.2K',
      color: const Color(0xFF10B981),
      icon: Icons.calculate,
    ),
    _QuizCard(
      title: 'Geography Quiz',
      category: 'Geography',
      questions: 18,
      difficulty: 'Medium',
      participants: '1.5K',
      color: const Color(0xFFFFB800),
      icon: Icons.public,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _revealController.forward();
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: FadeTransition(
          opacity: _revealController,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello, John! 👋',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Ready for a challenge?',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.pushNamed(context, '/search');
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                HapticFeedback.lightImpact();
                                Navigator.pushNamed(context, '/notification');
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6C63FF), Color(0xFFA78BFA)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Daily Challenge',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Complete today\'s quiz and earn 200 coins!',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.emoji_events,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    _TabButton(
                      label: 'All',
                      isSelected: _selectedTab == 0,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() => _selectedTab = 0);
                      },
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'Popular',
                      isSelected: _selectedTab == 1,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() => _selectedTab = 1);
                      },
                    ),
                    const SizedBox(width: 8),
                    _TabButton(
                      label: 'New',
                      isSelected: _selectedTab == 2,
                      onTap: () {
                        HapticFeedback.lightImpact();
                        setState(() => _selectedTab = 2);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _quizzes.length,
                  itemBuilder: (context, index) {
                    return _QuizCardWidget(
                      quiz: _quizzes[index],
                      onTap: () {
                        HapticFeedback.mediumImpact();
                        Navigator.pushNamed(context, '/quiz');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}

class _QuizCard {
  final String title;
  final String category;
  final int questions;
  final String difficulty;
  final String participants;
  final Color color;
  final IconData icon;

  _QuizCard({
    required this.title,
    required this.category,
    required this.questions,
    required this.difficulty,
    required this.participants,
    required this.color,
    required this.icon,
  });
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6C63FF)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _QuizCardWidget extends StatelessWidget {
  final _QuizCard quiz;
  final VoidCallback onTap;

  const _QuizCardWidget({
    required this.quiz,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: quiz.color.withOpacity(0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: quiz.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      quiz.icon,
                      color: quiz.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          quiz.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          quiz.category,
                          style: TextStyle(
                            color: quiz.color,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: quiz.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      quiz.difficulty,
                      style: TextStyle(
                        color: quiz.color,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${quiz.questions} Questions',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Icon(
                    Icons.people_outline,
                    size: 16,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${quiz.participants} played',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
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
}

class _BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xFF252542),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(icon: Icons.home, label: 'Home', isActive: true),
          _NavItem(icon: Icons.explore, label: 'Explore', isActive: false),
          _NavItem(icon: Icons.emoji_events, label: 'Compete', isActive: false),
          _NavItem(icon: Icons.person, label: 'Profile', isActive: false),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF6C63FF) : Colors.white.withOpacity(0.5),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF6C63FF) : Colors.white.withOpacity(0.5),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

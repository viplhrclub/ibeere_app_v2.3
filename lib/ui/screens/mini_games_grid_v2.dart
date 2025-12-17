import 'package:flutter/material.dart';

class MiniGamesGrid extends StatelessWidget {
  const MiniGamesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF5F3FF),
              Color(0xFFE8E4F9),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: _buildGamesGrid(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          const Text(
            'Mini Games',
            style: TextStyle(
              fontSize: 24,
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
              child: const Icon(
                Icons.close,
                color: Color(0xFF94A3B8),
                size: 22,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildGamesGrid() {
    final games = [
      {
        'name': 'Trivia\nWORLD',
        'color': Color(0xFFFFC107),
        'icon': Icons.quiz,
      },
      {
        'name': 'Number\nPUZZLE',
        'color': Color(0xFF26A69A),
        'icon': Icons.grid_3x3,
      },
      {
        'name': 'Trivia\nWORLD II',
        'color': Color(0xFFD81B60),
        'icon': Icons.school,
      },
      {
        'name': 'Memory\nGAMES',
        'color': Color(0xFF42A5F5),
        'icon': Icons.psychology,
      },
      {
        'name': 'Tic Tac Toe\nGAME',
        'color': Color(0xFF283593),
        'icon': Icons.grid_4x4,
      },
      {
        'name': 'Maths\nGAMES',
        'color': Color(0xFF7C4DFF),
        'icon': Icons.calculate,
      },
      {
        'name': '2048\nGAME',
        'color': Color(0xFF00BFA5),
        'icon': Icons.apps,
      },
      {
        'name': 'Focus\nGAME',
        'color': Color(0xFFE91E63),
        'icon': Icons.center_focus_strong,
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1.0,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return _buildGameCard(
          games[index]['name'] as String,
          games[index]['color'] as Color,
          games[index]['icon'] as IconData,
        );
      },
    );
  }

  Widget _buildGameCard(String name, Color color, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              right: 30,
              child: Icon(
                icon,
                size: 80,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.2,
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
}

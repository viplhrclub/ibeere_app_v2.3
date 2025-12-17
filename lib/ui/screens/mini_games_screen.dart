import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MiniGamesScreen extends StatefulWidget {
  const MiniGamesScreen({super.key});

  @override
  State<MiniGamesScreen> createState() => _MiniGamesScreenState();
}

class _MiniGamesScreenState extends State<MiniGamesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  bool _isLoading = false;
  String _errorMessage = '';

  final List<_MiniGame> _games = [
    _MiniGame(
      name: 'Tic Tac Toe',
      description: 'Classic X and O game',
      icon: Icons.grid_3x3,
      color: Color(0xFF6C63FF),
      route: '/game-tic-tac-toe',
      players: '2 Players',
    ),
    _MiniGame(
      name: 'Number Puzzle',
      description: 'Match numbers to win',
      icon: Icons.grid_4x4,
      color: Color(0xFFEC4899),
      route: '/game-number-puzzle',
      players: '1 Player',
    ),
    _MiniGame(
      name: 'Memory Cards',
      description: 'Find matching pairs',
      icon: Icons.layers,
      color: Color(0xFF10B981),
      route: '/game-memory-cards',
      players: '1 Player',
    ),
    _MiniGame(
      name: 'Guess the Word',
      description: 'Word guessing challenge',
      icon: Icons.abc,
      color: Color(0xFFFFB800),
      route: '/guessTheWord',
      players: '1 Player',
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Mini Games',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FadeTransition(
        opacity: _revealController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Take a Break',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Play fun mini games while learning',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.85,
                ),
                itemCount: _games.length,
                itemBuilder: (context, index) {
                  return _MiniGameCard(
                    game: _games[index],
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      Navigator.pushNamed(context, _games[index].route);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniGame {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final String route;
  final String players;

  _MiniGame({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
    required this.players,
  });
}

class _MiniGameCard extends StatelessWidget {
  final _MiniGame game;
  final VoidCallback onTap;

  const _MiniGameCard({
    required this.game,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              game.color.withOpacity(0.3),
              game.color.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: game.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: game.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                game.icon,
                size: 40,
                color: game.color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              game.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              game.description,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: game.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                game.players,
                style: TextStyle(
                  color: game.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

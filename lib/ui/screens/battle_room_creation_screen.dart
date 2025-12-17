import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleRoomCreationScreen extends StatefulWidget {
  const BattleRoomCreationScreen({super.key});

  static const String routeName = '/battle-room-creation';

  @override
  State<BattleRoomCreationScreen> createState() => _BattleRoomCreationScreenState();
}

class _BattleRoomCreationScreenState extends State<BattleRoomCreationScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'General Category';
  int _selectedCoins = 5;
  double _currentCoins = 693000;

  final List<int> _coinOptions = [5, 10, 15, 50, 100];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 80, right: 20, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.12), size: 60)),
            Positioned(top: 250, left: 30, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.12), size: 45)),
            Positioned(bottom: 350, right: 50, child: _DecorativeSquare(color: Color(0xFFFBBF24).withOpacity(0.12), size: 35)),
            Positioned(bottom: 200, left: 40, child: _DecorativeTriangle(color: Color(0xFF06B6D4).withOpacity(0.12), size: 40)),
            Positioned(top: 400, right: 100, child: _DecorativeCircle(color: Color(0xFFEF4444).withOpacity(0.12), size: 50)),
            Column(
              children: [
                _buildTopTabs(),
                const SizedBox(height: 32),
                _buildCategorySelector(),
                const SizedBox(height: 24),
                _buildCoinSelector(),
                const SizedBox(height: 32),
                _buildCurrentCoins(),
                const SizedBox(height: 40),
                _buildCreateRoomButton(),
                const SizedBox(height: 20),
                _buildPlaySoloButton(),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(0),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  gradient: _tabController.index == 0
                      ? LinearGradient(colors: [IbeereDesignTokens.primaryPurple, Color(0xFF7C3AED)])
                      : null,
                  color: _tabController.index == 0 ? null : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  'CREATE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _tabController.index == 0 ? Colors.white : IbeereDesignTokens.textSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: GestureDetector(
              onTap: () => _tabController.animateTo(1),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8)],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'JOIN',
                      style: TextStyle(
                        color: Color(0xFF5B6B8C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.backgroundLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.close, size: 16, color: IbeereDesignTokens.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _selectedCategory,
            style: TextStyle(
              color: Color(0xFF5B6B8C),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.keyboard_arrow_down, color: Color(0xFF5B6B8C)),
        ],
      ),
    );
  }

  Widget _buildCoinSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _coinOptions.map((coins) {
          final isSelected = coins == _selectedCoins;
          return GestureDetector(
            onTap: () => setState(() => _selectedCoins = coins),
            child: Container(
              width: 64,
              height: 80,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: [IbeereDesignTokens.primaryPurple, Color(0xFF7C3AED)])
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected
                    ? [BoxShadow(color: IbeereDesignTokens.primaryPurple.withOpacity(0.4), blurRadius: 15, offset: Offset(0, 6))]
                    : [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$coins',
                    style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF5B6B8C),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Icon(
                    Icons.monetization_on,
                    color: isSelected ? Colors.white : Color(0xFF5B6B8C),
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCurrentCoins() {
    return Column(
      children: [
        Text(
          'Current Coins',
          style: TextStyle(
            color: IbeereDesignTokens.textTertiary,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(left: 120, top: -8, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.15), size: 30)),
            Positioned(right: 110, top: 8, child: _DecorativeSquare(color: Color(0xFFEC4899).withOpacity(0.15), size: 20)),
            Positioned(left: 100, bottom: -5, child: _DecorativeTriangle(color: Color(0xFFFBBF24).withOpacity(0.15), size: 25)),
            Positioned(right: 130, bottom: 5, child: _DecorativeCircle(color: Color(0xFF8B5CF6).withOpacity(0.15), size: 35)),
            Text(
              '${(_currentCoins / 1000).toStringAsFixed(0)}k',
              style: TextStyle(
                color: Color(0xFF5B6B8C),
                fontSize: 48,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCreateRoomButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [IbeereDesignTokens.primaryRed, Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryRed.withOpacity(0.4), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Stack(
        children: [
          Positioned(top: 12, right: 60, child: Container(width: 20, height: 20, decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle))),
          Positioned(bottom: 15, left: 70, child: Container(width: 15, height: 15, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle))),
          Positioned(top: 20, left: 120, child: _DecorativeSquare(color: Colors.white.withOpacity(0.12), size: 12)),
          Positioned(bottom: 20, right: 100, child: _DecorativeTriangle(color: Colors.white.withOpacity(0.1), size: 18)),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/battle-countdown'),
              borderRadius: BorderRadius.circular(34),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 32),
                    const SizedBox(width: 12),
                    Text(
                      'Create Room',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaySoloButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [IbeereDesignTokens.primaryPurple, Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(34),
        boxShadow: [BoxShadow(color: IbeereDesignTokens.primaryPurple.withOpacity(0.3), blurRadius: 15, offset: Offset(0, 6))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, '/quiz-battle'),
          borderRadius: BorderRadius.circular(34),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
              borderRadius: BorderRadius.circular(34),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  Text(
                    'Play Solo',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
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

class _DecorativeSquare extends StatelessWidget {
  final Color color;
  final double size;
  const _DecorativeSquare({required this.color, required this.size});
  @override
  Widget build(BuildContext context) => Container(width: size, height: size, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)));
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
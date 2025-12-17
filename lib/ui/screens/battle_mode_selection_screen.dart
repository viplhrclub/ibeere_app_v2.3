import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleModeSelectionScreen extends StatelessWidget {
  const BattleModeSelectionScreen({super.key});

  static const String routeName = '/battle-mode-selection';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(top: 60, right: 20, child: _DecorativeCircle(color: Color(0xFFEC4899).withOpacity(0.12), size: 70)),
            Positioned(top: 180, left: 30, child: _DecorativeCircle(color: Color(0xFF10B981).withOpacity(0.12), size: 50)),
            Positioned(bottom: 300, right: 50, child: _DecorativeSquare(color: Color(0xFF06B6D4).withOpacity(0.12), size: 40)),
            Positioned(bottom: 200, left: 60, child: _DecorativeCircle(color: Color(0xFFFBBF24).withOpacity(0.12), size: 55)),
            Positioned(top: 350, right: 100, child: _DecorativeSquare(color: Color(0xFF8B5CF6).withOpacity(0.12), size: 35)),
            Positioned(bottom: 450, left: 40, child: _DecorativeTriangle(color: Color(0xFFEF4444).withOpacity(0.12), size: 38)),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8, offset: Offset(0, 2))],
                          ),
                          child: Icon(Icons.close, color: IbeereDesignTokens.textPrimary, size: 24),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildBattleModeCard(
                        context,
                        title: '1V/S1\nBATTLE',
                        gradient: [IbeereDesignTokens.accentGreen, Color(0xFF059669)],
                        onTap: () => _showRoomCreationScreen(context, true),
                      ),
                      const SizedBox(height: 24),
                      _buildBattleModeCard(
                        context,
                        title: 'GROUP\nBATTLE',
                        gradient: [IbeereDesignTokens.primaryPink, Color(0xFFDB2777)],
                        onTap: () => _showRoomCreationScreen(context, false),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBattleModeCard(BuildContext context, {required String title, required List<Color> gradient, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 180,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32),
          boxShadow: [BoxShadow(color: gradient[0].withOpacity(0.4), blurRadius: 20, offset: Offset(0, 10))],
        ),
        child: Stack(
          children: [
            Positioned(top: 20, right: 30, child: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle))),
            Positioned(bottom: 30, left: 40, child: Container(width: 45, height: 45, decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), shape: BoxShape.circle))),
            Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRoomCreationScreen(BuildContext context, bool isOneVsOne) {
    Navigator.pushNamed(context, '/battle-room-selection');
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
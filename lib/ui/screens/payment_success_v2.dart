import 'package:flutter/material.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
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
              Color(0xFFF1F5F9),
              Color(0xFFE0E7FF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, _slideAnimation.value),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        _buildSuccessCard(),
                        const SizedBox(height: 24),
                        _buildSharingCard(),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildGotItButton(context),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFBBF24), Color(0xFFF59E0B)],
              ),
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFD97706), width: 2),
            ),
            child: const Center(
              child: Text(
                '¢',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'STARTER',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF94A3B8),
                  letterSpacing: 1,
                ),
              ),
              Row(
                children: [
                  Text(
                    '1K',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF475569),
                    ),
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Kauris',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
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

  Widget _buildSuccessCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildFloatingDeco(20, 20, const Color(0xFFFBBF24), true),
          _buildFloatingDeco(320, 80, const Color(0xFF34D399), false),
          _buildFloatingDeco(60, 100, const Color(0xFF818CF8), false),
          _buildFloatingDeco(280, 20, const Color(0xFFF59E0B), true),
          _buildFloatingDeco(340, 120, const Color(0xFFEF4444), true),
          _buildFloatingDeco(100, 130, const Color(0xFF06B6D4), true),
          Positioned(
            top: 10,
            right: 30,
            child: Icon(
              Icons.card_giftcard,
              color: const Color(0xFFEF4444),
              size: 40,
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: Icon(
              Icons.celebration,
              color: const Color(0xFFEF4444),
              size: 32,
            ),
          ),
          Positioned(
            bottom: 20,
            right: 40,
            child: Icon(
              Icons.send,
              color: const Color(0xFF06B6D4),
              size: 28,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'It\'s done ! Order Successfully!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '1K of Kauris have been added to your account',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSharingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          _buildFloatingDeco(30, 15, const Color(0xFFFBBF24), true),
          _buildFloatingDeco(310, 70, const Color(0xFF34D399), false),
          _buildFloatingDeco(70, 90, const Color(0xFF818CF8), true),
          _buildFloatingDeco(290, 25, const Color(0xFFEF4444), true),
          _buildFloatingDeco(330, 110, const Color(0xFF06B6D4), true),
          _buildFloatingDeco(110, 120, const Color(0xFFF59E0B), false),
          Positioned(
            bottom: 25,
            right: 30,
            child: Icon(
              Icons.send,
              color: const Color(0xFF06B6D4),
              size: 32,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sharing Kauris with friends!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You can gift Kauris to friends! It\'s this way!',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingDeco(double left, double top, Color color, bool isCircle) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        width: isCircle ? 8 : 10,
        height: isCircle ? 8 : 10,
        decoration: BoxDecoration(
          color: color.withOpacity(0.6),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isCircle ? null : BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildGotItButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      height: 80,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF7C2D7C),
            Color(0xFF5B2869),
          ],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF5B2869).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(left: 30, top: 15, child: _buildDecoShape(10, false)),
          Positioned(right: 50, top: 10, child: _buildDecoShape(8, true)),
          Positioned(left: 70, bottom: 20, child: _buildDecoShape(12, false)),
          Positioned(right: 80, bottom: 15, child: _buildDecoShape(10, true)),
          Positioned(right: 130, top: 25, child: _buildDecoShape(14, false)),
          Positioned(left: 100, top: 20, child: _buildDecoShape(8, true)),
          Center(
            child: Container(
              width: 200,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withOpacity(0.5),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(50),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/home');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.celebration, color: Colors.white, size: 22),
                      SizedBox(width: 12),
                      Text(
                        'GOT IT',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecoShape(double size, bool isCircle) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(2),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math' as math;

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection>
    with TickerProviderStateMixin {
  late AnimationController _floatingController;
  late List<AnimationController> _bubbleControllers;

  @override
  void initState() {
    super.initState();
    _floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bubbleControllers = List.generate(
      8,
      (index) => AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 2000 + index * 300),
      )..repeat(reverse: true),
    );
  }

  @override
  void dispose() {
    _floatingController.dispose();
    for (var controller in _bubbleControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFF8E7),
              Color(0xFFFFF0DC),
            ],
          ),
        ),
        child: Stack(
          children: [
            _buildFloatingBubbles(),
            SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          _buildQuestionMark(),
                          const SizedBox(height: 40),
                          _buildTitle(),
                          const SizedBox(height: 60),
                          _buildLanguageFlags(),
                          const SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                  _buildContinueButton(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBubbles() {
    return Stack(
      children: [
        _buildBubble(0, const Offset(80, 200), 60, '?'),
        _buildBubble(1, const Offset(600, 180), 50, '?'),
        _buildBubble(2, const Offset(50, 550), 45, '?'),
        _buildBubble(3, const Offset(650, 620), 55, '?'),
        _buildBubble(4, const Offset(180, 1150), 50, '?'),
        _buildBubble(5, const Offset(580, 1100), 60, '?'),
      ],
    );
  }

  Widget _buildBubble(int index, Offset position, double size, String text) {
    if (index >= _bubbleControllers.length) return const SizedBox();
    return AnimatedBuilder(
      animation: _bubbleControllers[index],
      builder: (context, child) {
        return Positioned(
          left: position.dx,
          top: position.dy + math.sin(_bubbleControllers[index].value * 2 * math.pi) * 20,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD54F).withOpacity(0.6),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFFFB300),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: size * 0.6,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestionMark() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            0,
            math.sin(_floatingController.value * 2 * math.pi) * 15,
          ),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(0xFF7C3AED),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF7C3AED).withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                '?',
                style: TextStyle(
                  fontSize: 70,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'Test Your Knowledge',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF4A5F7F),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'Select Your Preferred Language',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7FA8),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageFlags() {
    final languages = [
      {'flag': '🇬🇧', 'name': 'English', 'code': 'en'},
      {'flag': '🇪🇸', 'name': 'Español', 'code': 'es'},
      {'flag': '🇫🇷', 'name': 'Français', 'code': 'fr'},
      {'flag': '🇩🇪', 'name': 'Deutsch', 'code': 'de'},
      {'flag': '🇮🇹', 'name': 'Italiano', 'code': 'it'},
      {'flag': '🇵🇹', 'name': 'Português', 'code': 'pt'},
      {'flag': '🇷🇺', 'name': 'Русский', 'code': 'ru'},
      {'flag': '🇨🇳', 'name': '中文', 'code': 'zh'},
      {'flag': '🇯🇵', 'name': '日本語', 'code': 'ja'},
      {'flag': '🇰🇷', 'name': '한국어', 'code': 'ko'},
      {'flag': '🇦🇪', 'name': 'العربية', 'code': 'ar'},
      {'flag': '🇮🇳', 'name': 'हिंदी', 'code': 'hi'},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: languages.length,
        itemBuilder: (context, index) {
          return _buildLanguageCard(
            languages[index]['flag']!,
            languages[index]['name']!,
          );
        },
      ),
    );
  }

  Widget _buildLanguageCard(String flag, String name) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 50),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4A5F7F),
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/profile-setup');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7C3AED),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            elevation: 8,
            shadowColor: const Color(0xFF7C3AED).withOpacity(0.5),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}

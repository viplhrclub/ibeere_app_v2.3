import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<_OnboardingPage> _pages = [
    _OnboardingPage(
      title: 'Welcome to Ibeere',
      description: 'Test your knowledge with thousands of quizzes',
      icon: Icons.quiz,
      color: DesignTokens.primary,
    ),
    _OnboardingPage(
      title: 'Learn & Practice',
      description: 'Practice with different difficulty levels',
      icon: Icons.school,
      color: const Color(0xFF7C3AED),
    ),
    _OnboardingPage(
      title: 'Compete & Win',
      description: 'Challenge friends and climb the leaderboard',
      icon: Icons.emoji_events,
      color: DesignTokens.success,
    ),
    _OnboardingPage(
      title: 'Earn Rewards',
      description: 'Unlock badges and earn points',
      icon: Icons.card_giftcard,
      color: DesignTokens.warning,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48),
                  Text(
                    'Ibeere',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeXl,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: DesignTokens.primary,
                    ),
                  ),
                  if (_currentPage < _pages.length - 1)
                    IbeereTextButton(
                      label: 'Skip',
                      onPressed: () {
                        _pageController.jumpToPage(_pages.length - 1);
                      },
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
            ),

            // Pages
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return _OnboardingPageWidget(page: page);
                },
              ),
            ),

            // Indicators
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => Container(
                    width: index == _currentPage ? 28 : 8,
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == _currentPage
                          ? const Color(0xFF007AFF)
                          : const Color(0xFFE5E7EB),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: IbeereSecondaryButton(
                        label: 'Back',
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: DesignTokens.spaceMd),
                  Expanded(
                    child: IbeerePrimaryButton(
                      label: _currentPage == _pages.length - 1
                          ? 'Get Started'
                          : 'Next',
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          // Navigate to main app
                          Navigator.of(context).pushReplacementNamed('/home');
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
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

class _OnboardingPageWidget extends StatelessWidget {

  const _OnboardingPageWidget({required this.page});
  final _OnboardingPage page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              page.icon,
              size: 100,
              color: page.color,
            ),
          ),
          const SizedBox(height: DesignTokens.spaceXxl),
          Text(
            page.title,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeXl,
              fontWeight: DesignTokens.fontWeightBold,
              color: DesignTokens.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: DesignTokens.spaceMd),
          Text(
            page.description,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: Colors.grey[600],
              height: DesignTokens.lineHeightRelaxed,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _OnboardingPage {

  _OnboardingPage({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
  final String title;
  final String description;
  final IconData icon;
  final Color color;
}


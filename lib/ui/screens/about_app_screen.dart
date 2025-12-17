import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'About App',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          children: [
            const SizedBox(height: DesignTokens.spaceLg),

            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: DesignTokens.primary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  '📚',
                  style: TextStyle(fontSize: 48),
                ),
              ),
            ),
            const SizedBox(height: DesignTokens.spaceLg),

            // App Name
            Text(
              'Ibeere Quiz App',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: DesignTokens.spaceSm),

            // Version
            Text(
              'Version 2.0.1 (Build 124)',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Description
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(color: Colors.grey[200] ?? Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  Text(
                    'Ibeere is a comprehensive quiz and learning platform designed to help students master various subjects through interactive quizzes, engaging challenges, and personalized learning experiences.',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: Colors.grey[700],
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            // Features
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                border: Border.all(color: Colors.grey[200] ?? Colors.grey),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Key Features',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  ...[
                    'Interactive quizzes with instant feedback',
                    'Competitive battle mode with real players',
                    'Achievement badges and leaderboards',
                    'Personalized learning recommendations',
                    'Offline quiz support (Premium)',
                    'Detailed performance analytics',
                  ].map((feature) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            color: DesignTokens.primary,
                            size: 20,
                          ),
                          const SizedBox(width: DesignTokens.spaceMd),
                          Expanded(
                            child: Text(
                              feature,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeBase,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXl),

            // Credits
            Container(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Credits',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeLg,
                      fontWeight: DesignTokens.fontWeightBold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceMd),
                  _creditItem('Development', 'Flutter Team'),
                  _creditItem('Design', 'Ibeere Design System'),
                  _creditItem('Backend', 'Firebase'),
                ],
              ),
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Legal Links
            Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: DesignTokens.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: DesignTokens.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Contact Us',
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      color: DesignTokens.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: DesignTokens.spaceXxl),

            // Copyright
            Text(
              '© 2025 Ibeere. All rights reserved.',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _creditItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: Colors.blue[900],
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }
}


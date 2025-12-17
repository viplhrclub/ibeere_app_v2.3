import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({Key? key}) : super(key: key);

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
  int _expandedIndex = -1;
  final List<Map<String, String>> _faqs = [
    {
      'question': 'How do I reset my password?',
      'answer': 'Go to the Sign In screen and tap "Forgot Password?". Enter your email address and follow the instructions sent to your email.'
    },
    {
      'question': 'Can I download quizzes for offline mode?',
      'answer': 'Yes, with a Premium subscription, you can download quizzes to take offline. Go to any quiz and tap the download icon.'
    },
    {
      'question': 'How are my scores calculated?',
      'answer': 'Your score is based on correct answers divided by total questions multiplied by 100. Time taken does not affect your score.'
    },
    {
      'question': 'Can I delete my account?',
      'answer': 'Yes, you can delete your account from Settings > Account. Note that this action is permanent and cannot be undone.'
    },
    {
      'question': 'How do I earn badges and achievements?',
      'answer': 'Badges are earned by completing specific milestones like completing 10 quizzes, maintaining a 7-day streak, or scoring 90%+ in a category.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Help & Support',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Options
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Get Help',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  _helpOption(
                    icon: Icons.email_rounded,
                    title: 'Email Support',
                    subtitle: 'support@ibeere.com',
                    onTap: () {},
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  _helpOption(
                    icon: Icons.chat_rounded,
                    title: 'Live Chat',
                    subtitle: 'Available 9 AM - 9 PM IST',
                    onTap: () {},
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  _helpOption(
                    icon: Icons.phone_rounded,
                    title: 'Call Us',
                    subtitle: '+91 9876 543 210',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            Divider(height: 0, thickness: 1),

            // FAQ Section
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequently Asked Questions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  ..._faqs.asMap().entries.map((entry) {
                    final index = entry.key;
                    final faq = entry.value;
                    final isExpanded = _expandedIndex == index;

                    return Container(
                      margin: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(
                          color: isExpanded ? DesignTokens.primary : (Colors.grey[200] ?? Colors.grey),
                          width: isExpanded ? 2 : 1,
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () => setState(() => _expandedIndex = isExpanded ? -1 : index),
                        child: Padding(
                          padding: EdgeInsets.all(DesignTokens.spaceMd),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      faq['question'] ?? '',
                                      style: TextStyle(
                                        fontSize: DesignTokens.fontSizeBase,
                                        fontWeight: DesignTokens.fontWeightBold,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                                    color: DesignTokens.primary,
                                  ),
                                ],
                              ),
                              if (isExpanded) ...[
                                SizedBox(height: DesignTokens.spaceMd),
                                Text(
                                  faq['answer'] ?? '',
                                  style: TextStyle(
                                    fontSize: DesignTokens.fontSizeBase,
                                    color: Colors.grey[700],
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),

            // Additional Resources
            Padding(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(height: 0, thickness: 1),
                  SizedBox(height: DesignTokens.spaceLg),
                  Text(
                    'More Resources',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceMd),
                  _resourceLink('About Ibeere', Icons.info_rounded),
                  SizedBox(height: DesignTokens.spaceMd),
                  _resourceLink('Terms & Conditions', Icons.description_rounded),
                  SizedBox(height: DesignTokens.spaceMd),
                  _resourceLink('Privacy Policy', Icons.privacy_tip_rounded),
                  SizedBox(height: DesignTokens.spaceMd),
                  _resourceLink('Community Guidelines', Icons.groups_rounded),
                  SizedBox(height: DesignTokens.spaceXxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _helpOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(DesignTokens.spaceMd),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: Colors.grey[200] ?? Colors.grey),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Icon(icon, color: DesignTokens.primary, size: 24),
            ),
            SizedBox(width: DesignTokens.spaceMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeBase,
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: DesignTokens.fontSizeSm,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_rounded, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _resourceLink(String title, IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: DesignTokens.spaceMd,
          vertical: DesignTokens.spaceSm,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: Colors.grey[200] ?? Colors.grey),
        ),
        child: Row(
          children: [
            Icon(icon, color: DesignTokens.primary, size: 20),
            SizedBox(width: DesignTokens.spaceMd),
            Text(
              title,
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: DesignTokens.primary,
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_rounded, color: Colors.grey[400], size: 18),
          ],
        ),
      ),
    );
  }
}

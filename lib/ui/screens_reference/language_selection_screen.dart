import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'en';
  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English', 'flag': '🇬🇧'},
    {'code': 'hi', 'name': 'हिंदी', 'flag': '🇮🇳'},
    {'code': 'es', 'name': 'Español', 'flag': '🇪🇸'},
    {'code': 'fr', 'name': 'Français', 'flag': '🇫🇷'},
    {'code': 'de', 'name': 'Deutsch', 'flag': '🇩🇪'},
    {'code': 'ja', 'name': '日本語', 'flag': '🇯🇵'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(DesignTokens.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: DesignTokens.spaceXl),
              Text(
                'Select Language',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: DesignTokens.primary,
                  fontWeight: DesignTokens.fontWeightBold,
                ),
              ),
              SizedBox(height: DesignTokens.spaceSm),
              Text(
                'Choose your preferred language',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: DesignTokens.spaceXxl),

              // Language Options
              ...(_languages.map((language) {
                final isSelected = _selectedLanguage == language['code'];
                return Padding(
                  padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedLanguage = language['code']!),
                    child: Container(
                      padding: EdgeInsets.all(DesignTokens.spaceLg),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? DesignTokens.primary : (Colors.grey[300] ?? Colors.grey),
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: DesignTokens.primary.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                language['flag']!,
                                style: TextStyle(fontSize: 32),
                              ),
                              SizedBox(width: DesignTokens.spaceMd),
                              Text(
                                language['name']!,
                                style: TextStyle(
                                  fontSize: DesignTokens.fontSizeBase,
                                  fontWeight: DesignTokens.fontWeightBold,
                                ),
                              ),
                            ],
                          ),
                          if (isSelected)
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: DesignTokens.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList()),

              SizedBox(height: DesignTokens.spaceXxl),

              // Continue Button
              IbeerePrimaryButton(
                label: 'Continue',
                isFullWidth: true,
                onPressed: () {
                  // Navigate to next screen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

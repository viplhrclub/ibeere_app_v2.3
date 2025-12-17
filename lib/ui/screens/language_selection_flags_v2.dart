import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class LanguageSelectionFlagsV2 extends StatefulWidget {
  const LanguageSelectionFlagsV2({super.key});

  @override
  State<LanguageSelectionFlagsV2> createState() => _LanguageSelectionFlagsV2State();
}

class _LanguageSelectionFlagsV2State extends State<LanguageSelectionFlagsV2> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'flag': '🇬🇧'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Arabic', 'flag': '🇸🇦'},
    {'name': 'Portuguese', 'flag': '🇵🇹'},
    {'name': 'Chinese', 'flag': '🇨🇳'},
    {'name': 'Japanese', 'flag': '🇯🇵'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Language',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your preferred language',
                style: TextStyle(
                  fontSize: 16,
                  color: IbeereDesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final lang = _languages[index];
                    final isSelected = _selectedLanguage == lang['name'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = lang['name']!;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? IbeereDesignTokens.primaryPurple
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (isSelected)
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: IbeereDesignTokens.primaryPurple,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            Text(
                              lang['flag']!,
                              style: TextStyle(fontSize: 48),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              lang['name']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: IbeereDesignTokens.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/profile-avatar-selection');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IbeereDesignTokens.primaryPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

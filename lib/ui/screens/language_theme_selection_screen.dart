import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_v2_buttons.dart';

class LanguageThemeSelectionScreen extends StatefulWidget {
  const LanguageThemeSelectionScreen({super.key});

  static const String routeName = '/language-theme-selection';

  @override
  State<LanguageThemeSelectionScreen> createState() => _LanguageThemeSelectionScreenState();
}

class _LanguageThemeSelectionScreenState extends State<LanguageThemeSelectionScreen> {
  String _selectedTheme = 'light';
  Color _selectedColor = Color(0xFF6366F1);

  final List<Map<String, dynamic>> _themes = [
    {'id': 'light', 'name': 'Light', 'icon': Icons.light_mode},
    {'id': 'dark', 'name': 'Dark', 'icon': Icons.dark_mode},
    {'id': 'system', 'name': 'System', 'icon': Icons.settings_brightness},
  ];

  final List<Color> _colors = [
    Color(0xFF6366F1),
    Color(0xFFEC4899),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFF3B82F6),
    Color(0xFF8B5CF6),
    Color(0xFFEF4444),
    Color(0xFF06B6D4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize Your Experience',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your preferred theme and color',
                style: TextStyle(
                  fontSize: 16,
                  color: IbeereDesignTokens.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              Text(
                'Theme Mode',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: _themes.map((theme) {
                  final isSelected = _selectedTheme == theme['id'];
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTheme = theme['id']),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? _selectedColor.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? _selectedColor : Color(0xFFE2E8F0),
                            width: 2,
                          ),
                          boxShadow: isSelected ? [BoxShadow(color: _selectedColor.withOpacity(0.2), blurRadius: 8, offset: Offset(0, 4))] : [],
                        ),
                        child: Column(
                          children: [
                            Icon(theme['icon'], size: 32, color: isSelected ? _selectedColor : IbeereDesignTokens.textSecondary),
                            const SizedBox(height: 8),
                            Text(
                              theme['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? _selectedColor : IbeereDesignTokens.textSecondary,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(height: 4),
                              Icon(Icons.check_circle, size: 20, color: _selectedColor),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              Text(
                'Primary Color',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: IbeereDesignTokens.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _colors.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        boxShadow: isSelected ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 8, offset: Offset(0, 4))] : [],
                        border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
                      ),
                      child: isSelected ? Icon(Icons.check, color: Colors.white, size: 28) : null,
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              IbeereButton(
                text: 'Continue',
                onPressed: () => Navigator.pushNamed(context, '/home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

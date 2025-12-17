import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_inputs.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationsEnabled = true;
  bool _darkMode = false;
  String _fontSize = 'medium';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'App Settings',
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
        padding: EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notifications Section
            _buildSection(
              'Notifications',
              [
                _buildToggleTile(
                  'Enable Notifications',
                  _notificationsEnabled,
                  (value) => setState(() => _notificationsEnabled = value),
                ),
                _buildToggleTile(
                  'Sound',
                  _soundEnabled,
                  (value) => setState(() => _soundEnabled = value),
                ),
                _buildToggleTile(
                  'Vibrations',
                  _vibrationsEnabled,
                  (value) => setState(() => _vibrationsEnabled = value),
                ),
              ],
            ),

            // Display Section
            _buildSection(
              'Display',
              [
                _buildToggleTile(
                  'Dark Mode',
                  _darkMode,
                  (value) => setState(() => _darkMode = value),
                ),
              ],
            ),

            // Font Size
            _buildSection(
              'Font Size',
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceMd),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['Small', 'Medium', 'Large'].map((size) {
                          final isSelected = _fontSize.toLowerCase() == size.toLowerCase();
                          return GestureDetector(
                            onTap: () => setState(() => _fontSize = size.toLowerCase()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: DesignTokens.spaceMd,
                                vertical: DesignTokens.spaceSm,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? DesignTokens.primary : Colors.grey[200],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                size,
                                style: TextStyle(
                                  fontSize: DesignTokens.fontSizeBase,
                                  color: isSelected ? Colors.white : Colors.grey[700],
                                  fontWeight: isSelected
                                      ? DesignTokens.fontWeightBold
                                      : DesignTokens.fontWeightMedium,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(height: DesignTokens.spaceMd),
                      Text(
                        'Sample Text',
                        style: TextStyle(
                          fontSize: _fontSize == 'small'
                              ? DesignTokens.fontSizeBase
                              : _fontSize == 'medium'
                              ? DesignTokens.fontSizeLg
                              : DesignTokens.fontSizeXl,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Cache & Storage
            _buildSection(
              'Storage',
              [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceSm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Clear Cache',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeBase,
                              fontWeight: DesignTokens.fontWeightMedium,
                            ),
                          ),
                          Text(
                            '245 MB',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      IbeereSecondaryButton(
                        label: 'Clear',
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Cache cleared'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // About Section
            _buildSection(
              'About',
              [
                _buildInfoTile('App Version', '2.0.1'),
                _buildInfoTile('Build Number', '124'),
                _buildInfoTile('Last Updated', '2025-01-15'),
              ],
            ),

            SizedBox(height: DesignTokens.spaceXxl),

            // Contact Support
            Container(
              padding: EdgeInsets.all(DesignTokens.spaceMd),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
              ),
              child: Row(
                children: [
                  Icon(Icons.help_outline, color: Colors.blue[700]),
                  SizedBox(width: DesignTokens.spaceMd),
                  Expanded(
                    child: Text(
                      'Need help? Contact our support team',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_rounded, color: Colors.blue[700]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: DesignTokens.fontSizeLg,
            fontWeight: DesignTokens.fontWeightBold,
            color: DesignTokens.primary,
          ),
        ),
        SizedBox(height: DesignTokens.spaceMd),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: DesignTokens.spaceMd),
            child: Column(children: children),
          ),
        ),
        SizedBox(height: DesignTokens.spaceXxl),
      ],
    );
  }

  Widget _buildToggleTile(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceMd,
        vertical: DesignTokens.spaceSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: DesignTokens.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.spaceMd,
        vertical: DesignTokens.spaceSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}

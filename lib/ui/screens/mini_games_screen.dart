import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';
import 'package:url_launcher/url_launcher.dart';

class MiniGamesScreen extends StatefulWidget {
  const MiniGamesScreen({super.key});

  static const String routeName = '/mini-games';

  @override
  State<MiniGamesScreen> createState() => _MiniGamesScreenState();
}

class _MiniGamesScreenState extends State<MiniGamesScreen> {
  List<Map<String, dynamic>> _games = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.post(
        Uri.parse('https://api.ibeere.fun/api/get_mini_games'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['error'] == false) {
          setState(() {
            _games = List<Map<String, dynamic>>.from(data['data']);
            _isLoading = false;
          });
        } else {
          setState(() {
            _errorMessage = data['message'] ?? 'Failed to load games';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _errorMessage = 'Server error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _launchGame(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch game')),
        );
      }
    }
  }

  Color _parseColor(String? colorString) {
    if (colorString == null || colorString.isEmpty) {
      return IbeereDesignTokens.primaryPurple;
    }
    
    String hexColor = colorString.replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    
    try {
      return Color(int.parse(hexColor, radix: 16));
    } catch (e) {
      return IbeereDesignTokens.primaryPurple;
    }
  }

  IconData _getIconForGameType(String iconType) {
    switch (iconType.toLowerCase()) {
      case 'public':
        return Icons.public;
      case 'grid_3x3':
        return Icons.grid_3x3;
      case 'memory':
        return Icons.psychology;
      case 'tag':
        return Icons.tag;
      case 'calculate':
        return Icons.calculate;
      case 'apps':
        return Icons.apps;
      case 'visibility':
        return Icons.remove_red_eye;
      case 'extension':
        return Icons.extension;
      default:
        return Icons.sports_esports;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Text(
                    'Mini Games',
                    style: TextStyle(
                      color: IbeereDesignTokens.textPrimary.withOpacity(0.7),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.close,
                        color: IbeereDesignTokens.textSecondary,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _errorMessage != null
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 48,
                                color: IbeereDesignTokens.textSecondary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _errorMessage!,
                                style: TextStyle(
                                  color: IbeereDesignTokens.textSecondary,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _fetchGames,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: IbeereDesignTokens.primaryPurple,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _fetchGames,
                          child: GridView.builder(
                            padding: const EdgeInsets.all(16),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 0.95,
                            ),
                            itemCount: _games.length,
                            itemBuilder: (context, index) {
                              final game = _games[index];
                              final color1 = _parseColor(game['gradient_color_1']);
                              final color2 = _parseColor(game['gradient_color_2']);
                              final icon = _getIconForGameType(game['game_icon'] ?? '');

                              return GestureDetector(
                                onTap: () {
                                  final gameUrl = game['game_url'];
                                  if (gameUrl != null && gameUrl.isNotEmpty) {
                                    _launchGame(gameUrl);
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [color1, color2],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color1.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: -20,
                                        right: -20,
                                        child: Container(
                                          width: 80,
                                          height: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: -30,
                                        left: -30,
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.05),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 64,
                                              height: 64,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.25),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.1),
                                                    blurRadius: 8,
                                                    offset: const Offset(0, 4),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                icon,
                                                size: 36,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Text(
                                              game['game_name'] ?? 'Game',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

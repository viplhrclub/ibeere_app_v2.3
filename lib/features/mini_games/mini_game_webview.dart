import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class MiniGameWebView extends StatefulWidget {
  final String gameUrl;
  final String gameName;
  final Function(int score)? onGameComplete;

  const MiniGameWebView({
    super.key,
    required this.gameUrl,
    required this.gameName,
    this.onGameComplete,
  });

  @override
  State<MiniGameWebView> createState() => _MiniGameWebViewState();
}

class _MiniGameWebViewState extends State<MiniGameWebView> {
  late WebViewController _controller;
  bool _isLoading = true;
  int _currentScore = 0;

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (String url) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..addJavaScriptChannel(
        'GameScore',
        onMessageReceived: (JavaScriptMessage message) {
          final score = int.tryParse(message.message) ?? 0;
          setState(() => _currentScore = score);
        },
      )
      ..addJavaScriptChannel(
        'GameComplete',
        onMessageReceived: (JavaScriptMessage message) {
          final score = int.tryParse(message.message) ?? 0;
          _handleGameComplete(score);
        },
      )
      ..loadRequest(Uri.parse(widget.gameUrl));
  }

  void _handleGameComplete(int finalScore) {
    widget.onGameComplete?.call(finalScore);
    _showScoreDialog(finalScore);
  }

  void _showScoreDialog(int score) {
    final kauris = (score / 10).round();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Game Complete!', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, size: 60, color: IbeereDesignTokens.accentYellow),
            const SizedBox(height: 16),
            Text('Your Score: $score', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Kauris Earned: $kauris', style: TextStyle(fontSize: 18, color: IbeereDesignTokens.primaryPurple)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _controller.reload();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: IbeereDesignTokens.primaryPurple,
            ),
            child: Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.gameName,
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_currentScore > 0)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Score: $_currentScore',
                    style: TextStyle(
                      color: IbeereDesignTokens.primaryPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(IbeereDesignTokens.primaryPurple),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _handleGameComplete(100),
        backgroundColor: IbeereDesignTokens.primaryPurple,
        icon: Icon(Icons.check),
        label: Text('Test Complete'),
      ),
    );
  }
}

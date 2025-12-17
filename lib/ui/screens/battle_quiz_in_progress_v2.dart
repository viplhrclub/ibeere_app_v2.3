import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleQuizInProgressV2 extends StatelessWidget {
  const BattleQuizInProgressV2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
        ),
        title: Text(
          'Battle Quiz',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.sports_esports, size: 80, color: IbeereDesignTokens.primaryPurple),
            const SizedBox(height: 24),
            Text(
              'Battle Quiz',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: IbeereDesignTokens.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'UI implementation in progress',
              style: TextStyle(
                fontSize: 14,
                color: IbeereDesignTokens.textSecondary,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/battle_completion');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: IbeereDesignTokens.primaryPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}

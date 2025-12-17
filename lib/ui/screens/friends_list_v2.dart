import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class FriendsListV2 extends StatelessWidget {
  const FriendsListV2({super.key});

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
          'Friends',
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
            Icon(Icons.people, size: 80, color: IbeereDesignTokens.primaryPurple),
            const SizedBox(height: 24),
            Text(
              'Friends',
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
            Container(),
          ],
        ),
      ),
    );
  }
}

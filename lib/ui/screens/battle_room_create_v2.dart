import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleRoomCreateV2 extends StatelessWidget {
  const BattleRoomCreateV2({super.key});

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
        title: Text('Battle Room', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [IbeereDesignTokens.cardShadow]),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: IbeereDesignTokens.accentYellow, size: 24),
                  const SizedBox(width: 8),
                  Text('ENTRY FEES 150', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [IbeereDesignTokens.cardShadow]),
              child: Row(
                children: [
                  Text('Room PIN 204784', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                  const Spacer(),
                  IconButton(onPressed: () {}, icon: Icon(Icons.copy, color: IbeereDesignTokens.primaryPurple)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [IbeereDesignTokens.cardShadow]),
              child: Row(
                children: [
                  Icon(Icons.people, color: IbeereDesignTokens.primaryPurple, size: 24),
                  const SizedBox(width: 8),
                  Text('2 players', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlayerSlot(true),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: Text('VS', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary))),
                _buildPlayerSlot(false),
              ],
            ),
            const Spacer(),
            SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/battle-countdown');}, style: ElevatedButton.styleFrom(backgroundColor: IbeereDesignTokens.accentGreen, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))), child: Text('START', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity, height: 56, child: OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(side: BorderSide(color: IbeereDesignTokens.primaryPurple, width: 2), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))), child: Text('Share Code', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: IbeereDesignTokens.primaryPurple)))),
          ],
        ),
      ),
    );
  }

  static Widget _buildPlayerSlot(bool filled) {
    return Container(width: 60, height: 60, decoration: BoxDecoration(shape: BoxShape.circle, color: filled ? IbeereDesignTokens.primaryPurple : Colors.grey.withOpacity(0.2), border: Border.all(color: filled ? IbeereDesignTokens.primaryPurple : Colors.grey, width: 2)), child: filled ? Icon(Icons.person, color: Colors.white, size: 30) : null);
  }
}

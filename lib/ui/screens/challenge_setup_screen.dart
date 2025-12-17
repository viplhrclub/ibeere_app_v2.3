import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class ChallengeSetupScreen extends StatefulWidget {
  const ChallengeSetupScreen({super.key});

  static const String routeName = '/challenge-setup';

  @override
  State<ChallengeSetupScreen> createState() => _ChallengeSetupScreenState();
}

class _ChallengeSetupScreenState extends State<ChallengeSetupScreen> {
  String _selectedCategory = 'Science';
  String _selectedDifficulty = 'Medium';
  int _numberOfQuestions = 10;

  @override
  Widget build(BuildContext context) {
    final categories = ['Science', 'History', 'Geography', 'Math', 'Sports', 'Entertainment'];
    final difficulties = ['Easy', 'Medium', 'Hard'];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Challenge Friend', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: IbeereDesignTokens.primaryPurple, size: 28),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sarah Johnson', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Online', style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Text('Select Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: categories.map((cat) => GestureDetector(
                onTap: () => setState(() => _selectedCategory = cat),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedCategory == cat ? IbeereDesignTokens.primaryPurple : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _selectedCategory == cat ? IbeereDesignTokens.primaryPurple : Color(0xFFE2E8F0),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    cat,
                    style: TextStyle(
                      color: _selectedCategory == cat ? Colors.white : IbeereDesignTokens.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
            Text('Difficulty Level', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 12),
            Row(
              children: difficulties.map((diff) => Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDifficulty = diff),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: _selectedDifficulty == diff ? IbeereDesignTokens.primaryPink : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedDifficulty == diff ? IbeereDesignTokens.primaryPink : Color(0xFFE2E8F0),
                        width: 2,
                      ),
                    ),
                    child: Text(
                      diff,
                      style: TextStyle(
                        color: _selectedDifficulty == diff ? Colors.white : IbeereDesignTokens.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )).toList(),
            ),
            const SizedBox(height: 24),
            Text('Number of Questions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => setState(() => _numberOfQuestions = (_numberOfQuestions - 5).clamp(5, 30)),
                    icon: Icon(Icons.remove_circle, color: IbeereDesignTokens.primaryPurple, size: 32),
                  ),
                  Text('$_numberOfQuestions', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
                  IconButton(
                    onPressed: () => setState(() => _numberOfQuestions = (_numberOfQuestions + 5).clamp(5, 30)),
                    icon: Icon(Icons.add_circle, color: IbeereDesignTokens.primaryPurple, size: 32),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/battle-countdown'),
              style: ElevatedButton.styleFrom(
                backgroundColor: IbeereDesignTokens.primaryPurple,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: 20),
                  const SizedBox(width: 8),
                  Text('Send Challenge', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

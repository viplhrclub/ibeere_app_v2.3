import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';

class BattleRoomScreen extends StatefulWidget {
  const BattleRoomScreen({super.key});

  @override
  State<BattleRoomScreen> createState() => _BattleRoomScreenState();
}

class _BattleRoomScreenState extends State<BattleRoomScreen> {
  final int _currentQuestion = 0;
  final int _totalQuestions = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        title: Text(
          'Battle Mode',
          style: TextStyle(
            color: DesignTokens.primary,
            fontWeight: DesignTokens.fontWeightBold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.close, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // Score Header
          Container(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [DesignTokens.primary, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spaceSm),
                        const Text(
                          'You',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: DesignTokens.fontSizeSm,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '7',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DesignTokens.fontSizeXl,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 100,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(height: DesignTokens.spaceSm),
                        const Text(
                          'Opponent',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: DesignTokens.fontSizeSm,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '5',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: DesignTokens.fontSizeXl,
                            fontWeight: DesignTokens.fontWeightBold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceXl),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_currentQuestion + 1) / _totalQuestions,
                    minHeight: 6,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Text(
                  'Question ${_currentQuestion + 1}/$_totalQuestions',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: DesignTokens.fontSizeSm,
                  ),
                ),
              ],
            ),
          ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is the capital of Japan?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: DesignTokens.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceXxl),

                  // Options
                  ...[
                    {'text': 'Seoul', 'isCorrect': false},
                    {'text': 'Tokyo', 'isCorrect': true},
                    {'text': 'Bangkok', 'isCorrect': false},
                    {'text': 'Beijing', 'isCorrect': false},
                  ].asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(DesignTokens.spaceMd),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        String.fromCharCode(65 + index),
                                        style: TextStyle(
                                          fontWeight: DesignTokens.fontWeightBold,
                                          color: DesignTokens.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: DesignTokens.spaceMd),
                                  Expanded(
                                    child: Text(
                                      option['text']! as String,
                                      style: const TextStyle(
                                        fontSize: DesignTokens.fontSizeBase,
                                        fontWeight: DesignTokens.fontWeightMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Timer
          Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceLg),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: DesignTokens.primary, width: 4),
                  ),
                  child: Center(
                    child: Text(
                      '15s',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeXl,
                        fontWeight: DesignTokens.fontWeightBold,
                        color: DesignTokens.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


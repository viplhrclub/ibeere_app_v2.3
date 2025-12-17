import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BookmarksScreenV2 extends StatelessWidget {
  const BookmarksScreenV2({super.key});

  static const String routeName = '/bookmarks-v2';

  @override
  Widget build(BuildContext context) {
    final bookmarkedQuestions = [
      {
        'question': 'What is the powerhouse of the cell?',
        'category': 'Science',
        'difficulty': 'Easy',
        'color': IbeereDesignTokens.primaryPurple,
      },
      {
        'question': 'Who painted the Mona Lisa?',
        'category': 'Arts',
        'difficulty': 'Medium',
        'color': IbeereDesignTokens.primaryPink,
      },
      {
        'question': 'What is the largest planet in our solar system?',
        'category': 'Astronomy',
        'difficulty': 'Easy',
        'color': IbeereDesignTokens.accentCyan,
      },
      {
        'question': 'In which year did World War II end?',
        'category': 'History',
        'difficulty': 'Hard',
        'color': IbeereDesignTokens.accentGreen,
      },
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Bookmarks', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Clear all', style: TextStyle(color: IbeereDesignTokens.primaryRed, fontSize: 12)),
          ),
        ],
      ),
      body: bookmarkedQuestions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bookmark_border, size: 80, color: IbeereDesignTokens.textTertiary),
                  const SizedBox(height: 16),
                  Text('No bookmarks yet', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 16)),
                  const SizedBox(height: 8),
                  Text(
                    'Bookmark questions to review later',
                    style: TextStyle(color: IbeereDesignTokens.textTertiary, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookmarkedQuestions.length,
              itemBuilder: (context, index) {
                final q = bookmarkedQuestions[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border(left: BorderSide(color: q['color'] as Color, width: 4)),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: Offset(0, 2))],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: (q['color'] as Color).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                q['category'] as String,
                                style: TextStyle(color: q['color'] as Color, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: IbeereDesignTokens.backgroundLight,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                q['difficulty'] as String,
                                style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(Icons.bookmark, color: q['color'] as Color, size: 20),
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          q['question'] as String,
                          style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w500, height: 1.4),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text('Practice', style: TextStyle(color: IbeereDesignTokens.primaryPurple, fontSize: 13)),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.delete_outline, size: 16),
                              label: Text('Remove'),
                              style: TextButton.styleFrom(foregroundColor: IbeereDesignTokens.primaryRed),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

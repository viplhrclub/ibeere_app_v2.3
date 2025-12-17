import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';
import '../widgets/ibeere_navigation.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({Key? key}) : super(key: key);

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  final List<_BookmarkedQuestion> _bookmarks = [
    _BookmarkedQuestion(
      id: '1',
      question: 'What is the capital of France?',
      category: 'Geography',
      difficulty: 'Easy',
      savedDate: 'Today',
    ),
    _BookmarkedQuestion(
      id: '2',
      question: 'Explain the theory of relativity',
      category: 'Physics',
      difficulty: 'Hard',
      savedDate: 'Yesterday',
    ),
    _BookmarkedQuestion(
      id: '3',
      question: 'Who wrote Romeo and Juliet?',
      category: 'Literature',
      difficulty: 'Medium',
      savedDate: '2 days ago',
    ),
    _BookmarkedQuestion(
      id: '4',
      question: 'What is photosynthesis?',
      category: 'Biology',
      difficulty: 'Medium',
      savedDate: '1 week ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Bookmarked Questions',
        centerTitle: false,
        showBackButton: false,
      ),
      body: _bookmarks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark_outline,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: DesignTokens.spaceLg),
                  Text(
                    'No Bookmarked Questions',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    'Start bookmarking questions to save them',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: DesignTokens.fontSizeBase,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              itemCount: _bookmarks.length,
              itemBuilder: (context, index) {
                final bookmark = _bookmarks[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                  child: _BookmarkCard(bookmark: bookmark),
                );
              },
            ),
    );
  }
}

class _BookmarkCard extends StatelessWidget {
  final _BookmarkedQuestion bookmark;

  const _BookmarkCard({required this.bookmark});

  Color _getDifficultyColor() {
    switch (bookmark.difficulty) {
      case 'Easy':
        return DesignTokens.success;
      case 'Medium':
        return DesignTokens.warning;
      case 'Hard':
        return DesignTokens.error;
      default:
        return DesignTokens.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      elevation: 1,
      padding: EdgeInsets.all(DesignTokens.spaceMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  bookmark.question,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeBase,
                    fontWeight: DesignTokens.fontWeightSemibold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: DesignTokens.spaceSm),
              IconButton(
                icon: Icon(Icons.bookmark, color: DesignTokens.primary),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spaceMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceSm,
                      vertical: DesignTokens.spaceSm,
                    ),
                    decoration: BoxDecoration(
                      color: DesignTokens.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    ),
                    child: Text(
                      bookmark.category,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: DesignTokens.primary,
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                  ),
                  SizedBox(width: DesignTokens.spaceSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceSm,
                      vertical: DesignTokens.spaceSm,
                    ),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor().withOpacity(0.1),
                      borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
                    ),
                    child: Text(
                      bookmark.difficulty,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: _getDifficultyColor(),
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                bookmark.savedDate,
                style: TextStyle(
                  fontSize: DesignTokens.fontSizeSm,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: DesignTokens.spaceMd),
          Row(
            children: [
              Expanded(
                child: IbeereSecondaryButton(
                  label: 'Review',
                  onPressed: () {},
                ),
              ),
              SizedBox(width: DesignTokens.spaceSm),
              Expanded(
                child: IbeerePrimaryButton(
                  label: 'Practice',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BookmarkedQuestion {
  final String id;
  final String question;
  final String category;
  final String difficulty;
  final String savedDate;

  _BookmarkedQuestion({
    required this.id,
    required this.question,
    required this.category,
    required this.difficulty,
    required this.savedDate,
  });
}

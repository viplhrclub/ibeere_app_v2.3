import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<String> _recentSearches = [
    'Physics Quiz',
    'Math Problems',
    'Biology Quiz',
    'Science',
  ];
  List<Map<String, String>> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() => _searchResults = []);
      return;
    }

    setState(() => _isSearching = true);
    Future.delayed(Duration(milliseconds: 800), () {
      setState(() {
        _isSearching = false;
        _searchResults = [
          {'title': 'Advanced $query', 'type': 'Quiz', 'questions': '25'},
          {'title': 'Beginner $query', 'type': 'Quiz', 'questions': '15'},
          {'title': '$query Mastery', 'type': 'Category', 'questions': '50'},
          {'title': 'Practice $query', 'type': 'Quiz', 'questions': '10'},
        ];
      });
    });
  }

  void _addRecentSearch(String search) {
    if (!_recentSearches.contains(search)) {
      _recentSearches.insert(0, search);
      if (_recentSearches.length > 5) {
        _recentSearches.removeLast();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header
            Container(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              color: DesignTokens.background,
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: _performSearch,
                          decoration: InputDecoration(
                            hintText: 'Search quizzes, categories...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                            suffixIcon: _searchController.text.isNotEmpty
                                ? IconButton(
                              icon: Icon(Icons.clear, color: Colors.grey[400]),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchResults = []);
                              },
                            )
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                              borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                              borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                              borderSide: BorderSide(color: DesignTokens.primary, width: 2),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: DesignTokens.spaceLg,
                              vertical: DesignTokens.spaceMd,
                            ),
                          ),
                          style: TextStyle(fontSize: DesignTokens.fontSizeBase),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isSearching) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: DesignTokens.primary,
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: DesignTokens.spaceLg),
            Text(
              'Searching...',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    if (_searchController.text.isEmpty) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(DesignTokens.spaceLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Searches',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            Wrap(
              spacing: DesignTokens.spaceMd,
              runSpacing: DesignTokens.spaceMd,
              children: _recentSearches.map((search) {
                return GestureDetector(
                  onTap: () {
                    _searchController.text = search;
                    _performSearch(search);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceMd,
                      vertical: DesignTokens.spaceSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                      border: Border.all(color: Colors.blue[200] ?? Colors.blue),
                    ),
                    child: Text(
                      search,
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeBase,
                        color: DesignTokens.primary,
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: DesignTokens.spaceXxl),
            Text(
              'Popular Categories',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: DesignTokens.fontWeightBold,
              ),
            ),
            SizedBox(height: DesignTokens.spaceMd),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              childAspectRatio: 1.2,
              mainAxisSpacing: DesignTokens.spaceMd,
              crossAxisSpacing: DesignTokens.spaceMd,
              children: [
                _popularCategoryCard('📚 Mathematics'),
                _popularCategoryCard('🔬 Science'),
                _popularCategoryCard('🌍 Geography'),
                _popularCategoryCard('📖 History'),
              ],
            ),
          ],
        ),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              color: Colors.grey[400],
              size: 60,
            ),
            SizedBox(height: DesignTokens.spaceLg),
            Text(
              'No results found',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[600],
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        return IbeereListCard(
          title: result['title'] ?? '',
          subtitle: '${result['type']} • ${result['questions']} questions',
          trailing: Icon(Icons.arrow_forward, color: Colors.grey[400]),
          onTap: () {
            _addRecentSearch(result['title'] ?? '');
          },
        );
      },
    );
  }

  Widget _popularCategoryCard(String category) {
    return GestureDetector(
      onTap: () {
        _searchController.text = category.split(' ')[1];
        _performSearch(_searchController.text);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
          border: Border.all(color: Colors.grey[200] ?? Colors.grey),
        ),
        child: Center(
          child: Text(
            category,
            style: TextStyle(
              fontSize: DesignTokens.fontSizeBase,
              fontWeight: DesignTokens.fontWeightMedium,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

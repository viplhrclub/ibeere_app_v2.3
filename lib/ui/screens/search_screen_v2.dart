import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class SearchScreenV2 extends StatefulWidget {
  const SearchScreenV2({super.key});

  static const String routeName = '/search-v2';

  @override
  State<SearchScreenV2> createState() => _SearchScreenV2State();
}

class _SearchScreenV2State extends State<SearchScreenV2> {
  final _searchController = TextEditingController();
  final List<String> _recentSearches = ['Science', 'History', 'Geography'];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'name': 'Science', 'color': IbeereDesignTokens.primaryPurple, 'icon': Icons.science},
      {'name': 'History', 'color': IbeereDesignTokens.primaryPink, 'icon': Icons.history_edu},
      {'name': 'Geography', 'color': IbeereDesignTokens.accentGreen, 'icon': Icons.public},
      {'name': 'Math', 'color': IbeereDesignTokens.accentYellow, 'icon': Icons.calculate},
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
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search quizzes...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: IbeereDesignTokens.textTertiary),
          ),
          style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16),
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: Icon(Icons.clear, color: IbeereDesignTokens.textSecondary),
              onPressed: () => setState(() => _searchController.clear()),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_recentSearches.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('Recent Searches', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _recentSearches.map((search) => GestureDetector(
                    onTap: () => _searchController.text = search,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0xFFE2E8F0)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.history, size: 16, color: IbeereDesignTokens.textSecondary),
                          const SizedBox(width: 8),
                          Text(search, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 14)),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text('Popular Categories', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: IbeereDesignTokens.textPrimary)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: categories.map((cat) => Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
                  ),
                  child: ListTile(
                    onTap: () => Navigator.pushNamed(context, '/category-selection'),
                    leading: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (cat['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(cat['icon'] as IconData, color: cat['color'] as Color, size: 24),
                    ),
                    title: Text(cat['name'] as String, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                    trailing: Icon(Icons.arrow_forward_ios, color: IbeereDesignTokens.textSecondary, size: 16),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

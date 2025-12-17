import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class CategoriesApiScreen extends StatefulWidget {
  const CategoriesApiScreen({super.key});

  static const String routeName = '/categories-api';

  @override
  State<CategoriesApiScreen> createState() => _CategoriesApiScreenState();
}

class _CategoriesApiScreenState extends State<CategoriesApiScreen> {
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _selectedType = 'Quiz Zone';

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final typeMap = {
        'Quiz Zone': '1',
        'Fun & Learn': '2',
        'Guess Word': '3',
        'Audio Quiz': '4',
        'Maths Quiz': '5',
      };

      final response = await http.post(
        Uri.parse('https://api.ibeere.fun/api/get_categories'),
        body: {
          'type': typeMap[_selectedType] ?? '1',
          'language_id': '18',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['error'] == false && data['data'] != null) {
          setState(() {
            _categories = List<Map<String, dynamic>>.from(data['data']);
            _isLoading = false;
          });
        } else {
          setState(() {
            _categories = _getMockCategories();
            _errorMessage = 'Using demo data (${data['message']})';
            _isLoading = false;
          });
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error - using demo data';
        _categories = _getMockCategories();
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> _getMockCategories() {
    return [
      {'id': '1', 'category_name': 'General Knowledge', 'image': '', 'no_of_que': '150', 'maxlevel': '5'},
      {'id': '2', 'category_name': 'Science', 'image': '', 'no_of_que': '120', 'maxlevel': '4'},
      {'id': '3', 'category_name': 'History', 'image': '', 'no_of_que': '100', 'maxlevel': '4'},
      {'id': '4', 'category_name': 'Geography', 'image': '', 'no_of_que': '90', 'maxlevel': '3'},
      {'id': '5', 'category_name': 'Sports', 'image': '', 'no_of_que': '80', 'maxlevel': '3'},
      {'id': '6', 'category_name': 'Entertainment', 'image': '', 'no_of_que': '110', 'maxlevel': '4'},
      {'id': '7', 'category_name': 'Technology', 'image': '', 'no_of_que': '95', 'maxlevel': '3'},
      {'id': '8', 'category_name': 'Art & Literature', 'image': '', 'no_of_que': '70', 'maxlevel': '3'},
    ];
  }

  void _changeType(String type) {
    if (_selectedType != type) {
      setState(() {
        _selectedType = type;
      });
      _fetchCategories();
    }
  }

  Color _getCategoryColor(int index) {
    final colors = [
      IbeereDesignTokens.primaryPurple,
      IbeereDesignTokens.primaryPink,
      IbeereDesignTokens.accentGreen,
      IbeereDesignTokens.accentCyan,
      IbeereDesignTokens.accentYellow,
      const Color(0xFF8B5CF6),
      const Color(0xFF3B82F6),
      IbeereDesignTokens.primaryRed,
    ];
    return colors[index % colors.length];
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
          'Categories',
          style: TextStyle(
            color: IbeereDesignTokens.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: IbeereDesignTokens.primaryPurple),
            onPressed: _fetchCategories,
          ),
        ],
      ),
      body: Column(
        children: [
          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: IbeereDesignTokens.accentYellow.withOpacity(0.2),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: IbeereDesignTokens.textSecondary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color: IbeereDesignTokens.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          _buildTypeSelector(),
          const SizedBox(height: 16),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _fetchCategories,
                    child: _categories.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category_outlined,
                                  size: 64,
                                  color: IbeereDesignTokens.textSecondary,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No categories available',
                                  style: TextStyle(
                                    color: IbeereDesignTokens.textSecondary,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 1.1,
                            ),
                            itemCount: _categories.length,
                            itemBuilder: (context, index) {
                              final category = _categories[index];
                              final color = _getCategoryColor(index);
                              
                              return GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Opening ${category['category_name']}...'),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [color, color.withOpacity(0.7)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: -15,
                                        right: -15,
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white.withOpacity(0.2),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    category['no_of_que']?.toString() ?? '0',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  category['category_name'] ?? 'Category',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'Level ${category['maxlevel'] ?? '1'}',
                                                  style: TextStyle(
                                                    color: Colors.white.withOpacity(0.9),
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    final types = ['Quiz Zone', 'Fun & Learn', 'Guess Word', 'Audio Quiz', 'Maths Quiz'];
    
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: types.length,
        itemBuilder: (context, index) {
          final type = types[index];
          final isSelected = _selectedType == type;
          
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => _changeType(type),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            IbeereDesignTokens.primaryPurple,
                            IbeereDesignTokens.primaryPink,
                          ],
                        )
                      : null,
                  color: isSelected ? null : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? null
                      : Border.all(
                          color: IbeereDesignTokens.textTertiary.withOpacity(0.2),
                        ),
                ),
                child: Text(
                  type,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : IbeereDesignTokens.textSecondary,
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

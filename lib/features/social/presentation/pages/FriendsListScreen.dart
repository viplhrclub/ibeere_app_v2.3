import '../../cubits/social_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({Key? key}) : super(key: key);
  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController, _slideController, _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  final List<Map<String, String>> _items = List.generate(10, (i) => {'title': 'Item ${i+1}', 'subtitle': 'Details ${i+1}'});

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _expandController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    Future.delayed(const Duration(milliseconds: 200), () { if (mounted) _revealController.forward(); });
  }

  @override
  void dispose() {
    _revealController.dispose();
    _slideController.dispose();
    _expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(listener: (ctx, st) {}, builder: (context, state) { return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(backgroundColor: const Color(0xFF16213E), title: const Text('Items'), elevation: 0),
      body: FadeTransition(
        opacity: _revealController,
        child: ListView.builder(padding: const EdgeInsets.all(16), itemCount: _items.length, itemBuilder: (context, index) => GestureDetector(onTap: () => HapticFeedback.lightImpact(), child: Card(color: const Color(0xFF16213E), child: ListTile(title: Text(_items[index]['title']!, style: const TextStyle(color: Colors.white)), subtitle: Text(_items[index]['subtitle']!, style: TextStyle(color: Colors.white.withOpacity(0.6))), trailing: Icon(Icons.arrow_forward, color: Colors.white.withOpacity(0.5)))))),
      ),
    );
  }
}





import '../../cubits/mini_games_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class MiniGamesScreen extends StatefulWidget {
  const MiniGamesScreen({Key? key}) : super(key: key);
  @override
  State<MiniGamesScreen> createState() => _MiniGamesScreenState();
}

class _MiniGamesScreenState extends State<MiniGamesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController, _slideController, _expandController;
  bool _isLoading = false;
  String _errorMessage = '';

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
      appBar: AppBar(backgroundColor: const Color(0xFF16213E), title: const Text('Grid'), elevation: 0),
      body: FadeTransition(
        opacity: _revealController,
        child: GridView.builder(padding: const EdgeInsets.all(16), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 16, mainAxisSpacing: 16), itemCount: 10, itemBuilder: (context, index) => GestureDetector(onTap: () => HapticFeedback.mediumImpact(), child: Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF6C63FF + index * 1000), Color(0xFFA78BFA - index * 500)]), borderRadius: BorderRadius.circular(16)), child: Center(child: Text('${index + 1}', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)))))),
      ),
    );
  }
}





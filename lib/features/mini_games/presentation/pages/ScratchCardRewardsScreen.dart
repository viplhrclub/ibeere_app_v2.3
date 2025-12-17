import '../../cubits/mini_games_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class ScratchCardRewardsScreen extends StatefulWidget {
  const ScratchCardRewardsScreen({Key? key}) : super(key: key);
  @override
  State<ScratchCardRewardsScreen> createState() => _ScratchCardRewardsScreenState();
}

class _ScratchCardRewardsScreenState extends State<ScratchCardRewardsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController, _slideController, _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  int _score = 0;
  int _timeLeft = 60;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _expandController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    Future.delayed(const Duration(milliseconds: 200), () { if (mounted) _revealController.forward(); });
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _timeLeft--);
      if (_timeLeft > 0) _startTimer();
    });
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
      appBar: AppBar(backgroundColor: const Color(0xFF16213E), title: Text('Score: $_score'), elevation: 0, actions: [Padding(padding: const EdgeInsets.all(16), child: Center(child: Text('$_timeLeft s', style: const TextStyle(color: Colors.white, fontSize: 18))))]),
      body: FadeTransition(
        opacity: _revealController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 200, height: 200, decoration: BoxDecoration(gradient: const LinearGradient(colors: [Color(0xFF6C63FF), Color(0xFFA78BFA)]), borderRadius: BorderRadius.circular(20)), child: Center(child: Text('Game', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)))),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: () { HapticFeedback.heavyImpact(); setState(() => _score += 10); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF), padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16)), child: const Text('Play', style: TextStyle(fontSize: 18))),
            ],
          ),
        ),
      ),
    );
  }
}





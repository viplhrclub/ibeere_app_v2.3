import '../../cubits/questions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class QuizBattleScreen extends StatefulWidget {
  const QuizBattleScreen({Key? key}) : super(key: key);
  @override
  State<QuizBattleScreen> createState() => _QuizBattleScreenState();
}

class _QuizBattleScreenState extends State<QuizBattleScreen> with SingleTickerProviderStateMixin {
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
    return BlocBuilder<QuestionsCubit, QuestionsState>(listener: (ctx, st) {}, builder: (context, state) { return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: FadeTransition(
        opacity: _revealController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('VS', style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(children: [Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFF6C63FF)), child: Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(height: 10), const Text('Player 1', style: TextStyle(color: Colors.white))]),
                Column(children: [Container(width: 80, height: 80, decoration: BoxDecoration(shape: BoxShape.circle, color: Color(0xFFFF006E)), child: Icon(Icons.person, size: 40, color: Colors.white)), const SizedBox(height: 10), const Text('Player 2', style: TextStyle(color: Colors.white))]),
              ]),
              ElevatedButton(onPressed: () { HapticFeedback.heavyImpact(); Navigator.pop(context); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF)), child: const Text('Start Battle')),
            ],
          ),
        ),
      ),
    );
  }
}




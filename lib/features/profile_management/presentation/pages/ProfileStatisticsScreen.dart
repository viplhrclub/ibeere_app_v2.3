import '../../cubits/profile_management_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class ProfileStatisticsScreen extends StatefulWidget {
  const ProfileStatisticsScreen({Key? key}) : super(key: key);
  @override
  State<ProfileStatisticsScreen> createState() => _ProfileStatisticsScreenState();
}

class _ProfileStatisticsScreenState extends State<ProfileStatisticsScreen> with SingleTickerProviderStateMixin {
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
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context))),
      body: FadeTransition(
        opacity: _revealController,
        child: Center(
          child: Text('07_ProfileStatistics_CircularChart', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}





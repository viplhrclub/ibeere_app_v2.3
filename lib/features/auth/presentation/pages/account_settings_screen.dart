import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/auth_cubit.dart';


class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({Key? key}) : super(key: key);
  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  late AnimationController _slideController;
  late AnimationController _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;

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
    return BlocListener<AuthCubit, AuthState>(
      listener: (ctx, st) {
        if (st is Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(ctx, '/home');
          });
        }
      },
      child: Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(backgroundColor: const Color(0xFF16213E), title: const Text('Settings'), elevation: 0),
      body: FadeTransition(
        opacity: _revealController,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SwitchListTile(
              title: const Text('Sound', style: TextStyle(color: Colors.white)),
              value: _soundEnabled,
              onChanged: (value) { HapticFeedback.lightImpact(); setState(() => _soundEnabled = value); },
              activeThumbColor: const Color(0xFF6C63FF),
            ),
            SwitchListTile(
              title: const Text('Vibration', style: TextStyle(color: Colors.white)),
              value: _vibrationEnabled,
              onChanged: (value) { HapticFeedback.lightImpact(); setState(() => _vibrationEnabled = value); },
              activeThumbColor: const Color(0xFF6C63FF),
            ),
          ],
        ),
      ),
    ),
    );
  }
}







import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubits/auth_cubit.dart';


class EmailSignInScreen extends StatefulWidget {
  const EmailSignInScreen({Key? key}) : super(key: key);

  @override
  State<EmailSignInScreen> createState() => _EmailSignInScreenState();
}

class _EmailSignInScreenState extends State<EmailSignInScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  late AnimationController _slideController;
  late AnimationController _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _expandController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _revealController.forward();
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    _slideController.dispose();
    _expandController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(listener: (ctx, st) { if (st is Authenticated) { WidgetsBinding.instance.addPostFrameCallback((_) { Navigator.pushReplacementNamed(ctx, '/home'); }); } }, builder: (context, state) { return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
      ),
      body: FadeTransition(
        opacity: _revealController,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const Text('Welcome Back', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Sign in to your account', style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16)),
            const SizedBox(height: 40),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(Icons.email, color: Colors.white.withOpacity(0.5)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2)), borderRadius: BorderRadius.circular(12)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF6C63FF))),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                prefixIcon: Icon(Icons.lock, color: Colors.white.withOpacity(0.5)),
                suffixIcon: IconButton(icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: Colors.white.withOpacity(0.5)), onPressed: () => setState(() => _obscurePassword = !_obscurePassword)),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2)), borderRadius: BorderRadius.circular(12)),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color(0xFF6C63FF))),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                HapticFeedback.mediumImpact();
                setState(() => _isLoading = true);
                Future.delayed(const Duration(seconds: 1), () {
                  if (mounted) Navigator.pushReplacementNamed(context, '/home');
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))) : const Text('Sign In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () => HapticFeedback.lightImpact(),
                child: Text('Forgot Password?', style: TextStyle(color: const Color(0xFF6C63FF), fontSize: 14, decoration: TextDecoration.underline)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}









import '../../cubits/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class SignInVariantScreen extends StatefulWidget {
  const SignInVariantScreen({Key? key}) : super(key: key);
  @override
  State<SignInVariantScreen> createState() => _SignInVariantScreenState();
}

class _SignInVariantScreenState extends State<SignInVariantScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController, _slideController, _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  final _formKey = GlobalKey<FormState>();

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
    return BlocBuilder<AuthCubit, AuthState>(listener: (ctx, st) { if (st is Authenticated) { WidgetsBinding.instance.addPostFrameCallback((_) { Navigator.pushReplacementNamed(ctx, '/home'); }); } }, builder: (context, state) { return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context))),
      body: FadeTransition(
        opacity: _revealController,
        child: Form(
          key: _formKey,
          child: ListView(padding: const EdgeInsets.all(24), children: [
            const Text('59_SignInVariant_AuthFlow', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextFormField(style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: 'Field', labelStyle: TextStyle(color: Colors.white.withOpacity(0.7)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2)), borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () { HapticFeedback.mediumImpact(); setState(() => _isLoading = true); Future.delayed(const Duration(seconds: 1), () { if (mounted) setState(() => _isLoading = false); }); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C63FF), padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: _isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.white))) : const Text('Submit')),
          ]),
        ),
      ),
    );
  }
}







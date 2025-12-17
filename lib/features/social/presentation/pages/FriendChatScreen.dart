import '../../cubits/social_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';


class FriendChatScreen extends StatefulWidget {
  const FriendChatScreen({Key? key}) : super(key: key);
  @override
  State<FriendChatScreen> createState() => _FriendChatScreenState();
}

class _FriendChatScreenState extends State<FriendChatScreen> with SingleTickerProviderStateMixin {
  late AnimationController _revealController, _slideController, _expandController;
  bool _isLoading = false;
  String _errorMessage = '';
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _slideController = AnimationController(duration: const Duration(milliseconds: 500), vsync: this);
    _expandController = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    Future.delayed(const Duration(milliseconds: 200), () { if (mounted) _revealController.forward(); });
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      HapticFeedback.lightImpact();
      setState(() => _messages.add({'sender': 'You', 'text': _messageController.text}));
      _messageController.clear();
    }
  }

  @override
  void dispose() {
    _revealController.dispose();
    _slideController.dispose();
    _expandController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(listener: (ctx, st) {}, builder: (context, state) { return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(backgroundColor: const Color(0xFF16213E), title: const Text('Chat'), elevation: 0),
      body: FadeTransition(
        opacity: _revealController,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) => Align(
                  alignment: _messages[index]['sender'] == 'You' ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: _messages[index]['sender'] == 'You' ? const Color(0xFF6C63FF) : const Color(0xFF16213E),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(_messages[index]['text']!, style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Type message...',
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2)), borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FloatingActionButton(onPressed: _sendMessage, backgroundColor: const Color(0xFF6C63FF), child: const Icon(Icons.send)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





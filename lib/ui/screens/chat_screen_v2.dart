import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  static const String routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hey! Ready for a quiz?', 'isMe': false, 'time': '10:30 AM'},
    {'text': 'Sure! Let\'s do it!', 'isMe': true, 'time': '10:31 AM'},
    {'text': 'Which category?', 'isMe': false, 'time': '10:31 AM'},
    {'text': 'Science sounds good!', 'isMe': true, 'time': '10:32 AM'},
  ];

  final List<String> _quickReplies = [
    'Let\'s play!',
    'Good game!',
    'Challenge me!',
    'Maybe later',
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
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
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: IbeereDesignTokens.primaryPurple, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sarah Johnson', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                Text('Online', style: TextStyle(color: IbeereDesignTokens.accentGreen, fontSize: 11)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg['isMe'] as bool;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                    decoration: BoxDecoration(
                      color: isMe ? IbeereDesignTokens.primaryPurple : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: isMe ? Radius.circular(16) : Radius.circular(4),
                        bottomRight: isMe ? Radius.circular(4) : Radius.circular(16),
                      ),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg['text'] as String,
                          style: TextStyle(color: isMe ? Colors.white : IbeereDesignTokens.textPrimary, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          msg['time'] as String,
                          style: TextStyle(color: isMe ? Colors.white.withOpacity(0.7) : IbeereDesignTokens.textTertiary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: Offset(0, -2))],
            ),
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _quickReplies.map((reply) => Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            _messages.add({'text': reply, 'isMe': true, 'time': '10:35 AM'});
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: IbeereDesignTokens.primaryPurple,
                          side: BorderSide(color: IbeereDesignTokens.primaryPurple.withOpacity(0.3)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        child: Text(reply, style: TextStyle(fontSize: 12)),
                      ),
                    )).toList(),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          filled: true,
                          fillColor: IbeereDesignTokens.backgroundLight,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [IbeereDesignTokens.primaryPurple, IbeereDesignTokens.primaryPink],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send, color: Colors.white, size: 20),
                        onPressed: () {
                          if (_messageController.text.isNotEmpty) {
                            setState(() {
                              _messages.add({'text': _messageController.text, 'isMe': true, 'time': '10:35 AM'});
                              _messageController.clear();
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

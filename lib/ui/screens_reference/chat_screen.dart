import 'package:flutter/material.dart';
import '../../core/theme/design_tokens.dart';
import '../widgets/ibeere_buttons.dart';
import '../widgets/ibeere_cards.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final bool isOnline;

  const ChatScreen({
    Key? key,
    required this.userName,
    this.isOnline = true,
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'Hey! How\'s your quiz streak going?',
      'isFromMe': false,
      'timestamp': '10:30 AM',
    },
    {
      'text': 'Great! Just completed 5 quizzes today 🎉',
      'isFromMe': true,
      'timestamp': '10:32 AM',
    },
    {
      'text': 'That\'s amazing! Want to challenge each other?',
      'isFromMe': false,
      'timestamp': '10:33 AM',
    },
    {
      'text': 'Sure! Let\'s do it',
      'isFromMe': true,
      'timestamp': '10:34 AM',
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add({
          'text': _messageController.text,
          'isFromMe': true,
          'timestamp': 'now',
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: AppBar(
        backgroundColor: DesignTokens.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.userName,
              style: TextStyle(
                color: DesignTokens.primary,
                fontWeight: DesignTokens.fontWeightBold,
                fontSize: DesignTokens.fontSizeLg,
              ),
            ),
            Text(
              widget.isOnline ? 'Online' : 'Offline',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeSm,
                color: widget.isOnline ? Colors.green : Colors.grey[600],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call, color: DesignTokens.primary),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: DesignTokens.primary),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(DesignTokens.spaceLg),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isFromMe = message['isFromMe'] as bool;

                return Padding(
                  padding: EdgeInsets.only(bottom: DesignTokens.spaceMd),
                  child: Row(
                    mainAxisAlignment: isFromMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                    children: [
                      if (!isFromMe)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.grey[600],
                              size: 16,
                            ),
                          ),
                        ),
                      if (!isFromMe) SizedBox(width: DesignTokens.spaceSm),
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.65,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: DesignTokens.spaceMd,
                          vertical: DesignTokens.spaceSm,
                        ),
                        decoration: BoxDecoration(
                          color: isFromMe ? DesignTokens.primary : Colors.grey[200],
                          borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              message['text'] as String,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeBase,
                                color: isFromMe ? Colors.white : Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              message['timestamp'] as String,
                              style: TextStyle(
                                fontSize: DesignTokens.fontSizeSm,
                                color: isFromMe ? Colors.white70 : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isFromMe) SizedBox(width: DesignTokens.spaceSm),
                      if (isFromMe)
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: DesignTokens.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.person_rounded,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Quick Actions
          if (false) // Hide for now, can be toggled
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: DesignTokens.spaceLg,
                vertical: DesignTokens.spaceMd,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.spaceMd,
                        vertical: DesignTokens.spaceSm,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                        border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                      ),
                      child: Text(
                        'Challenge to quiz',
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeSm,
                          color: DesignTokens.primary,
                          fontWeight: DesignTokens.fontWeightMedium,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: DesignTokens.spaceSm),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: DesignTokens.spaceMd,
                      vertical: DesignTokens.spaceSm,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
                      border: Border.all(color: Colors.grey[300] ?? Colors.grey),
                    ),
                    child: Text(
                      'Share quiz',
                      style: TextStyle(
                        fontSize: DesignTokens.fontSizeSm,
                        color: DesignTokens.primary,
                        fontWeight: DesignTokens.fontWeightMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          // Message Input
          Container(
            padding: EdgeInsets.all(DesignTokens.spaceLg),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey[200] ?? Colors.grey),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                        borderSide: BorderSide(color: Colors.grey[300] ?? Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(DesignTokens.radiusFull),
                        borderSide: BorderSide(color: DesignTokens.primary, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: DesignTokens.spaceMd,
                        vertical: DesignTokens.spaceSm,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: DesignTokens.spaceMd),
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: DesignTokens.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

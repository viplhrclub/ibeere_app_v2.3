import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class NotificationsScreenV2 extends StatelessWidget {
  const NotificationsScreenV2({super.key});

  static const String routeName = '/notifications-v2';

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'type': 'quiz_invite',
        'title': 'New Quiz Challenge',
        'message': 'Sarah challenged you to a quiz battle!',
        'time': '2 min ago',
        'icon': Icons.emoji_events,
        'color': IbeereDesignTokens.primaryPurple,
        'read': false,
      },
      {
        'type': 'reward',
        'title': 'Daily Reward Available',
        'message': 'Claim your 50 Kauris daily bonus',
        'time': '1 hour ago',
        'icon': Icons.card_giftcard,
        'color': IbeereDesignTokens.accentYellow,
        'read': false,
      },
      {
        'type': 'achievement',
        'title': 'New Badge Unlocked',
        'message': 'You earned the "Quiz Master" badge!',
        'time': '3 hours ago',
        'icon': Icons.workspace_premium,
        'color': IbeereDesignTokens.accentGreen,
        'read': true,
      },
      {
        'type': 'friend',
        'title': 'Friend Request',
        'message': 'Mike wants to be your friend',
        'time': '1 day ago',
        'icon': Icons.person_add,
        'color': IbeereDesignTokens.primaryPink,
        'read': true,
      },
    ];

    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text('Mark all read', style: TextStyle(color: IbeereDesignTokens.primaryPurple, fontSize: 12)),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          final isRead = notif['read'] as bool;

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isRead ? Colors.white : IbeereDesignTokens.primaryPurple.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: isRead ? Color(0xFFE2E8F0) : IbeereDesignTokens.primaryPurple.withOpacity(0.2), width: 1),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: Offset(0, 2))],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (notif['color'] as Color).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(notif['icon'] as IconData, color: notif['color'] as Color, size: 24),
              ),
              title: Row(
                children: [
                  Expanded(
                    child: Text(
                      notif['title'] as String,
                      style: TextStyle(
                        color: IbeereDesignTokens.textPrimary,
                        fontSize: 15,
                        fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                      ),
                    ),
                  ),
                  if (!isRead)
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: IbeereDesignTokens.primaryPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(notif['message'] as String, style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 13)),
                  const SizedBox(height: 6),
                  Text(notif['time'] as String, style: TextStyle(color: IbeereDesignTokens.textTertiary, fontSize: 11)),
                ],
              ),
              trailing: Icon(Icons.chevron_right, color: IbeereDesignTokens.textSecondary, size: 20),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_cards.dart';
import 'package:flutterquiz/ui/widgets/ibeere_navigation.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_Notification> _notifications = [
    _Notification(
      id: '1',
      title: 'Quiz Available',
      message: 'New Chemistry quiz is now available',
      timestamp: 'Just now',
      icon: Icons.quiz,
      color: DesignTokens.primary,
      isRead: false,
    ),
    _Notification(
      id: '2',
      title: 'Congratulations!',
      message: 'You achieved 100% on Biology Quiz',
      timestamp: '2 hours ago',
      icon: Icons.emoji_events,
      color: DesignTokens.success,
      isRead: false,
    ),
    _Notification(
      id: '3',
      title: 'Friend Achievement',
      message: 'Ahmed Hassan unlocked Quiz Master badge',
      timestamp: '5 hours ago',
      icon: Icons.person,
      color: const Color(0xFF5AC8FA),
      isRead: true,
    ),
    _Notification(
      id: '4',
      title: 'Streak Reminder',
      message: 'Keep your 12-day streak alive!',
      timestamp: 'Yesterday',
      icon: Icons.local_fire_department,
      color: DesignTokens.error,
      isRead: true,
    ),
    _Notification(
      id: '5',
      title: 'Leaderboard Update',
      message: 'You moved up 3 positions on leaderboard',
      timestamp: '2 days ago',
      icon: Icons.trending_up,
      color: DesignTokens.warning,
      isRead: true,
    ),
    _Notification(
      id: '6',
      title: 'New Feature',
      message: 'Check out our new dark mode feature',
      timestamp: '3 days ago',
      icon: Icons.star,
      color: const Color(0xFF8B5CF6),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notifications.where((n) => !n.isRead).length;

    return Scaffold(
      backgroundColor: DesignTokens.background,
      appBar: IbeereAppBar(
        title: 'Notifications',
        showBackButton: false,
        actions: unreadCount > 0
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: DesignTokens.spaceMd),
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        // Mark all as read
                      },
                      child: const Text('Mark all read'),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: _notifications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: DesignTokens.spaceLg),
                  Text(
                    'No Notifications',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: DesignTokens.spaceSm),
                  Text(
                    "You're all caught up!",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: DesignTokens.fontSizeBase,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(DesignTokens.spaceLg),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
                  child: _NotificationCard(notification: notification),
                );
              },
            ),
    );
  }
}

class _NotificationCard extends StatelessWidget {

  const _NotificationCard({required this.notification});
  final _Notification notification;

  @override
  Widget build(BuildContext context) {
    return IbeereCard(
      backgroundColor: notification.isRead
          ? DesignTokens.surface
          : notification.color.withOpacity(0.05),
      elevation: notification.isRead ? 0 : 2,
      padding: const EdgeInsets.all(DesignTokens.spaceMd),
      onTap: () {
        // Navigate to notification details
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: notification.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              notification.icon,
              color: notification.color,
              size: 24,
            ),
          ),
          const SizedBox(width: DesignTokens.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: TextStyle(
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightBold,
                          color: notification.isRead
                              ? Colors.grey[700]
                              : DesignTokens.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!notification.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: notification.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeSm,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: DesignTokens.spaceSm),
                Text(
                  notification.timestamp,
                  style: TextStyle(
                    fontSize: DesignTokens.fontSizeXs,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: DesignTokens.spaceMd),
          PopupMenuButton<void>(
            itemBuilder: (context) => [
              PopupMenuItem<void>(
                child: const Text('Delete'),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Notification {

  _Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    required this.icon,
    required this.color,
    required this.isRead,
  });
  final String id;
  final String title;
  final String message;
  final String timestamp;
  final IconData icon;
  final Color color;
  final bool isRead;
}


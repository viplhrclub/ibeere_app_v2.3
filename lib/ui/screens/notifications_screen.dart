import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _revealController;
  bool _isLoading = false;
  String _errorMessage = '';

  final List<_Notification> _notifications = [
    _Notification(
      title: 'New Quiz Available!',
      message: 'Science category has 10 new questions. Test your knowledge now!',
      time: '2 mins ago',
      icon: Icons.quiz,
      color: Color(0xFF6C63FF),
      isUnread: true,
    ),
    _Notification(
      title: 'Achievement Unlocked',
      message: 'You earned the "Quiz Master" badge for completing 50 quizzes!',
      time: '1 hour ago',
      icon: Icons.emoji_events,
      color: Color(0xFFFFB800),
      isUnread: true,
    ),
    _Notification(
      title: 'Friend Request',
      message: 'Sarah sent you a friend request',
      time: '3 hours ago',
      icon: Icons.person_add,
      color: Color(0xFF10B981),
      isUnread: false,
    ),
    _Notification(
      title: 'Daily Reward',
      message: 'Claim your daily bonus of 100 coins!',
      time: '5 hours ago',
      icon: Icons.card_giftcard,
      color: Color(0xFFEC4899),
      isUnread: false,
    ),
    _Notification(
      title: 'Challenge Accepted',
      message: 'Mike accepted your quiz challenge!',
      time: '1 day ago',
      icon: Icons.sports_esports,
      color: Color(0xFF6C63FF),
      isUnread: false,
    ),
    _Notification(
      title: 'New Level Unlocked',
      message: 'You reached Level 15! Keep going!',
      time: '2 days ago',
      icon: Icons.trending_up,
      color: Color(0xFF10B981),
      isUnread: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _revealController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _revealController.forward();
    });
  }

  @override
  void dispose() {
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              HapticFeedback.lightImpact();
              setState(() {
                for (var notification in _notifications) {
                  notification.isUnread = false;
                }
              });
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: Color(0xFF6C63FF),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _revealController,
        child: _notifications.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.notifications_none,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No notifications yet',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _NotificationCard(
                    notification: notification,
                    onTap: () {
                      HapticFeedback.lightImpact();
                      setState(() {
                        notification.isUnread = false;
                      });
                    },
                  );
                },
              ),
      ),
    );
  }
}

class _Notification {
  final String title;
  final String message;
  final String time;
  final IconData icon;
  final Color color;
  bool isUnread;

  _Notification({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
    this.isUnread = false,
  });
}

class _NotificationCard extends StatelessWidget {
  final _Notification notification;
  final VoidCallback onTap;

  const _NotificationCard({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: notification.isUnread
                ? Colors.white.withOpacity(0.1)
                : Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: notification.isUnread
                  ? notification.color.withOpacity(0.3)
                  : Colors.white.withOpacity(0.1),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: notification.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  notification.icon,
                  color: notification.color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: notification.isUnread
                                  ? FontWeight.bold
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                        if (notification.isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6C63FF),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification.message,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      notification.time,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.5),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

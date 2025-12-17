import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/design_tokens.dart';
import 'package:flutterquiz/ui/widgets/ibeere_buttons.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final List<Map<String, dynamic>> _friends = [
    {
      'name': 'Alice Johnson',
      'score': '8,450',
      'lastSeen': '2 hours ago',
      'isFriend': true,
      'isOnline': true,
    },
    {
      'name': 'Bob Smith',
      'score': '7,230',
      'lastSeen': '1 hour ago',
      'isFriend': true,
      'isOnline': true,
    },
    {
      'name': 'Carol Davis',
      'score': '6,890',
      'lastSeen': '5 hours ago',
      'isFriend': true,
      'isOnline': false,
    },
  ];

  final List<Map<String, dynamic>> _requests = [
    {
      'name': 'David Wilson',
      'score': '5,670',
      'mutualFriends': 3,
    },
    {
      'name': 'Emma Brown',
      'score': '6,340',
      'mutualFriends': 2,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: DesignTokens.background,
        appBar: AppBar(
          backgroundColor: DesignTokens.background,
          elevation: 0,
          title: Text(
            'Friends',
            style: TextStyle(
              color: DesignTokens.primary,
              fontWeight: DesignTokens.fontWeightBold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: DesignTokens.primary),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: TabBar(
            indicatorColor: DesignTokens.primary,
            labelColor: DesignTokens.primary,
            unselectedLabelColor: Colors.grey[500],

            tabs: [
              Tab(text: 'Friends (${_friends.length})'),
              Tab(text: 'Requests (${_requests.length})'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildFriendsTab(),
            _buildRequestsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildFriendsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: _friends.length,
      itemBuilder: (context, index) {
        final friend = _friends[index];
        return Container(
          margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.grey[600],
                          size: 28,
                        ),
                      ),
                    ),
                    if (friend['isOnline'] as bool)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: DesignTokens.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        friend['name'] as String,
                        style: const TextStyle(
                          fontSize: DesignTokens.fontSizeBase,
                          fontWeight: DesignTokens.fontWeightBold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${friend['score']} points',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: DesignTokens.spaceSm),
                          Text(
                            '• ${friend['lastSeen']}',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'remove') {
                      setState(() => _friends.removeAt(index));
                    }
                  },
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                      value: 'message',
                      child: Row(
                        children: [
                          Icon(Icons.message_rounded, color: DesignTokens.primary, size: 18),
                          const SizedBox(width: DesignTokens.spaceSm),
                          const Text('Message'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'challenge',
                      child: Row(
                        children: [
                          Icon(Icons.sports_esports_rounded, color: DesignTokens.primary, size: 18),
                          const SizedBox(width: DesignTokens.spaceSm),
                          const Text('Challenge'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'remove',
                      child: Row(
                        children: [
                          Icon(Icons.person_remove_rounded, color: Colors.red, size: 18),
                          SizedBox(width: DesignTokens.spaceSm),
                          Text('Remove', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: Icon(Icons.more_vert, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRequestsTab() {
    if (_requests.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add_disabled_rounded,
              color: Colors.grey[400],
              size: 60,
            ),
            const SizedBox(height: DesignTokens.spaceLg),
            Text(
              'No friend requests',
              style: TextStyle(
                fontSize: DesignTokens.fontSizeBase,
                color: Colors.grey[600],
                fontWeight: DesignTokens.fontWeightMedium,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(DesignTokens.spaceLg),
      itemCount: _requests.length,
      itemBuilder: (context, index) {
        final request = _requests[index];
        return Container(
          margin: const EdgeInsets.only(bottom: DesignTokens.spaceMd),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(DesignTokens.radiusMd),
            border: Border.all(color: Colors.grey[200] ?? Colors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(DesignTokens.spaceMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: Colors.grey[600],
                          size: 28,
                        ),
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceMd),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            request['name'] as String,
                            style: const TextStyle(
                              fontSize: DesignTokens.fontSizeBase,
                              fontWeight: DesignTokens.fontWeightBold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${request['mutualFriends']} mutual friends',
                            style: TextStyle(
                              fontSize: DesignTokens.fontSizeSm,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DesignTokens.spaceMd),
                Row(
                  children: [
                    Expanded(
                      child: IbeereSecondaryButton(
                        label: 'Decline',
                        onPressed: () {
                          setState(() => _requests.removeAt(index));
                        },
                      ),
                    ),
                    const SizedBox(width: DesignTokens.spaceMd),
                    Expanded(
                      child: IbeerePrimaryButton(
                        label: 'Accept',
                        onPressed: () {
                          _friends.add({
                            'name': request['name'],
                            'score': '0',
                            'lastSeen': 'just now',
                            'isFriend': true,
                            'isOnline': true,
                          });
                          setState(() => _requests.removeAt(index));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


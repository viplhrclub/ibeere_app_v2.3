import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class FriendsListScreen extends StatefulWidget {
  const FriendsListScreen({super.key});

  static const String routeName = '/friends-list';

  @override
  State<FriendsListScreen> createState() => _FriendsListScreenState();
}

class _FriendsListScreenState extends State<FriendsListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        title: Text('Friends', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 18, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: IbeereDesignTokens.primaryPurple),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: IbeereDesignTokens.primaryPurple,
          unselectedLabelColor: IbeereDesignTokens.textSecondary,
          indicatorColor: IbeereDesignTokens.primaryPurple,
          tabs: const [
            Tab(text: 'My Friends'),
            Tab(text: 'Requests'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFriendsList(),
          _buildRequestsList(),
        ],
      ),
    );
  }

  Widget _buildFriendsList() {
    final friends = [
      {'name': 'Sarah Johnson', 'status': 'online', 'score': 2450},
      {'name': 'Mike Chen', 'status': 'offline', 'score': 1890},
      {'name': 'Emma Wilson', 'status': 'online', 'score': 3200},
      {'name': 'Alex Brown', 'status': 'offline', 'score': 1650},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        final isOnline = friend['status'] == 'online';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: IbeereDesignTokens.primaryPurple.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: IbeereDesignTokens.primaryPurple, size: 26),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: isOnline ? IbeereDesignTokens.accentGreen : IbeereDesignTokens.textTertiary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(friend['name'] as String, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.stars, size: 14, color: IbeereDesignTokens.accentYellow),
                        const SizedBox(width: 4),
                        Text('${friend['score']} points', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: IbeereDesignTokens.primaryPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                child: Text('Challenge', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRequestsList() {
    final requests = [
      {'name': 'David Lee', 'mutualFriends': 5},
      {'name': 'Lisa Park', 'mutualFriends': 3},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: requests.length,
      itemBuilder: (context, index) {
        final request = requests[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 6)],
          ),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: IbeereDesignTokens.primaryPink.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person, color: IbeereDesignTokens.primaryPink, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(request['name'] as String, style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text('${request['mutualFriends']} mutual friends', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.check_circle, color: IbeereDesignTokens.accentGreen),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.cancel, color: IbeereDesignTokens.primaryRed),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

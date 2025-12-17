import 'package:flutter/material.dart';
import 'package:flutterquiz/core/theme/ibeere_tokens.dart';

class BattleRoomJoinV2 extends StatefulWidget {
  const BattleRoomJoinV2({super.key});

  @override
  State<BattleRoomJoinV2> createState() => _BattleRoomJoinV2State();
}

class _BattleRoomJoinV2State extends State<BattleRoomJoinV2> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IbeereDesignTokens.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back, color: IbeereDesignTokens.textPrimary)),
        title: Text('Battle Room', style: TextStyle(color: IbeereDesignTokens.textPrimary, fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
        bottom: TabBar(controller: _tabController, labelColor: IbeereDesignTokens.primaryPurple, unselectedLabelColor: IbeereDesignTokens.textSecondary, indicatorColor: IbeereDesignTokens.primaryPurple, tabs: [Tab(text: 'CREATE'), Tab(text: 'JOIN')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_circle_outline, size: 80, color: IbeereDesignTokens.primaryPurple), const SizedBox(height: 24), Text('Create Battle Room', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: IbeereDesignTokens.textPrimary)), const SizedBox(height: 32), ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/battle-room-created');}, style: ElevatedButton.styleFrom(backgroundColor: IbeereDesignTokens.primaryPurple, foregroundColor: Colors.white, padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))), child: Text('Create Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))])),
          Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Container(padding: const EdgeInsets.all(20), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [IbeereDesignTokens.cardShadow]), child: TextField(controller: _pinController, keyboardType: TextInputType.number, textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 8), decoration: InputDecoration(hintText: 'Room PIN Code', border: InputBorder.none))), const SizedBox(height: 24), SizedBox(width: double.infinity, height: 56, child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, '/battle-countdown');}, style: ElevatedButton.styleFrom(backgroundColor: IbeereDesignTokens.primaryPurple, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))), child: Text('Join Room', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)))), const SizedBox(height: 48), Text('OR', style: TextStyle(color: IbeereDesignTokens.textSecondary, fontSize: 16)), const SizedBox(height: 24), TextButton(onPressed: () {}, child: Text('Play Solo', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: IbeereDesignTokens.primaryPurple)))])),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pinController.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

final class PlayZoneTabScreen extends StatefulWidget {
  const PlayZoneTabScreen({super.key});

  @override
  State<PlayZoneTabScreen> createState() => PlayZoneTabScreenState();
}

final class PlayZoneTabScreenState extends State<PlayZoneTabScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: Center(
        child: Text('Play Zone'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Displays detailed information about a SampleItem.
class GameLoadingView extends StatelessWidget {
  const GameLoadingView({super.key});

  static const routeName = '/game';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Lobby'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'widget/message.dart';
import 'widget/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),

          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
        ],
      ),
      body: const Column(
        children:
        [
          Expanded(child: Messages()),
          NewMessage(),
        ],
      ),
    );
  }
}

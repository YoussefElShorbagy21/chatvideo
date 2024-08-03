import 'package:flutter/material.dart';

import 'widget/audio_call_screen.dart';
import 'widget/message.dart';
import 'widget/new_message.dart';
import 'widget/video_call_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key, required this.receiverId});
  final String receiverId ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AudioCallScreen()));
            },
          ),

          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const VideoCallScreen()));
            },
          ),
        ],
      ),
      body: Column(
        children:
        [
          Expanded(child: Messages(
            receiverId: receiverId,
          )),
          NewMessage(
            receiverId: receiverId,
          ),
        ],
      ),
    );
  }
}

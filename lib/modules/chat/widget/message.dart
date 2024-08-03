import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key, required this.receiverId}) : super(key: key);
  final String receiverId ;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(
            FirebaseAuth.instance.currentUser!.uid
        ).collection('chats').doc(receiverId).collection('message').orderBy(
            'createdAt', descending: true).snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(),);
          }
          final doc = snapshots.data!.docs;
          return ListView.builder(
            reverse: true,
            itemCount: doc.length,
            itemBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageBubble(
                    doc[index]['text'],
                    doc[index]['username'],
                    doc[index]['userImage'],
                    doc[index]['userId'] ==
                        FirebaseAuth.instance.currentUser!.uid,
                    ValueKey(doc[index].id),
                  ),
                ),
          );
        }
    );
  }
}

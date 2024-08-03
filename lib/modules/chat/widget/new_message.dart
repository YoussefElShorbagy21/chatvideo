import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key, required this.receiverId});
  final String receiverId  ;
  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController() ;
  String _enteredMessage = ""  ;
  bool _color = false ;
  _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user =  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    FirebaseFirestore.instance.collection('users').doc(user.uid).collection('chats')
        .doc(widget.receiverId)
        .collection('message')
        .add({
      'text': _enteredMessage,
      'createdAt' : Timestamp.now(),
      'username': userData['name'],
      'userId': user.uid,
      'userImage': userData['image']
    });

    FirebaseFirestore.instance.collection('users').doc(widget.receiverId).collection('chats')
        .doc(user.uid)
        .collection('message')
        .add({
      'text': _enteredMessage,
      'createdAt' : Timestamp.now(),
      'username': userData['name'],
      'userId': user.uid,
      'userImage': userData['image']
    });
    _controller.clear();
    _color = false ;
    setState(() {
      _enteredMessage = '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children:
        [
          Expanded(child:
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Send a Message'),
            onChanged: (value)
            {
              setState(() {
                _enteredMessage = value ;
                _color = true ;
              });
            },
          ),
          ),
          IconButton(
            color: _color == false ? null : Theme.of(context).primaryColor,
              onPressed: (){
                if(_enteredMessage.trim().isEmpty)
                  {
                    if (kDebugMode) {
                      print(_enteredMessage) ;
                      print(kDebugMode);
                    }
                  }
                else
                  {
                    _sendMessage();
                  }
              },
              icon:  const Icon(Icons.send,)),
        ],
      ),
    );
  }
}

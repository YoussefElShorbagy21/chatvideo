import 'package:flutter/material.dart';

class UsersMessage extends StatelessWidget {
  const UsersMessage({super.key, required this.user});
  final dynamic user;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(user['name'] ?? ''),
      subtitle: Text(user['email'] ?? ''),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user['image'] ??''),
      ),

    );
  }
}
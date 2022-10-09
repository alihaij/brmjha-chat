import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(this.name, {Key? key}) : super(key: key);
  final String name;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('welcome ${widget.name}'),
      ),
    );
  }
}

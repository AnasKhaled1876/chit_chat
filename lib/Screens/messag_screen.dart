import 'package:chit_chat/models/Message.dart';
import 'package:chit_chat/models/contact.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            CircleAvatar(
              child: widget.contact.image,
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: <Widget>[
                Text(
                  widget.contact.name,
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  widget.contact.recentMessage,
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: ListView.builder(
                itemBuilder: (context, index) => MessageBubble())),
            const TextingBar(),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: ,
    );
  }
}


class TextingBar extends StatelessWidget {
  const TextingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(offset: Offset(0, 4), blurRadius: 32, color: Colors.black),
        ],
        color: Theme
            .of(context)
            .scaffoldBackgroundColor,
      ),
      child: SafeArea(
        child: Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.sentiment_satisfied_alt_outlined),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type a Message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.attach_file),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.camera_alt),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../models/contact.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, required this.contacts}) : super(key: key);

  final List<Contact> contacts;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        centerTitle: true,
        title: const Text("Chit Chat"),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) =>
              ContactTile(contact: widget.contacts[index]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People")
      ]),
    );
  }
}

class ContactTile extends StatefulWidget {
  const ContactTile({Key? key, required this.contact}) : super(key: key);
  final Contact contact;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Stack(
              children: <Widget>[
                CircleAvatar(
                  child: widget.contact.image,
                  radius: 30,
                ),
                Positioned(
                  left: 40,
                  bottom: 10,
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 3)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.contact.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.contact.recentMessage,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Opacity(opacity: 0.75, child: Text(widget.contact.recentMessage))
          ],
        ),
      ),
    );
  }
}

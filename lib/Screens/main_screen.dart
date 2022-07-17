import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu),
          centerTitle: true,
          title: const Text("Chit Chat"),
        ),
        body: ListView(
          children: <Widget>[
           ContactTile(contactName: "Anas", contactImage: Image.asset("")) 
          ],
        ),
      ),
    );
  }
}

class ContactTile extends StatefulWidget {
  const ContactTile(
      {Key? key, required this.contactName, required this.contactImage})
      : super(key: key);
  final String contactName;
  final Image contactImage;

  @override
  State<ContactTile> createState() => _ContactTileState();
}

class _ContactTileState extends State<ContactTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: widget.contactImage,
      ),
      title: Text(widget.contactName),
    );
  }
}

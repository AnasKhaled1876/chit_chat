import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    String userName;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          const SizedBox(
              width: 300,
              height: 200,
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/logo.png"),
              )),
          ElevatedButton(
            onPressed: () async{
              final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
            },
            child: const Icon(Icons.photo, color: Colors.black),
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(20),
              primary: Colors.blue,
              onPrimary: Colors.red,
            ),
          ),
          TextField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                hintText: 'Michael Jordan',
                labelText: 'Name'),
            onChanged: (name) {
              userName = name;
            },
          ),
        ],
      ),
    );
  }
}

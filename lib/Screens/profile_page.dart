import 'dart:convert';
import 'dart:io';

import 'package:chit_chat/Screens/main_screen.dart';
import 'package:chit_chat/Screens/signup_page.dart';
import 'package:chit_chat/models/contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getImage() async {
    final _picker = ImagePicker();
    final image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    String userName = "";
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 150,
                  child: _image != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(File(_image!.path)),
                        )
                      : CircleAvatar(
                          child:
                              Image.asset("assets/logo.png", fit: BoxFit.fill),
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    setState(() async {
                      getImage();
                    });
                  },
                  child: const Icon(Icons.photo, color: Colors.black),
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                    primary: Colors.blue,
                    onPrimary: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: const Color(0xFF245780),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0)),
                        hintText: 'Michael Jordan',
                        labelText: 'Name'),
                    onChanged: (name) {
                      userName = name;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (userName.isNotEmpty) {
                        List<int> imageBytes = await _image!.readAsBytes();
                        final Map<String, String> newUser = {
                          "name": userName,
                          "phone": SignUpPage.auth.currentUser!.phoneNumber
                              .toString(),
                          "image": base64Encode(imageBytes),
                        };
                        _firestore
                            .collection("users")
                            .add(newUser)
                            .whenComplete(() {
                          var snackBar = const SnackBar(
                              content: Text('Welcome to ChitChat'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(
                              contacts: [
                                Contact(
                                    "ali", Image.asset("assets/logo.png"), "my")
                              ],
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: const Size(300, 60)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

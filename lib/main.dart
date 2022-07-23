import 'package:chit_chat/Screens/logo_page.dart';
import 'package:chit_chat/Screens/main_screen.dart';
import 'package:chit_chat/Screens/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/message_screen.dart';
import 'firebase_options.dart';
import 'models/Message.dart';
import 'models/contact.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    List<Contact> contacts = [
      Contact("Anas", Image.asset("assets/logo.png", fit: BoxFit.fill), "ولا")
    ];
    return const MaterialApp(
      home: LogoPage(),
    );
  }
}

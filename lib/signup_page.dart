import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int number = 0;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 300),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  hintText: '+20101234567',
                  labelText: 'Phone number'),
              onChanged: (Number) {
                number = Number as int;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async{
              await Firebase.initializeApp();

            },
            child: const Text("Continue",style: TextStyle(fontSize: 20),),
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.black, minimumSize: const Size(300, 60)),
          )
        ],
      ),
    );
  }
}

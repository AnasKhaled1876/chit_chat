import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return false ? const OTTPPage() :const PhonePage();
  }
}

class PhonePage extends StatelessWidget {
  const PhonePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    FirebaseAuth _auth = FirebaseAuth.instance;
    String phoneNumber = "";
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 2.0)),
                  hintText: '+20101234567',
                  labelText: 'Phone number'),
              onChanged: (number) {
                phoneNumber = number;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (phoneNumber.isNotEmpty) {
                loading = true;
                await _auth.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (phoneAuthCred) {
                      print(phoneAuthCred.smsCode);
                    },
                    verificationFailed: (verificationFailed) {
                      loading = false;
                      print(verificationFailed.message.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(verificationFailed.message.toString())));
                    },
                    codeSent: (verificationID, resendingToken) {
                      loading = false;
                      print(verificationID.toString());

                    },
                    codeAutoRetrievalTimeout: (verificationID) {});
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.black, minimumSize: const Size(300, 60)),
          ),
          if (loading == true)
            const CircularProgressIndicator(color: Colors.black)
        ],
      ),
    );
  }
}

class OTTPPage extends StatelessWidget {
  const OTTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String OTTP ="";
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                hintText: '+123456',
                labelText: 'SMS Code'),
            onChanged: (number) {
              OTTP = number;
            },)
        ],
      ),
    );
  }
}

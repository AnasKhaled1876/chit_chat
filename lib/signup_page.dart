import 'dart:ffi';

import 'package:chit_chat/logo_page.dart';
import 'package:chit_chat/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static final  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String verifyID="";
  bool codeSent=false;
  bool loading = false;


  phoneWidget(BuildContext context) {

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
                setState(() {
                  loading = true;
                });

                await SignUpPage.auth.verifyPhoneNumber(
                    phoneNumber: phoneNumber,
                    verificationCompleted: (phoneAuthCred) {
                      print(phoneAuthCred.smsCode);
                    },
                    verificationFailed: (verificationFailed) {
                      setState(() {
                        loading = false;
                      });
                      print(verificationFailed.message.toString());
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                          Text(verificationFailed.message.toString())));
                    },
                    codeSent: (verificationID, resendingToken) {
                      setState(() {
                        codeSent=true;
                        loading = false;
                      });
                      verifyID=verificationID;
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

  void signWithPhoneCredit(PhoneAuthCredential phoneAuthCredential) async{
    try{
      setState(() {
        loading=true;
      });
      final authCreditenial = await SignUpPage.auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        loading=false;
      });
      if(SignUpPage.auth.currentUser != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
      }
    }on FirebaseException catch (e){
      setState(() {
        loading=false;
      });
    }
  }

  oTTPWidget(BuildContext context) {
    String OTTP = "";
    return Scaffold(
      body: Column(
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0)),
                hintText: '313566',
                labelText: 'SMS Code'),
            onChanged: (number) {
              OTTP = number;
            },
          ),ElevatedButton(
            onPressed: () {
              if(OTTP.isNotEmpty) {
                final phoneCredential = PhoneAuthProvider.credential(verificationId: verifyID, smsCode: OTTP);
                signWithPhoneCredit(phoneCredential);
              }
            },
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 20),
            ),
            style: ElevatedButton.styleFrom(
                onPrimary: Colors.black, minimumSize: const Size(300, 60)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: codeSent ? oTTPWidget(context): phoneWidget(context)   ,);
  }
}
import 'package:chit_chat/Screens/signup_page.dart';
import 'package:flutter/material.dart';

class LogoPage extends StatelessWidget {
  const LogoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2),() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
    });
    return Container(
      color: const Color(0xFF2e98f0),
      child:
        Center(child: Image.asset("assets/logo.png"))
    );
  }
}

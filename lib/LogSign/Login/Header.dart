import 'package:flutter/material.dart';
class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
            image: const AssetImage('assets/images/zorko__1_-removebg-preview.png'),
            height: size.height * 0.4,
        ),
        Text("Welcome Back,", style: TextStyle(color: Colors.black87,fontSize: 40,fontWeight: FontWeight.w500)),
        //Text("Make it work, make it right, make it fast.", style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
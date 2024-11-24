
import 'dart:async';
import 'package:firesotre_crud/view/auth_directory/signup_screen.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
  Timer(Duration(seconds: 3), () {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignupScreen()));
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              CircleAvatar(
                maxRadius: 50,
               child: ClipOval(
                 child: Center(child: Image.asset('assets/images/database',fit: BoxFit.cover,)),
               ),
              )
        ],
      ),
    );
  }
}

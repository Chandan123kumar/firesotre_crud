import 'dart:developer';

import 'package:firesotre_crud/controller/auth_service/auth_service.dart';
import 'package:firesotre_crud/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  AuthService authService=AuthService();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20,),
          const Text('LogIn Page',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.pink),),
          const SizedBox(height: 10,),
          _textFormField(_emailController, 'enter email'),
          _textFormField(_passwordController, 'enter password'),
          const SizedBox(height: 10,),
          ElevatedButton(
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 15),backgroundColor: Colors.pink),
              onPressed: (){
                _logIn();
              }, child: const Text('LogIn',style: TextStyle(color: Colors.white),))
        ],
      )),

    );
  }
  Widget _textFormField(TextEditingController controller,String hintText,{bool obscureText =false}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 10,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText:hintText,
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
          ),
        ),
      ),
    );
  }
  Future<void> _logIn()async{
    try{
      var user=await authService.loginUserWithEmail(_emailController.text, _passwordController.text);
      if (user!=null) {
        Fluttertoast.showToast(msg: 'User Login Successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      }    }catch(ex){
      log('Something went wrong');

    else{
        Fluttertoast.showToast(msg: 'Please enter valid email or password');
      }
    }
  }
  }

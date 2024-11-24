import 'dart:developer';
import 'package:firesotre_crud/controller/auth_service/auth_service.dart';
import 'package:firesotre_crud/model/user_model.dart';
import 'package:firesotre_crud/view/auth_directory/login_screen.dart';
import 'package:firesotre_crud/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();
  TextEditingController _addressController=TextEditingController();
  TextEditingController _genderController=TextEditingController();
  TextEditingController _numberController=TextEditingController();
  AuthService authService= AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('SignUp Page',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.pink),),
            SizedBox(height: 20,),
            _textFormField(_nameController, 'enter name'),
            _textFormField(_emailController, 'enter email'),
            _textFormField(_passwordController, 'enter password',obscureText: true),
            _textFormField(_addressController, 'enter address'),
            _textFormField(_genderController, 'enter gender'),
            _textFormField(_numberController, 'enter number'),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account'),
                InkWell(child: Text('LogIn',style: TextStyle(color: Colors.pink),),
                  onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                ),
              ],
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),backgroundColor: Colors.pink),
                onPressed: (){
                _signUp();
                _storeData();
                _clear();
                }, child: Text('SignUp',style: TextStyle(color: Colors.white),))
          ],
        ),
      )),
    );
  }

Widget _textFormField(TextEditingController controller,String hintText,{bool obscureText=false}){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 10,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration:InputDecoration(
            hintText:  hintText,
            contentPadding: const EdgeInsets.only(left: 10),
            disabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
            enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.pink))
          ) ,
        ),
      ),
    );
}

Future<void> _signUp()async{
    try{
      var user=await authService.signUpWithEmail(
          _emailController.text,
          _passwordController.text);

      if(user!=null){
        Fluttertoast.showToast(msg: 'User Register successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
      }
      else{
        Fluttertoast.showToast(msg: 'please fill all the fields');
      }
    }catch(ex){
      log('something went wrong');
    }
}

void _clear(){
   _nameController.clear();
   _emailController.clear();
   _passwordController.clear();
   _addressController.clear();
   _genderController.clear();
   _numberController.clear();
}

void _storeData()async{
  final String name=_nameController.text;
  final String email=_emailController.text;
  final String password=_passwordController.text;
  final String address=_addressController.text;
  final String gender=_genderController.text;
  final String number=_numberController.text;
  final String userId=randomAlphaNumeric(10);
try{
  var data=UserModel(
      userId: userId,
      name: name,
      email: email,
      password: '',
      address: address,
      gender: gender,
      num: number
  );
  await authService.storeUserData(data);
  Fluttertoast.showToast(msg: 'User data Stored successfully');
}catch(ex){

}
  }
}

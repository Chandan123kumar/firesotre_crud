import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesotre_crud/model/user_model.dart';
import 'package:firesotre_crud/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UpdatePage extends StatefulWidget {
  String userId;
  String name;
  String email;
  String address;
  String gender;
  String number;

  UpdatePage({super.key,
    required this.userId,
    required this.name,
    required this.email,
    required this.address,
    required this.gender,
    required this.number});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
    _addressController = TextEditingController(text: widget.address);
    _genderController = TextEditingController(text: widget.gender);
    _numberController = TextEditingController(text: widget.number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(border: Border.all(color: Colors.pink)),
        child: SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 38.0),
                  child: Text(
                    'Update Page',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent),
                  ),
                ),
                _textFormField(_nameController),
                _textFormField(_emailController),
                _textFormField(_addressController),
                _textFormField(_genderController),
                _textFormField(_numberController),
                SizedBox(height: 20,),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 60,vertical: 15),backgroundColor: Colors.pinkAccent),
                    onPressed: (){
                      _updateData();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                    }, child: Text('Update'))
              ],
            )),
      ),
    );
  }

  Widget _textFormField(TextEditingController controller,
      {bool obscureText = false}) {
    return Card(
      color: Colors.white,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: const InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
            enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
            disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.pink))),
      ),
    );
  }

  Future<void> _updateData() async {
    var userId = widget.userId;
    var name = _nameController.text;
    var email = _emailController.text;
    var address = _addressController.text;
    var gender = _genderController.text;
    var number = _numberController.text;

    if (name.isNotEmpty && email.isNotEmpty && address.isNotEmpty &&
        gender.isNotEmpty && number.isNotEmpty) {
      var data = UserModel(
          userId: userId,
          name: name,
          email: email,
          password: 'password',
          address: address,
          gender: gender,
          num: number);
      try{
        _startProgress();
        firestore.collection('UserInfo').doc(widget.userId).update(data.toMap());
        Fluttertoast.showToast(msg: 'User updated Successfully');
      }catch(ex){

      }
    }
  }
  void _startProgress(){
    setState(() {
      isUpdating=true;
    });
  }
}

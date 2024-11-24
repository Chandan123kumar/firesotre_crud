import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firesotre_crud/controller/auth_service/auth_service.dart';
import 'package:firesotre_crud/model/user_model.dart';
import 'package:firesotre_crud/view/auth_directory/login_screen.dart';
import 'package:firesotre_crud/view/auth_directory/signup_screen.dart';
import 'package:firesotre_crud/view/intro/update_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FireStore Crud',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
              onPressed: () {
                logoutUser();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignupScreen()));
        },
        label: Text(
          'Add',
          style: TextStyle(color: Colors.white),
        ),
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colors.pink,
        onRefresh: () async {
          getUser();
        },
        child: SafeArea(
            child: StreamBuilder<List<UserModel?>>(
                stream: getUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('something went wrong'),
                    );
                  }
                  final user = snapshot.data;
                  return ListView.builder(
                      itemCount: user?.length,
                      itemBuilder: (context, index) {
                        final userData = user![index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, right: 8, top: 10),
                          child: InkWell(
                            onLongPress: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => UpdatePage(
                                      userId: userData.userId,
                                      name: userData.name,
                                      email: userData.email,
                                      address: userData.address,
                                      gender: userData.gender,
                                      number: userData.num)));
                            },
                            child: Card(
                              elevation: 5,
                              color: Colors.white54,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData!.name,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    userData.email,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    userData.address,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    userData.gender,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    userData.num,
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  IconButton(onPressed: () {
                                    _showDialog(userData.userId);
                                  },
                                      icon: Icon(
                                        Icons.delete, color: Colors.pink,))
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                })),
      ),
    );
  }

  void logoutUser() async {
    await authService.logOut();
  }

  Stream<List<UserModel?>> getUser() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return firestore.collection('UserInfo').snapshots().map((snapshot) {
      return snapshot.docs.map(
            (doc) {
          return UserModel.fromMap(doc.data(), doc.id);
        },
      ).toList();
    });
  }

  Future<void> deleteUser(String userId) async {
    try {
      await FirebaseFirestore.instance.collection('UserInfo')
          .doc(userId)
          .delete();
      Fluttertoast.showToast(msg: 'User deleted ');
    } catch (ex) {
      print('something went wrong');
    }
  }

  void _showDialog(String userId) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Delete User'),
          content: Text('Are you sure'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                deleteUser(userId);
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}

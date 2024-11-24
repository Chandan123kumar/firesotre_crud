import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firesotre_crud/model/user_model.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      var cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (ex) {
      log('something went wrong $ex');
      return null;
    }
  }

  Future<User?> loginUserWithEmail(String email, String password) async {
    try {
      var cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (ex) {
      log('something went wrong');
    }
    return null;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
  Future<void>storeUserData(UserModel usermodel)async{
      var useId=usermodel.userId;
      if (useId==null|| useId.isEmpty) {
        print('userId is null');
      }
      try{
        await FirebaseFirestore.instance.collection('UserInfo').doc(useId).set(usermodel.toMap());
        print('user data stored successfully');
      }catch(ex){
       print('something went wrong');
      }
  }
}

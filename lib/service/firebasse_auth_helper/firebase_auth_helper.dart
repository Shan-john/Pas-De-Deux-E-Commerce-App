import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:screw/constant/constants.dart';
import 'package:screw/models/User_Model/user_model.dart';

class FirebaseAuthHelper {
  static FirebaseAuthHelper instance = FirebaseAuthHelper();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream notifiyier
  Stream<User?> get getAuthChange => _auth.authStateChanges();
//firebase login function
  Future<bool?> login(
      String email, String password, BuildContext context) async {
    try {
      showloaderDailog(context);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.of(context).pop();
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      ShowMessage(error.code.toString());
      return false;
    }
  }

  // fire base signUP function
  Future<bool?> signUp(
    String email,
    String password,
    BuildContext context,
    String name,
  
  ) async {
    try {
      showloaderDailog(context);
      UserCredential? userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel usermodel = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          image: null,
         );
      _firestore.collection("users").doc(usermodel.id).set(usermodel.toJson());
      return true;
    } on FirebaseAuthException catch (error) {
      Navigator.of(context).pop();
      ShowMessage(error.code.toString());
      return false;
    }
  }

// fire base Sign out function..
  Future<bool?> logout() async {
    try {
      await _auth.signOut();
      ShowMessage("Sign Out");
      return true;
    } catch (error) {
      ShowMessage(error.toString());
      return false;
    }
  }
// function for change password// future purp
  // Future<bool?> changePassword(newPassword) async {
  //    _auth.currentUser!.updatePassword(newPassword);
  //   ShowMessage("Password Ppdated");
  //   return true;
  // }
  // function for change phone number
  // Future<bool?> changePhonenumber(newPhonenumber) async {
  //    _auth.currentUser!.updatePhoneNumber(newPhonenumber);
  //   ShowMessage("Password Ppdated");
  //   return true;
  // }
}

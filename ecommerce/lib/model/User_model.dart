import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model {
  FirebaseAuth fire = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  static UserModel of(BuildContext context) => ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    //_loadCurrentUser();
  }

  void signUp(
      {@required Map<String, dynamic> userData,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail}) {
    this.isLoading = true;
    notifyListeners();

    this
        .fire
        .createUserWithEmailAndPassword(
            email: userData['email'], password: userData['senha'])
        .then((response) async {
      firebaseUser = response;
      await _saveUserData(userData);
      onSuccess();
      this.isLoading = false;
      notifyListeners();
    }).catchError((error) {
      onFail();
      this.isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> user) async {
    this.userData = user;
    await Firestore.instance
        .collection("usuarios")
        .document(firebaseUser.uid)
        .setData(user);
  }

  bool isLoggedIn() {
    return firebaseUser != null;
  }

  void signIn(
      {@required String email,
      @required String pass,
      @required VoidCallback onSuccess,
      @required VoidCallback onFail})
  async {
    isLoading = true;
    notifyListeners();

    fire
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) async {
      firebaseUser = user;

      await _loadCurrentUser();

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e) {
      onFail();
      isLoading = false;
      notifyListeners();
    });
  }

  Future signOut() async {
    await fire.signOut();

    userData = Map();
    firebaseUser = null;

    notifyListeners();
  }

  Future<Null> _loadCurrentUser() async {
    if(firebaseUser == null)
      firebaseUser = await fire.currentUser();
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser =
        await Firestore.instance.collection("usuarios").document(firebaseUser.uid).get();
        userData = docUser.data;
      }
    }
    notifyListeners();
  }

  void recoverPass(String email){
    fire.sendPasswordResetEmail(email: email);
  }
}

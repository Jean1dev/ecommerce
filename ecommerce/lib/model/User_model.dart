import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth fire = FirebaseAuth.instance;
  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();
  bool isLoading = false;

  void signUp({
    @required Map<String, dynamic> userData,
    @required String pass,
    @required VoidCallback onSuccess,
    @required VoidCallback onFail})
  {
    this.isLoading = true;
    notifyListeners();

    this.fire.createUserWithEmailAndPassword(email: userData['email'], password: userData['senha']).then((response) async {
      firebaseUser = response;
      await _saveUserData(userData);
      onSuccess();
      this.isLoading = false;
      notifyListeners();

    }).catchError((error){
      onFail();
      this.isLoading = false;
      notifyListeners();
    });
  }

  Future<Null> _saveUserData(Map<String, dynamic> user) async {
    this.userData = user;
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(user);
  }

}
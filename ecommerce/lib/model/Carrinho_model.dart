import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {

  List<Carrinho> products = [];
  bool isLoading = false;
  UserModel user;

  CarrinhoModel(this.user);

  static CarrinhoModel of(BuildContext context) => ScopedModel.of<CarrinhoModel>(context);

  void addItem(Carrinho item){
    products.add(item);

    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho").add(item.toMap())
    .then((doc){
      item.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeItem(Carrinho item){
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho").document(item.cid).delete();
    products.remove(item);
    notifyListeners();
  }

}
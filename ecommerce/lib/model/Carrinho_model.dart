import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {

  List<Carrinho> products = [];
  bool isLoading = false;
  UserModel user;

  CarrinhoModel(this.user){
    if(user.isLoggedIn()){
      _loadCartItens();
    }
  }

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

  void decProduto(Carrinho item){
    item.qtd--;
    
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho")
    .document(item.cid).updateData(item.toMap());
    notifyListeners();
  }

  void incProduto(Carrinho item){
    item.qtd++;

    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho")
        .document(item.cid).updateData(item.toMap());
    notifyListeners();
  }

  //ATENCAO AQUI
  void _loadCartItens() async {
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho")
        .getDocuments() as QuerySnapshot;

    products = query.documents.map((doc) => Carrinho.fromDocument(doc)).toList();
    notifyListeners();
  }


}
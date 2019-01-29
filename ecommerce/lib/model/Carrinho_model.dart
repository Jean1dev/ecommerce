import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CarrinhoModel extends Model {

  List<Carrinho> products = [];
  String cupomCode;
  int discountPercent = 0;
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

  void setDesconto(String cupomCode, int percent){
    this.cupomCode = cupomCode;
    this.discountPercent = percent;
  }

  double getProductsPrice(){
    double price = 0.0;
    for(Carrinho c in products){
      if(c.data != null){
        price += c.qtd * c.data.price;
      }
    }
    return price;
  }

  double getShipPrice(){
    return 0.0;
  }

  double getDiscount(){
    return this.getProductsPrice() * this.discountPercent / 100;
  }

  void updatePrices(){
    notifyListeners();
  }
  
  Future<String> finishOrder() async {
    if(products.length == 0){
      return "";
    }
    
    isLoading = true;
    notifyListeners();
    double prod_price = getProductsPrice();
    double ship_price = getShipPrice();
    double disc_price = getDiscount();
    
    DocumentReference ref = await Firestore.instance.collection("pedidos").add(
      {
        "clienteId": user.firebaseUser.uid,
        "products": products.map((Carrinho) => Carrinho.toMap()).toList(),
        "shipPrice": ship_price,
        "productPrice": prod_price,
        "discPrice": disc_price,
        "total": prod_price + ship_price - disc_price,
        "status": 1
      }
    );
    
    Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("pedidos").document(ref.documentID).setData(
      {
        "id": ref.documentID
      }
    );
    
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(user.firebaseUser.uid).collection("carrinho").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    products.clear();
    discountPercent = 0;
    cupomCode = null;
    isLoading = false;
    notifyListeners();

    return ref.documentID;
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';

class Produto {

  String id;
  String title;
  String desc;
  double price;
  List images;
  List size;
  String categoria;

  Produto.fromDocument(DocumentSnapshot snapshot){
    this.id = snapshot.documentID;
    this.title = snapshot.data["title"];
    this.desc = snapshot.data["desc"];
    this.price = snapshot.data["price"];
    this.images = snapshot.data["images"];
    this.size = snapshot.data['size'];
  }
}
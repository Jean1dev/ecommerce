import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Produto.dart';

class Carrinho {

  String cid;
  String categoria;
  String produto_id;
  int qtd;
  String size;

  Produto data;

  Carrinho.fromDocument(DocumentSnapshot document){
    cid = document.documentID;
    categoria = document.data["categoria"];
    produto_id = document.data["produto_id"];
    qtd = document.data["qtd"];
    size = document.data["size"];
  }

  Carrinho();

  Map<String, dynamic> toMap() {
    return{
      "categoria": categoria,
      "produto_id": produto_id,
      "size": size,
      "qtd": qtd,
      "produto": data.toResumedMap()
    };
  }
}
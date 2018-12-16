import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/menu/Categoria_item.dart';
import 'package:flutter/material.dart';

class ProdutoTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: Firestore.instance.collection("produtos").getDocuments(),
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator(),);
        }else{

          var dividetTiles = ListTile.divideTiles(tiles: snapshot.data.documents.map((doc) {
            return CategoriaItem(doc);
          }).toList(),
          color: Colors.grey[500]).toList();


          return ListView(
            children: dividetTiles,
          );
        }
      },
    );
  }
}

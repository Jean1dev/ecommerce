import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/janelas/Produtos_screen.dart';
import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoriaItem(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25.0,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.data["icon"]),
      ),
      title: Text(snapshot.data["title"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ProdutoScreen(snapshot))
        );
      },
    );
  }
}

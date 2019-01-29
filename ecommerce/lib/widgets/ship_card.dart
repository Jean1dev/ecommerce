import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho_model.dart';
import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Calcular Frete",
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.location_on),
        trailing: Icon(Icons.arrow_back),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu CEP"
              ),
              initialValue: "",
              onFieldSubmitted: (text){

              },
            ),
          )
        ],
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/janelas/Login_screen.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:ecommerce/tiles/order_tile.dart';
import 'package:flutter/material.dart';

class OrdersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(UserModel.of(context).isLoading){

      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("usuarios").document(uid).collection("pedidos").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
            return ListView(
              children: snapshot.data.documents.map((doc) => OrderTile(doc.documentID)).toList().reversed.toList(),
            );
          }
        },
      );
    }else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.view_list, size: 80.0, color: Theme.of(context).primaryColor,),
            SizedBox(height: 16.0,),
            Text("Faca o login para add produtos",
              style: TextStyle(fontSize: 20.0, fontWeight:  FontWeight.bold,),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0,),
            RaisedButton(
              child: Text('Entrar', style: TextStyle(fontSize: 18.0),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen())
                );
              },
            )
          ],
        ),
      );
    }
  }
}

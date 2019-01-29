import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho_model.dart';
import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
          title: Text(
            "Cupom de Desconto",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700]
            ),
          ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom"
              ),
              initialValue: CarrinhoModel.of(context).cupomCode ?? "",
              onFieldSubmitted: (text){
                Firestore.instance.collection("cupons").document(text).get().then((res){
                  if(res.data != null){
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text("Desconto de ${res.data["percent"]} %aplicada"),
                      backgroundColor: Theme.of(context).primaryColor,)
                    );
                    CarrinhoModel.of(context).setDesconto(text, res.data["percent"]);
                  }else {
                    CarrinhoModel.of(context).setDesconto(null, 0);
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupom inexistente"),
                          backgroundColor: Colors.redAccent,)
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

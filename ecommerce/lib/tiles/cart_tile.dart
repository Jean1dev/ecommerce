import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/Carrinho.dart';
import 'package:ecommerce/model/Carrinho_model.dart';
import 'package:ecommerce/model/Produto.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {

  final Carrinho _carrinhoModel;

  CartTile(this._carrinhoModel);

  @override
  Widget build(BuildContext context) {


    Widget _buildContent(){
      CarrinhoModel.of(context).updatePrices();

      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            child: Image.network(_carrinhoModel.data.images[0], fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _carrinhoModel.data.title,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17.0),
                  ),
                  Text(
                    "Tamanho: ${_carrinhoModel.size}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${_carrinhoModel.data.price.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: _carrinhoModel.qtd > 1 ? () {
                          CarrinhoModel.of(context).decProduto(_carrinhoModel);
                        } : null,
                      ),
                      Text(_carrinhoModel.qtd.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Theme.of(context).primaryColor,
                        onPressed: (){
                          CarrinhoModel.of(context).incProduto(_carrinhoModel);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey,
                          color: Theme.of(context).primaryColor,
                        onPressed: () {
                          CarrinhoModel.of(context).removeItem(_carrinhoModel);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );

    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: _carrinhoModel.data == null ?
          FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance.collection("produtos").document(_carrinhoModel.categoria)
            .collection("itens").document(_carrinhoModel.produto_id).get(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                _carrinhoModel.data = Produto.fromDocument(snapshot.data);
              } else {
                return Container(
                  height: 70.0,
                  child: CircularProgressIndicator(),
                  alignment: Alignment.center,
                );
              }
            },
          ):
          _buildContent()
    );
  }
}

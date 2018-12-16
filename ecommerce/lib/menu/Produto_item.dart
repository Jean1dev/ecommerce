import 'package:ecommerce/janelas/Produto_datelhe_screen.dart';
import 'package:ecommerce/model/Produto.dart';
import 'package:flutter/material.dart';

class ProdutoItem extends StatelessWidget {
  final String type;
  final Produto data;

  ProdutoItem(this.type, this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProdutoDetalheScreen(data)));
      },
      child: Card(
        child: type == "grid"
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 0.8,
                    child: Image.network(
                      data.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            data.title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            'R\$ ${data.price.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            : Row(
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      data.images[0],
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                  ),
                  Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.title,
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'R\$ ${data.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
      ),
    );
  }
}

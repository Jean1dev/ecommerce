import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerce/janelas/Carrinho_screen.dart';
import 'package:ecommerce/janelas/Login_screen.dart';
import 'package:ecommerce/model/Carrinho.dart';
import 'package:ecommerce/model/Carrinho_model.dart';
import 'package:ecommerce/model/Produto.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:flutter/material.dart';

class ProdutoDetalheScreen extends StatefulWidget {
  final Produto produto;

  ProdutoDetalheScreen(this.produto);

  @override
  _ProdutoDetalheScreenState createState() =>
      _ProdutoDetalheScreenState(produto);
}

class _ProdutoDetalheScreenState extends State<ProdutoDetalheScreen> {
  final Produto produto;
  String size;

  _ProdutoDetalheScreenState(this.produto);

  @override
  Widget build(BuildContext context) {
    final Color primary = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: Text(produto.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: produto.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primary,
              autoplay: false, // para mudar as imagens automaticamente
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  produto.title,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${produto.price.toStringAsPrecision(2)}',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primary),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.5,
                    ),
                    children: produto.size.map((res) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            this.size = res;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: res == this.size
                                      ? primary
                                      : Colors.grey[500],
                                  width: 3.0)),
                          width: 50.0,
                          alignment: Alignment.center,
                          child: Text(res),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: this.size != null ? (){
                      if(UserModel.of(context).isLoggedIn()){

                        Carrinho item = Carrinho();
                        item.size = size;
                        item.qtd = 1;
                        item.produto_id = produto.id;
                        item.categoria = produto.categoria;

                        CarrinhoModel.of(context).addItem(item);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => CarrinhoScreen())
                        );

                      }else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                    child: Text(
                      UserModel.of(context).isLoggedIn() ? "Adicionar ao carrinho" : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    color: primary,
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16.0,),
                Text(
                  "Descricao",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  produto.desc,
                  style: TextStyle(
                    fontSize: 16.0
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

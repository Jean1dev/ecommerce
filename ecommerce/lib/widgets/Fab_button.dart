import 'package:ecommerce/janelas/Carrinho_screen.dart';
import 'package:flutter/material.dart';

class FabButton extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => CarrinhoScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

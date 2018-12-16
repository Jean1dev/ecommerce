import 'package:ecommerce/tabs/Product_tab.dart';
import 'package:ecommerce/tabs/home_tab.dart';
import 'package:ecommerce/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final _pageController = new PageController();

    // TODO: implement build
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProdutoTab(),
        )
      ],
    );
  }
}
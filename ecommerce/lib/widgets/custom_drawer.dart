import 'package:ecommerce/janelas/Login_screen.dart';
import 'package:ecommerce/menu/Drawer_menu.dart';
import 'package:ecommerce/model/User_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {


  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {


    Widget _buildBodyBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildBodyBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 16.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 8.0),
                height: 170.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8.0,
                      left: 0.0,
                      child: Text("Ecommerce",style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Ola, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoggedIn() ?
                                    "Entre ou Cadastra-se"
                                    : "Sair",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onTap: (){
                                    // AO CLICAR EXECUTA AQUI
                                    if(!model.isLoggedIn()){
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => LoginScreen())
                                      );
                                    }else {
                                      model.signOut();
                                    }

                                  },
                                )
                              ],
                            );
                          },
                      )
                    )
                  ],
                ),
              ),
              Divider(),
              ItemMenu(Icons.home, "Inicio", pageController, 0),
              ItemMenu(Icons.list, "Produtos", pageController, 1),
              ItemMenu(Icons.location_on, "Lojas", pageController, 2),
              ItemMenu(Icons.playlist_add_check, "Meus pedidos", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}

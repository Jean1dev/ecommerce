import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cria Conta"),
        centerTitle: true,
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(hintText: "Nome"),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty) return "Nome Invalido";
              },
            ),

            SizedBox(
              height: 16.0,
            ),

            TextFormField(
              decoration: InputDecoration(hintText: "Email"),
              keyboardType: TextInputType.emailAddress,
              validator: (text){
                if(text.isEmpty || !text.contains("@")) return "Email Invalido";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text){
                if(text.isEmpty) return "senha invalida";
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18.0),
              ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                if(this._formkey.currentState.validate()){

                }
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {

  final DocumentSnapshot snapshot;
  PlaceTile(this.snapshot);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100.0,
            child: Image.network(
              snapshot.data["img"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["title"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0
                  ),
                ),
                Text(
                  snapshot.data["address"],
                  textAlign: TextAlign.start,
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Ver no mapa"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("https://www.google.com.br/maps/place/RegSul+modas/@-28.708169,-49.3027007,17z/data=!3m1!4b1!4m5!3m4!1s0x95217eb949bae013:0x1e30734f6948d453!8m2!3d-28.708169!4d-49.300512");
                },
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue,
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("tel:${snapshot.data["phone"]}");
                },
              )
            ],
          )
        ],
      ),
    );
  }
}

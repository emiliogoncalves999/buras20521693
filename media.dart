import 'package:flutter/material.dart';

class Media extends StatelessWidget{
@override 
Widget build(BuildContext context){
  return Container(
   child : new Center(
     child : new Column(children: [
      
      new Padding(padding: new EdgeInsets.all(20.0),),
      new Text("Media", style: new TextStyle(fontSize: 30.0),),
      new Padding(padding: new EdgeInsets.all(20.0)),
     // new Icon(Icons.perm_device_information,size : 90.0),
      //new Image(image: new NetworkImage("https://upload.wikimedia.org/wikipedia/commons/1/10/Xanana_2011.jpg"),)
     ],)
   )
  );
}

}
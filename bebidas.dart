import 'package:flutter/material.dart';

class Bebidas extends StatelessWidget{
@override 
Widget build(BuildContext context){
  return Container(
   child : new Center( 
     child : new Column(children: [
      
      new Padding(padding: new EdgeInsets.all(20.0),),
      new Text("Arquivu", style: new TextStyle(fontSize: 30.0),),
      new Padding(padding: new EdgeInsets.all(20.0)),
      new Icon(Icons.save,size : 90.0)

     ],)
   )
  );
}

}
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Arquivu extends StatefulWidget {
  @override
  _ArquivuState createState() => _ArquivuState();
}

class _ArquivuState extends State<Arquivu> {
  String naran = "";
  String id = "";
  String imagen = "";

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id")!;
      naran = preferences.getString("naran")!;
      imagen = preferences.getString("imagen")!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: new Center(
            child: new Column(
      children: [
        new Padding(
          padding: new EdgeInsets.all(20.0),
        ),
        new Image.network(imagen),
        new Text(
          naran,
          style: new TextStyle(fontSize: 30.0),
        ),
        new Padding(padding: new EdgeInsets.all(20.0)),

        // getPref(),
      ],
    )));
  }
}

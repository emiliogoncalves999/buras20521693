import 'package:flutter/material.dart';

///import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;

class VerificationException {
  final String message;
  //   _scaffoldState.currentState.showSnackBar(new SnackBar(
  // content: new Text("${latitude},${longitude}", style : new TextStyle(fontSize: 12.0 ),),
  // duration: new Duration(seconds:3),
  // ));
  VerificationException(this.message);

  @override
  String toString() => message;
}

class Prosesuorder extends StatefulWidget {
  Prosesuorder(
      {required this.id_hahan,
      required this.total,
      required this.pressu,
      required this.lat,
      required this.lon});
  String id_hahan, total, pressu, lat, lon;

  @override
  _ProsesuorderState createState() => _ProsesuorderState();
}

class _ProsesuorderState extends State<Prosesuorder> {
  bool ordersusesu = false;
  bool hahanreadi = false;
  bool errornetwork = true;
  var client = http.Client();

  Future<List<dynamic>> senddata() async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.43.118/crocodeli/api/raiorderAPI2.php"),
        body: {
          "ulat": widget.lat,
          "ulon": widget.lon,
          "id_hahan": widget.id_hahan,
          "total": widget.total,
          "pressu": widget.pressu,
        },
      );

      if (response.statusCode == 200) {
        var koko = [];
        koko.add(jsonDecode(response.body));
        if (koko[0]['success'] == "ordersusesumpg") {
          setState(() {
            ordersusesu = true;
            errornetwork = true;
          });
        }
      } else {
        errornetwork = false;
      }
    } on SocketException {
      throw VerificationException('No Internet connection');
    } on HttpException {
      throw VerificationException("Service is unavailable");
    }

    return []; // Add a return statement at the end of the function
  }

  @override
  void initState() {
    senddata();
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldState,
        backgroundColor: Colors.yellow[800],
        body: Container(
            child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                child: errornetwork
                    ? new Column(children: [
//cek order susesu ka lae
                        Container(
                          child: ordersusesu
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: new Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: new Text(
                                                      "Order Susesu ",
                                                      style: new TextStyle(
                                                          fontSize: 19.0,
                                                          color: Colors
                                                              .green[800]),
                                                    ),
                                                  ),
                                                  new Icon(
                                                    Icons.check,
                                                    color: Colors.green[800],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: new Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: new Text(
                                                      "Order Susesu ",
                                                      style: new TextStyle(
                                                          fontSize: 19.0,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    child:
                                                        CircularProgressIndicator(),
                                                    height: 25.0,
                                                    width: 25.0,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),

//restorante konfirma

                        Container(
                          child: hahanreadi
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: new Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: new Text(
                                                      "Hahan Ready ",
                                                      style: new TextStyle(
                                                          fontSize: 19.0,
                                                          color: Colors
                                                              .green[800]),
                                                    ),
                                                  ),
                                                  new Icon(
                                                    Icons.check,
                                                    color: Colors.green[800],
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new Expanded(
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Card(
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: new Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: new Text(
                                                      "Hahan Ready ",
                                                      style: new TextStyle(
                                                          fontSize: 19.0,
                                                          color:
                                                              Colors.black45),
                                                    ),
                                                  ),
                                                  new SizedBox(
                                                    child:
                                                        LinearProgressIndicator(),
                                                    height: 25.0,
                                                    width: 25.0,
                                                  ),
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      ])
                    : new Text("Jarigan Errror")),
          ]),
        )));
  }
}

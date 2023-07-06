import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlong;

import 'package:umadijital_buras/main.dart';
import 'package:umadijital_buras/mpgdeliverry.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'dart:convert';

import 'package:http/http.dart' as http;

class MapSample extends StatefulWidget {
  MapSample({this.xxx});
  var xxx;

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  latlong.LatLng? tappedCoordinates;

  String sendmsg = "";
  late Timer timer;

  String id_orderx = "";

  String id = "";
  String total = "";
  String presu = "";
  bool ordersusesu = false;
  bool ordersusesuprossesu = false;
  bool konfirmahahan = false;

  double totalosan = 0;

  String narank = "";
  String idk = "";
  String imagenk = "";

  @override
  void initState() {
    totalosan = 0;
    for (var i = 0; i < widget.xxx.length; i++) {
      id = "${id}${widget.xxx[i]['id']},";
      total = "${total}${widget.xxx[i]['totalorder']},";
      presu = "${presu}${widget.xxx[i]['presu']},";

      double sura = 0;
      sura = double.parse(widget.xxx[i]['totalorder']) *
          double.parse(widget.xxx[i]['presu']);
      totalosan = totalosan + sura;
    }
    super.initState();
  }

  void ordersusesuona(String data) {
    setState(() {
      ordersusesu = false;
      ordersusesuprossesu = false;
      konfirmahahan = false;
    });

    String text = "";
    IconData icond;

    if (data == "0") {
      text = "Order kanseladu husi restorante favor order fali hahan seluk";
      icond = Icons.block;
    } else if (data == "1") {
      text =
          "Order Susesu driver crocodeli sei lori hahan ba iha ita bo'ot nia fatin";
      icond = Icons.check_circle;
    }
    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 200.0,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Icon(
                  Icons.abc,
                  size: 70.0,
                  color: Colors.green,
                ),
                Padding(padding: EdgeInsets.all(10.0)),
                Center(
                    child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                )),
                ElevatedButton.icon(
                  onPressed: () async {
                    Navigator.pop(context);

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => Uma()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    primary: Colors.yellow[800],
                    splashFactory: InkRipple.splashFactory,
                    elevation: 0.0,
                  ),
                  icon: Icon(Icons.check),
                  label: Text("OK"),
                ),
              ],
            ))
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  cekorder() async {
    FormData formDatax = new FormData.fromMap({
      "id_order": id_orderx,
    });

    try {
      final responsex = await Dio().post(
          "https://mpgtl.com/crocodeli/api/cekorderAPI.php",
          data: formDatax);
      if (responsex.statusCode == 200) {
        var kokox = [];

        kokox.add(jsonDecode(responsex.data));

        if (kokox[0]['kofirma_food'] == "1") {
          setState(() {
            timer.cancel();
          });

          ordersusesuona('1');
        } else if (kokox[0]['kofirma_food'] == "2") {
          setState(() {
            timer.cancel();
          });
          ordersusesuona('0');
        }
      }
    } on DioError catch (e) {
      setState(() {
        timer.cancel();
        konfirmahahan = false;
      });
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();
  static double clat = -8.5815691;
  static double clon = 125.5815691;
  String id_order = "";

  Future<List<dynamic>> senddata() async {
    String ulat = clat.toString();
    String ulon = clon.toString();

    setState(() {
      ordersusesuprossesu = true;
      id_orderx = DateFormat('yyyyMMddkkmmss').format(DateTime.now());
    });
    FormData formData = new FormData.fromMap({
      "ulat": ulat,
      "ulon": ulon,
      "id_kliente": idk,
      "id_hahan": id,
      "total": total,
      "pressu": presu,
      "id_order": id_orderx,
    });

    try {
      final response = await Dio().post(
        "https://mpgtl.com/crocodeli/api/raiorderAPI.php",
        data: formData,
      );

      if (response.statusCode == 200) {
        var koko = [];
        koko.add(jsonDecode(response.data));
        if (koko[0]['success'] == "ordersusesumpg") {
          setState(() {
            konfirmahahan = true;
            timer =
                Timer.periodic(Duration(seconds: 6), (Timer t) => cekorder());
            ordersusesuprossesu = false;
            ordersusesu = true;
          });
        } else {
          setState(() {
            ordersusesuprossesu = false;
            ordersusesu = false;
          });
        }
      } else {
        setState(() {
          ordersusesu = false;
          ordersusesuprossesu = false;
        });
      }
    } on DioError catch (e) {
      setState(() {
        ordersusesuprossesu = false;
        ordersusesu = false;
        ScaffoldMessenger.of(context)?.showSnackBar(
          SnackBar(
            content: Text(
              "Internet Error",
              style: TextStyle(fontSize: 12.0),
            ),
            duration: Duration(seconds: 3),
          ),
        );
      });
    }

    return []; // Add this return statement
  }

  void koko(double lat, double lon) {
    setState(() {
      clat = lat;
      clon = lon;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Hili Localizasaun"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: latlong.LatLng(-8.556856, 125.567308),
                zoom: 14.0,
                onTap: (latlong.LatLng tapPosition) {
                  setState(() {
                    tappedCoordinates = tapPosition;
                  });

                  var latitude = tappedCoordinates!.latitude;
                  var longitude = tappedCoordinates!.longitude;

                  koko(latitude, longitude);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "$latitude, $longitude",
                        style: TextStyle(fontSize: 12.0),
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  tileProvider: NonCachingNetworkTileProvider(),
                ),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                      width: 100.0,
                      height: 100.0,
                      point: latlong.LatLng(clat, clon),
                      builder: (ctx) => Container(
                        child: new Icon(Icons.circle, color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
              child: ordersusesu
                  ? Row(
                      children: [
                        Expanded(
                            child: konfirmahahan
                                ? Container(
                                    color: Colors.orange,
                                    padding: EdgeInsets.all(40.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: CircularProgressIndicator(),
                                          height: 20.0,
                                          width: 20.0,
                                        ),
                                        Padding(padding: EdgeInsets.all(5.0)),
                                        Text("Konfirma Hahan iha Resto"),
                                      ],
                                    ),
                                  )
                                : Container(
                                    color: Colors.yellow[800],
                                    padding: EdgeInsets.all(40.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(padding: EdgeInsets.all(5.0)),
                                        Ink(
                                          decoration: ShapeDecoration(
                                            color: Colors.red[800],
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(0.0)),
                                            ),
                                          ),
                                          child: ElevatedButton.icon(
                                            onPressed: () async {
                                              setState(() {
                                                konfirmahahan = true;
                                                timer = Timer.periodic(
                                                    Duration(seconds: 6),
                                                    (Timer t) => cekorder());
                                              });
                                            },
                                            icon: Icon(Icons.error),
                                            label: Text("Konfirma fali"),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(10.0),
                                              onPrimary: Colors.white,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )),
                      ],
                    )
                  : Row(children: [
                      Expanded(
                        child: ordersusesuprossesu
                            ? Container(
                                padding: EdgeInsets.all(10.0),
                                color: Colors.orange,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Order Hahan  ",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(
                                      child: CircularProgressIndicator(),
                                      height: 20.0,
                                      width: 20.0,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child:

                                    // RaisedButton.icon(
                                    //   padding: EdgeInsets.all(10.0),
                                    //   onPressed: () async {
                                    //     setState(() {
                                    //       ordersusesu = false;
                                    //       // ordersusesuprossesu = true;
                                    //       senddata();
                                    //     });
                                    //   },
                                    //   shape: RoundedRectangleBorder(
                                    //       borderRadius: BorderRadius.all(
                                    //           Radius.circular(0.0))),
                                    //   label: Text(
                                    //     "Order Agora",
                                    //   ),
                                    //   icon: new Icon(Icons.send),
                                    //   textColor: Colors.white,
                                    //   splashColor: Colors.red,
                                    //   color: Colors.yellow[800],
                                    // ),
                                    ElevatedButton.icon(
                                  onPressed: () async {
                                    setState(() {
                                      ordersusesu = false;
                                      // ordersusesuprossesu = true;
                                      senddata();
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(15.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0.0)),
                                    ),
                                    primary: Colors.green,
                                    onPrimary: Colors.white,
                                    splashFactory: InkSplash.splashFactory,
                                  ),
                                  label: Text("Order Agora"),
                                  icon: Icon(Icons.send),
                                ),
                              ),
                      )
                    ])),
        ],
      ),
    );
  }
}

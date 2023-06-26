import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import './hahan.dart' as hahan;
import './bebidas.dart' as bebidas;
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:convert';
import './listaorder.dart';
import 'package:http/http.dart' as http;
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/scheduler.dart';
import 'package:nested_scroll_controller/nested_scroll_controller.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with SingleTickerProviderStateMixin {
  int total = 0;
  double totalosan = 0;
  bool koneksaunfallah = true;

  bool koneksaunfallab = true;
  List dadoshahan = [];
  TextEditingController controllertotalorder = new TextEditingController();
  late TabController tabmenu;

  String _selectedIndex = "";

  _onSelected(String index) {
    setState(() => _selectedIndex = index);
  }

  Future<List<dynamic>> getDatah() async {
    var dio = Dio();

    try {
      setState(() {
        koneksaunfallah = true;
      });

      final response = await dio.get(
          "https://mpgtl.com/crocodeli/api/orderatualAPI.php?id_kliente=" +
              idk);
      return jsonDecode(response.data);
    } on DioError catch (e) {
      setState(() {
        koneksaunfallah = false;
      });
      return []; // Return an empty list in case of an error
    }
  }

  Future<List<dynamic>> lastorder() async {
    var dio = Dio();

    try {
      setState(() {
        koneksaunfallab = true;
      });

      final response = await dio.get(
          "https://mpgtl.com/crocodeli/api/lastorderAPI.php?id_kliente=" + idk);
      return jsonDecode(response.data);
    } on DioError catch (e) {
      setState(() {
        koneksaunfallab = false;
      });
      return []; // Return an empty list in case of an error
    }
  }

  var karakter = [];
  var send = [];

  aumentaRaga(String id, String naran, String presu, String totalorder) {
    setState(() {
      // karakter.addAll([{"id": id, "naran": naran,"presu": presu, "totalorder": totalorder}]);

      int iha = 0;
      for (var i = 0; i < karakter.length; i++) {
        if (karakter[i]['id'] == id) {
          karakter[i]['totalorder'] = totalorder;
          iha = 1;
        }
      }

      if (iha == 0) {
        karakter.addAll([
          {"id": id, "naran": naran, "presu": presu, "totalorder": totalorder}
        ]);
      }

      totalosan = 0;
      for (var i = 0; i < karakter.length; i++) {
        double sura = 0;
        sura = double.parse(karakter[i]['totalorder']) *
            double.parse(karakter[i]['presu']);
        totalosan = totalosan + sura;
      }

      total = karakter.length;
      controllertotalorder.clear();
    });
  }

  back() async {
    setState(() {
      karakter.clear();
      totalosan = 0;
    });
  }

  String narank = "";
  String idk = "";
  String imagenk = "";

  // getPref() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     idk = preferences.getString("id");
  //     narank = preferences.getString("naran");
  //     imagenk = preferences.getString("imagen");
  //   });
  // }

  @override
  void initState() {
    tabmenu = new TabController(length: 2, vsync: this);
    // getPref();
    super.initState();
  }

  @override
  void dispose() {
    tabmenu.dispose();
    super.dispose();
  }

  apagaorder(int i) {
    setState(() {
      karakter.removeAt(i);
      karakter = karakter;
      totalosan = 0;
      for (var i = 0; i < karakter.length; i++) {
        double sura = 0;
        sura = double.parse(karakter[i]['totalorder']) *
            double.parse(karakter[i]['presu']);
        totalosan = totalosan + sura;
      }
    });
  }

  void kirimdata(String id, String naran, String presu) {
    controllertotalorder.text = "";
    for (var i = 0; i < karakter.length; i++) {
      if (karakter[i]['id'] == id) {
        controllertotalorder.text = karakter[i]['totalorder'];
      }
    }

    AlertDialog alertDialog = new AlertDialog(
      content: new Container(
        height: 200.0,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              children: [
                new Text("${naran} Presu : ${presu}",
                    style:
                        TextStyle(fontSize: 12.0, fontStyle: FontStyle.normal)),
                new Padding(padding: new EdgeInsets.all(10.0)),
                new TextField(
                    controller: controllertotalorder,
                    decoration: new InputDecoration(
                        hintText: "Prence Total",
                        labelText: "Total Order",
                        border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(20.0)))),
                new Padding(padding: new EdgeInsets.all(10.0)),
                ElevatedButton.icon(
                  onPressed: () {
                    aumentaRaga(id, naran, presu, controllertotalorder.text);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    primary: Colors.blue[800],
                    onPrimary: Colors.white,
                  ),
                  icon: Icon(Icons.card_giftcard),
                  label: Text(
                    'Aumenta Ba raga',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  void detalluorder() {
    double totalosan = 0;
    totalosan = 0;
    for (var i = 0; i < karakter.length; i++) {
      double sura = 0;
      sura = double.parse(karakter[i]['totalorder']) *
          double.parse(karakter[i]['presu']);
      totalosan = totalosan + sura;
    }

    AlertDialog alertDialog = new AlertDialog(
      title: new Text("Aihan Iha Raga "),
      insetPadding: EdgeInsets.all(3.0),
      content: new Container(
          //    width: MediaQuery.of(context).size.width - 10,
          // height: MediaQuery.of(context).size.height -  80,

          width: double.maxFinite,
          child: new Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: karakter == null ? 0 : karakter.length,
                itemBuilder: (ctx, i) {
                  double sura = 0;
                  sura = double.parse(karakter[i]['totalorder']) *
                      double.parse(karakter[i]['presu']);

                  return Container(
                    child: new Column(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            child: new Container(
                              padding: new EdgeInsets.all(20.0),
                              child: new Row(children: [
                                new Expanded(
                                  child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        new Text(
                                          "${karakter[i]['naran']}",
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.red),
                                        ),
                                        new Text(
                                          "Presu : ${karakter[i]['presu']} \$",
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black),
                                        )
                                      ]),
                                ),
                                Row(children: [
                                  Column(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          // setState(() {
                                          //   // total++;
                                          // });
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(8.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          primary: Colors.white,
                                          onPrimary: Colors.blue[800],
                                        ),
                                        label: Text(
                                          "${karakter[i]['totalorder']} -  \$ ${sura}",
                                          style: TextStyle(
                                              color: Colors.blue[800]),
                                        ),
                                        icon: Text("Total : ",
                                            style: TextStyle(
                                                color: Colors.blue[800])),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          apagaorder(i);
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.all(8.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                          ),
                                          primary: Colors.white,
                                          onPrimary: Colors.red,
                                        ),
                                        label: Text("Apaga",
                                            style:
                                                TextStyle(color: Colors.red)),
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                ])
                              ]),
                            ),
                          ),

                          // new Text("${list[i]['name']}", style: TextStyle(fontSize : 20.0,),),
                          //        new Text(" presu :  ${list[i]['mobile']} ${r"$"}", style: TextStyle(fontSize : 20.0,),),
                        ],
                      ),
                      new Padding(padding: EdgeInsets.only(top: 10.0))
                    ]),
                  );
                },
              ),
            ),
            Card(
              child: new Container(
                padding: new EdgeInsets.all(20.0),
                child: new Row(children: [
                  new Expanded(
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            "Total Osan",
                            style: new TextStyle(
                                fontSize: 16.0, color: Colors.red),
                          ),
                          new Text(
                            "${totalosan}\$",
                            style: new TextStyle(
                                fontSize: 30.0, color: Colors.black),
                          )
                        ]),
                  ),
                  new Row(children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        setState(() {
                          send = [];
                        });

                        for (var i = 0; i < karakter.length; i++) {
                          send.addAll([
                            {
                              "id": karakter[i]['id'],
                              "naran": karakter[i]['naran'],
                              "presu": karakter[i]['presu'],
                              "totalorder": karakter[i]['totalorder']
                            }
                          ]);

                          //sura =  double.parse(karakter[i]['totalorder']) * double.parse(karakter[i]['presu']);
                        }

                        setState(() {
                          back();
                        });
                        Navigator.pop(context);

                        // Navigator.of(context).push(new MaterialPageRoute(
                        //   builder: (BuildContext context) => new MapSample(
                        //     xxx: send,
                        //   ),
                        // ));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.blue[800],
                      ),
                      label: Icon(Icons.forward),
                      icon: Text("Kontinua Ba Order"),
                    )
                  ])
                ]),
              ),
            ),
          ])),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return alertDialog;
      },
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldState =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldState,
      appBar: PreferredSize(
        preferredSize: ui.Size.fromHeight(40),
        child: Material(
          color: Colors.black12,
          child: new TabBar(
            indicatorColor: Colors.black54,
            controller: tabmenu,
            tabs: [
              new Tab(
                  icon: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    new Icon(
                      Icons.timelapse_rounded,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                    new Text(
                      "Order Atual",
                      style: TextStyle(color: Colors.black38),
                    )
                  ])),
              new Tab(
                  icon: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    new Icon(
                      Icons.save,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                    new Text(
                      "Arquivu",
                      style: TextStyle(color: Colors.black38),
                    )
                  ])),

              //  new Tab(icon: new Icon(Icons.save),),
              // new Tab(icon: new Icon(Icons.people),),
            ],
          ),
        ),
      ),
      body: new TabBarView(controller: tabmenu, children: [
//foods

        Container(
            child: koneksaunfallah
                ? FutureBuilder<List>(
                    future: getDatah(),
                    builder: (ctx, ss) {
                      if (ss.hasError) {
                        print("error");
                      }
                      if (ss.hasData) {
                        return Container(
                            child: ss.data!.length > 0
                                ? ListView.builder(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                                    shrinkWrap: true,
                                    itemCount:
                                        ss.data == null ? 0 : ss.data!.length,
                                    itemBuilder: (ctx, i) {
                                      return Container(
                                        child: new Column(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Card(
                                                child: new Container(
                                                  padding:
                                                      new EdgeInsets.all(5.0),
                                                  child: new Row(children: [
                                                    new Expanded(
                                                      child: new Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            new Text(
                                                              "${ss.data![i]['datahoras']}",
                                                              style: new TextStyle(
                                                                  fontSize:
                                                                      14.0,
                                                                  color: Colors
                                                                      .red),
                                                            ),
                                                            new Text(
                                                              "${ss.data![i]['datahoras']}",
                                                              style: new TextStyle(
                                                                  fontSize:
                                                                      12.0,
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ]),
                                                    ),
                                                    new Row(children: [
                                                      ElevatedButton.icon(
                                                        onPressed: () async {
                                                          Navigator.of(context)
                                                              .push(
                                                            MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  pajina2(
                                                                id: "${ss.data![i]['id_order']}",
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        icon: Icon(Icons.add),
                                                        label: Text("Detallu"),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  10.0),
                                                            ),
                                                          ),
                                                          onPrimary:
                                                              Colors.blue[800],
                                                          splashFactory:
                                                              InkSplash
                                                                  .splashFactory,
                                                        ),
                                                      ),
                                                    ])
                                                  ]),
                                                ),
                                              ),

                                              // new Image.asset(
                                              //         "img/fb.png",
                                              //        height: 190,
                                              // width: MediaQuery.of(context).size.width,
                                              // fit:BoxFit.cover,

                                              //       ),

                                              // new Text("${list[i]['name']}", style: TextStyle(fontSize : 20.0,),),
                                              //        new Text(" presu :  ${list[i]['mobile']} ${r"$"}", style: TextStyle(fontSize : 20.0,),),
                                            ],
                                          ),
                                          new Padding(
                                              padding:
                                                  EdgeInsets.only(top: 10.0))
                                        ]),
                                      );
                                    },
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Dados Order Laiha(0)"),
                                      Padding(padding: EdgeInsets.all(10.0)),
                                      ElevatedButton.icon(
                                        onPressed: () async {},
                                        icon: Icon(Icons.view_agenda),
                                        label: Text("Hare Menu Hahan"),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                          onPrimary: Colors.blue[800],
                                          splashFactory:
                                              InkSplash.splashFactory,
                                        ),
                                      ),
                                    ],
                                  ));
                      } else {
                        return Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            height: 25.0,
                            width: 25.0,
                          ),
                        );
                        //CircularProgressIndicator();
                      }
                    },
                  )
                : Container(
                    child: new Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        Image.asset(
                          "img/falha.gif",
                          width: 100.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              getDatah();
                            });
                          },
                          icon: Icon(Icons.error),
                          label: Text("Koko Fali"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            onPrimary: Colors.black45,
                            splashFactory: InkSplash.splashFactory,
                          ),
                        ),
                      ])))),

        Container(
            child: koneksaunfallab
                ? FutureBuilder<List>(
                    future: lastorder(),
                    builder: (ctx, ss) {
                      if (ss.hasError) {
                        print("error");
                      }
                      if (ss.hasData) {
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          shrinkWrap: true,
                          itemCount: ss.data == null ? 0 : ss.data!.length,
                          itemBuilder: (ctx, i) {
                            return Container(
                              child: new Column(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      child: new Container(
                                        padding: new EdgeInsets.all(5.0),
                                        child: new Row(children: [
                                          new Expanded(
                                            child: new Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  new Text(
                                                    "${ss.data![i]['datahoras']}",
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.red),
                                                  ),
                                                  Container(
                                                      child: ss.data![i][
                                                                  'kofirma_food'] ==
                                                              "1"
                                                          ? Text("Order Susesu")
                                                          : Text(
                                                              "Order Kanseladu",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            ))
                                                ]),
                                          ),
                                          new Row(children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        pajina2(
                                                      id: "${ss.data![i]['id_order']}",
                                                    ),
                                                  ),
                                                );
                                              },
                                              icon: Icon(Icons.add),
                                              label: Text("Detallu"),
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                onPrimary: Colors.blue[800],
                                                splashFactory:
                                                    InkSplash.splashFactory,
                                              ),
                                            ),
                                          ])
                                        ]),
                                      ),
                                    ),

                                    // new Image.asset(
                                    //         "img/fb.png",
                                    //        height: 190,
                                    // width: MediaQuery.of(context).size.width,
                                    // fit:BoxFit.cover,

                                    //       ),

                                    // new Text("${list[i]['name']}", style: TextStyle(fontSize : 20.0,),),
                                    //        new Text(" presu :  ${list[i]['mobile']} ${r"$"}", style: TextStyle(fontSize : 20.0,),),
                                  ],
                                ),
                                new Padding(padding: EdgeInsets.only(top: 10.0))
                              ]),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: SizedBox(
                            child: CircularProgressIndicator(),
                            height: 25.0,
                            width: 25.0,
                          ),
                        );
                        //CircularProgressIndicator();
                      }
                    },
                  )
                : Container(
                    child: new Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                        Image.asset(
                          "img/falha.gif",
                          width: 100.0,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              getDatah();
                            });
                          },
                          icon: Icon(Icons.error),
                          label: Text("Koko Fali"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            onPrimary: Colors.black45,
                            splashFactory: InkSplash.splashFactory,
                          ),
                        ),
                      ])))),

//foods
        // FutureBuilder<List>(
        //   future: getDatab(),
        //   builder: (ctx, ss) {
        //     if (ss.hasError) {
        //       print("error");
        //     }
        //     if (ss.hasData) {
        //       return ListView.builder(
        //         padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
        //         shrinkWrap: true,
        //         itemCount: ss.data == null ? 0 : ss.data.length,
        //         itemBuilder: (ctx, i) {
        //           return Container(
        //             child: new Column(children: [
        //               Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   new Hero(
        //                     tag: "${ss.data[i]['imagen']}",
        //                     child: new InkWell(
        //                       onTap: () => Navigator.of(context)
        //                           .push(new MaterialPageRoute(
        //                         builder: (BuildContext context) => new pajina2(
        //                           gambar: "${ss.data[i]['imagen']}",
        //                         ),
        //                       )),
        //                       child: new ClipRRect(
        //                         child: new Image.network(
        //                           "http://192.168.43.118/crocodeli/img/${ss.data[i]['imagen']}",
        //                           height: 190,
        //                           width: double.infinity,
        //                           //  width: MediaQuery.of(context).size.width,
        //                           fit: BoxFit.cover,
        //                         ),
        //                       ),
        //                     ),
        //                   ),

        //                   Card(
        //                     child: new Container(
        //                       padding: new EdgeInsets.all(5.0),
        //                       child: new Row(children: [
        //                         new Expanded(
        //                           child: new Column(
        //                               crossAxisAlignment:
        //                                   CrossAxisAlignment.start,
        //                               children: [
        //                                 new Text(
        //                                   "${ss.data[i]['naran_hahan']}",
        //                                   style: new TextStyle(
        //                                       fontSize: 14.0,
        //                                       color: Colors.red),
        //                                 ),
        //                                 new Text(
        //                                   "Presu : ${ss.data[i]['presu']} \$",
        //                                   style: new TextStyle(
        //                                       fontSize: 20.0,
        //                                       color: Colors.black),
        //                                 )
        //                               ]),
        //                         ),
        //                         new Row(children: [
        //                           RaisedButton.icon(
        //                             padding: EdgeInsets.all(8.0),
        //                             icon: Icon(Icons.add),
        //                             label: Text("Aumenta Ba raga"),
        //                             color: Colors.white,
        //                             onPressed: () async {
        //                               // setState(() {
        //                               //   total++;
        //                               // });
        //                               //  var onePointOne = double.parse(ss.data[i]['mobile']);

        //                               kirimdata(
        //                                   ss.data[i]['id_hahan'],
        //                                   ss.data[i]['naran_hahan'],
        //                                   ss.data[i]['presu']);
        //                               //  setState(() {
        //                               //   karakter = karakter;
        //                               //   });
        //                             },
        //                             shape: RoundedRectangleBorder(
        //                                 borderRadius: BorderRadius.all(
        //                                     Radius.circular(10.0))),
        //                             textColor: Colors.blue[800],
        //                             splashColor: Colors.red,
        //                           )
        //                         ])
        //                       ]),
        //                     ),
        //                   ),

        //                   // new Image.asset(
        //                   //         "img/fb.png",
        //                   //        height: 190,
        //                   // width: MediaQuery.of(context).size.width,
        //                   // fit:BoxFit.cover,

        //                   //       ),

        //                   // new Text("${list[i]['name']}", style: TextStyle(fontSize : 20.0,),),
        //                   //        new Text(" presu :  ${list[i]['mobile']} ${r"$"}", style: TextStyle(fontSize : 20.0,),),
        //                 ],
        //               ),
        //               new Padding(padding: EdgeInsets.only(top: 10.0))
        //             ]),
        //           );
        //         },
        //       );
        //     } else {
        //       return Center(
        //         child: SizedBox(
        //           child: CircularProgressIndicator(),
        //           height: 25.0,
        //           width: 25.0,
        //         ),
        //       );
        //       //CircularProgressIndicator();
        //     }
        //   },
        // ),
      ]),
    );
  }
}

// class Items extends StatefulWidget {
//   List list;

//   Items({this.list});

//   @override
//   _ItemsState createState() => _ItemsState();
// }

// class _ItemsState extends State<Items> {
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }

//detallu

class pajina2 extends StatefulWidget {
  pajina2({required this.id});
  final String id;

  @override
  _pajina2State createState() => _pajina2State();
}

class _pajina2State extends State<pajina2> {
  Color kor = Colors.grey;
  bool koneksaunfallad = true;
  double totaljeral = 0;

  Future<List<dynamic>> getDetalla(String idor) async {
    var dio = Dio();

    try {
      setState(() {
        koneksaunfallad = true;
      });

      final response = await dio.get(
          "https://mpgtl.com/crocodeli/api/orderdetallaAPI.php?id=${idor}");
      return jsonDecode(response.data);
    } on DioError catch (e) {
      setState(() {
        koneksaunfallad = false;
      });
    }

    // Add a return statement here
    return []; // Or you can return an empty List if necessary
  }

  loadtotal() {
    setState(() {
      totaljeral;
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detallu Order",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // QrImage(
          //   data: "${widget.id}",
          //   version: QrVersions.auto,
          //   size: 150.0,
          // ),
          Expanded(
            child: Container(
                padding: new EdgeInsets.all(20.0),
                child: koneksaunfallad
                    ? FutureBuilder<List>(
                        future: getDetalla(widget.id),
                        builder: (ctx, ss) {
                          if (ss.hasError) {
                            print("error");
                          }
                          if (ss.hasData) {
                            return ListView.builder(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                              shrinkWrap: true,
                              itemCount: ss.data == null ? 0 : ss.data!.length,
                              itemBuilder: (ctx, i) {
                                double sura = 0;
                                sura = double.parse(ss.data![i]['presu']) *
                                    double.parse(ss.data![i]['total']);

                                totaljeral = totaljeral + sura;

                                return Container(
                                  child: new Column(children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Card(
                                          child: new Container(
                                            padding: new EdgeInsets.all(20.0),
                                            child: new Row(children: [
                                              new Expanded(
                                                child: new Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      new Text(
                                                        "${ss.data![i]['naran_hahan']}",
                                                        style: new TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.red),
                                                      ),
                                                      new Text(
                                                        "Presu : \$ ${ss.data![i]['presu']} Total : ${ss.data![i]['total']}   ",
                                                        style: new TextStyle(
                                                            fontSize: 12.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ]),
                                              ),
                                              new Row(children: [
                                                Text(
                                                    "Total Osan  : ${sura} \$   "),
                                              ])
                                            ]),
                                          ),
                                        ),

                                        // new Image.asset(
                                        //         "img/fb.png",
                                        //        height: 190,
                                        // width: MediaQuery.of(context).size.width,
                                        // fit:BoxFit.cover,

                                        //       ),

                                        // new Text("${list[i]['name']}", style: TextStyle(fontSize : 20.0,),),
                                        //        new Text(" presu :  ${list[i]['mobile']} ${r"$"}", style: TextStyle(fontSize : 20.0,),),
                                      ],
                                    ),
                                    new Padding(
                                        padding: EdgeInsets.only(top: 10.0)),
                                    new Center(
                                        child: ss.data!.length == i + 1
                                            ? Container(
                                                child: new Text(
                                                  "Total Osan :   ${totaljeral} ",
                                                  style: new TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.black),
                                                ),
                                              )
                                            : Center())
                                  ]),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: SizedBox(
                                child: CircularProgressIndicator(),
                                height: 25.0,
                                width: 25.0,
                              ),
                            );
                            //CircularProgressIndicator();
                          }
                        },
                      )
                    : Container(
                        child: new Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                            Image.asset(
                              "img/falha.gif",
                              width: 100.0,
                            ),
                            ElevatedButton.icon(
                              icon: Icon(Icons.error),
                              label: Text("Koko Fali"),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                splashFactory: InkRipple.splashFactory,
                                textStyle: TextStyle(color: Colors.black45),
                              ),
                              onPressed: () async {
                                setState(() {
                                  getDetalla("1");
                                });
                              },
                            )
                          ])))),
          ),
        ],
      ),
    );
  }
}

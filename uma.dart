import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import './hahan.dart' as hahan;
import './bebidas.dart' as bebidas;
import 'dart:async';

import 'dart:convert';
import './listaorder.dart';
import 'package:http/http.dart' as http;
//import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/scheduler.dart';
import 'package:nested_scroll_controller/nested_scroll_controller.dart';

class Foods extends StatefulWidget {
  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> with SingleTickerProviderStateMixin {
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

      final response =
          await dio.get("https://mpgtl.com/crocodeli/api/hahanAPI.php");
      //  await dio.get("https://192.168.43.118/crocodeli/api/hahanAPI.php");

      return jsonDecode(response.data);
    } on DioError catch (e) {
      setState(() {
        koneksaunfallah = false;
      });
      return []; // Add this line to return an empty list in case of an error
    }
  }

  Future<List<dynamic>> getDatab() async {
    var dio = Dio();

    try {
      setState(() {
        koneksaunfallab = true;
      });

      final response =
          await dio.get("https://mpgtl.com/crocodeli/api/bebidasAPI.php");
      // await dio.get("https://mpgtl.com/crocodeli/api/bebidasAPI.php");
      return jsonDecode(response.data);
    } on DioError catch (e) {
      setState(() {
        koneksaunfallab = false;
      });
      return []; // Add this line to return an empty list in case of an error
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

  @override
  void initState() {
    tabmenu = new TabController(length: 2, vsync: this);

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
                new Text("${naran} Presu : \$ ${presu} ",
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
                    primary: Colors.white,
                    onPrimary: Colors.blue[800],
                    onSurface: Colors.red,
                  ),
                  label: Text(
                    'Aumenta Ba raga',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  icon: Icon(Icons.card_giftcard),
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
                                new Row(children: [
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
                                          onSurface: Colors.red,
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
                                          onSurface: Colors.red,
                                        ),
                                        label: Text(
                                          "Apaga",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                      ),
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
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        primary: Colors.white,
                        onPrimary: Colors.blue[800],
                        onSurface: Colors.red,
                      ),
                      label: Text("Kontinua Ba Order"),
                      icon: Icon(Icons.forward),
                      // icon: Text("Kontinua Ba Order"), // Uncomment this line if you want to use Text as the icon
                      // style: TextButton.styleFrom( // Uncomment this block if you want to style the Text icon
                      //   primary: Colors.blue[800],
                      //   textStyle: TextStyle(color: Colors.blue[800]),
                      // ),
                      // style: TextButton.styleFrom( // Uncomment this block if you want to style the label text
                      //   primary: Colors.blue[800],
                      //   textStyle: TextStyle(color: Colors.blue[800]),
                      // ),
                      // label: Icon(Icons.forward), // Uncomment this line if you want to use Icon as the label
                      // style: TextButton.styleFrom( // Uncomment this block if you want to style the Icon label
                      //   primary: Colors.blue[800],
                      //   textStyle: TextStyle(color: Colors.blue[800]),
                      // ),
                    ),
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
        preferredSize: Size.fromHeight(40),
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
                      Icons.food_bank_sharp,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                    new Text(
                      "Konsumu",
                      style: TextStyle(color: Colors.black38),
                    )
                  ])),
              new Tab(
                  icon: new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    new Icon(
                      Icons.local_drink,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                    new Text(
                      "Busnis ",
                      style: TextStyle(color: Colors.black38),
                    )
                  ])),

              //  new Tab(icon: new Icon(Icons.save),),
              // new Tab(icon: new Icon(Icons.people),),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 4.0,
        // icon: const Icon(Icons.card_giftcard),
        label: new Text(
          "Raga   (${totalosan} \$) ",
          style: TextStyle(fontSize: 11.0),
        ),
        backgroundColor: Colors.orange,
        onPressed: () {
          if (karakter.length > 0) {
            detalluorder();
          } else {
            ScaffoldMessenger.of(context)?.showSnackBar(
              SnackBar(
                content: Text(
                  "Raga Mamuk(0)",
                  style: TextStyle(fontSize: 12.0),
                ),
                duration: Duration(seconds: 3),
              ),
            );
          }

// Navigator.of(context)
//                                   .push(new MaterialPageRoute(
//                                 builder: (BuildContext context) => new Pajinar(karakter: karakter),
//                               ));
        },
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
                                    new Hero(
                                      tag: "${ss.data![i]['imagen']}",
                                      child: Material(
                                        child: new InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new pajina2(
                                              gambar:
                                                  "${ss.data![i]['imagen']}",
                                              naran:
                                                  "${ss.data![i]['naran_hahan']}",
                                              deskrisaun:
                                                  "${ss.data![i]['deskrisaun']}",
                                            ),
                                          )),
                                          child: new ClipRRect(
                                            child: new Image.network(
                                              "https://mpgtl.com/crocodeli/img/${ss.data![i]['imagen']}",
                                              height: 190,
                                              width: double.infinity,
                                              //  width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

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
                                                    "${ss.data![i]['naran_hahan']}",
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.red),
                                                  ),
                                                  new Text(
                                                    "Presu : ${ss.data![i]['presu']} \$",
                                                    style: new TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                          ),
                                          new Row(children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                kirimdata(
                                                  ss.data![i]['id_hahan'],
                                                  ss.data![i]['naran_hahan'],
                                                  ss.data![i]['presu'],
                                                );
                                                // setState(() {
                                                //   total++;
                                                // });
                                                // var onePointOne = double.parse(ss.data[i]['mobile']);
                                                // setState(() {
                                                //   karakter = karakter;
                                                // });
                                              },
                                              icon: Icon(Icons.add),
                                              label: Text("Aumenta Ba raga"),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(8.0),
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                textStyle: TextStyle(
                                                    color: Colors.blue[800]),
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
                            padding: EdgeInsets.all(8.0),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            textStyle: TextStyle(color: Colors.black45),
                            splashFactory: InkSplash.splashFactory,
                          ),
                        ),
                      ])))),

        Container(
            child: koneksaunfallab
                ? FutureBuilder<List>(
                    future: getDatab(),
                    builder: (ctx, ss) {
                      if (ss.hasError) {
                        print("error");
                      }
                      if (ss.hasData) {
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          shrinkWrap: true,
                          itemCount: ss.data?.length ?? 0,
                          itemBuilder: (ctx, i) {
                            return Container(
                              child: new Column(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    new Hero(
                                      tag: "${ss.data![i]['imagen']}",
                                      child: Material(
                                        child: new InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                new pajina2(
                                              gambar:
                                                  "${ss.data![i]['imagen']}",
                                              naran:
                                                  "${ss.data![i]['naran_hahan']}",
                                              deskrisaun:
                                                  "${ss.data![i]['deskrisaun']}",
                                            ),
                                          )),
                                          child: new ClipRRect(
                                            child: new Image.network(
                                              "https://mpgtl.com/crocodeli/img/${ss.data![i]['imagen']}",
                                              height: 190,
                                              width: double.infinity,
                                              //  width: MediaQuery.of(context).size.width,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

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
                                                    "${ss.data![i]['naran_hahan']}",
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.red),
                                                  ),
                                                  new Text(
                                                    "Presu : ${ss.data![i]['presu']} \$",
                                                    style: new TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.black),
                                                  )
                                                ]),
                                          ),
                                          new Row(children: [
                                            ElevatedButton.icon(
                                              onPressed: () async {
                                                // setState(() {
                                                //   total++;
                                                // });
                                                // var onePointOne = double.parse(ss.data[i]['mobile']);
                                                kirimdata(
                                                  ss.data![i]['id_hahan'],
                                                  ss.data![i]['naran_hahan'],
                                                  ss.data![i]['presu'],
                                                );
                                                // setState(() {
                                                //   karakter = karakter;
                                                // });
                                              },
                                              icon: Icon(Icons.add),
                                              label: Text("Aumenta Ba raga"),
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(8.0),
                                                primary: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              10.0)),
                                                ),
                                                textStyle: TextStyle(
                                                    color: Colors.blue[800]),
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
                              getDatab();
                            });
                          },
                          icon: Icon(Icons.error),
                          label: Text("Koko Fali"),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(8.0),
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            textStyle: TextStyle(color: Colors.black45),
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
  pajina2({required this.gambar, this.naran, this.deskrisaun});

  final String gambar;
  final String? naran;
  final String? deskrisaun;

  @override
  _pajina2State createState() => _pajina2State();
}

class _pajina2State extends State<pajina2> {
  Color kor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;
    return Scaffold(
      body: new ListView(
        children: [
          new Container(
            width: double.infinity,
            child: new Hero(
                tag: "${widget.gambar}",
                child: new Material(
                  child: new InkWell(
                    child: new Image.network(
                      "https://mpgtl.com/crocodeli/img/${widget.gambar}",
                      height: 190,
                      width: double.infinity,
                      //  width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          new Container(
            padding: new EdgeInsets.all(20.0),
            child: new Row(children: [
              new Expanded(
                child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        "${widget.naran}",
                        style: new TextStyle(fontSize: 12.0, color: Colors.red),
                      ),
                      new Text(
                        "Presu : \$ ${widget.deskrisaun}",
                        style:
                            new TextStyle(fontSize: 12.0, color: Colors.black),
                      )
                    ]),
              ),
              new Row(children: [
                new Text("\$",
                    style: new TextStyle(fontSize: 20.0, color: Colors.red)),
                new Text(" 230",
                    style: new TextStyle(fontSize: 20.0, color: Colors.red))
              ])
            ]),
          ),
          new Card(
            child: new Container(
              padding: new EdgeInsets.all(20.0),
              child: new Column(children: [
                new Text("Deskrisaun",
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                    textAlign: TextAlign.start),
                new Text(
                  "${widget.deskrisaun}",
                  style: new TextStyle(fontSize: 10.0),
                  textAlign: TextAlign.justify,
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}

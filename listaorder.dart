import 'package:flutter/material.dart';

class Pajinar extends StatefulWidget {
  Pajinar({this.karakter});
  var karakter;

  @override
  _PajinarState createState() => _PajinarState();
}

class _PajinarState extends State<Pajinar> {
  double totalosan = 0;

  @override
  void initState() {
    totalosan = 0;
    for (var i = 0; i < widget.karakter.length; i++) {
      double sura = 0;
      sura = double.parse(widget.karakter[i]['totalorder']) *
          double.parse(widget.karakter[i]['presu']);
      totalosan = totalosan + sura;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Aiha han ne'ebe iha raga",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white70,
        // bottom: new TabBar(
        //   controller: tabmenu,
        //   tabs: [
        //     new Tab(icon: new Icon(Icons.home),),
        //        new Tab(icon: new Icon(Icons.mediation),),
        //           new Tab(icon: new Icon(Icons.save),),
        //             // new Tab(icon: new Icon(Icons.people),),
        //   ]),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.karakter == null ? 0 : widget.karakter.length,
              itemBuilder: (ctx, i) {
                double sura = 0;
                sura = double.parse(widget.karakter[i]['totalorder']) *
                    double.parse(widget.karakter[i]['presu']);

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
                                        "${widget.karakter[i]['naran']}",
                                        style: new TextStyle(
                                            fontSize: 16.0, color: Colors.red),
                                      ),
                                      new Text(
                                        "Presu : ${widget.karakter[i]['presu']} \$",
                                        style: new TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black),
                                      )
                                    ]),
                              ),
                              new Row(children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    // setState(() {
                                    //   // total++;
                                    // });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    primary: Colors.white,
                                    onPrimary: Colors.blue[800],
                                    splashFactory: InkRipple.splashFactory,
                                  ),
                                  icon: Icon(Icons.shopify_sharp),
                                  label: Text(
                                    "${widget.karakter[i]['totalorder']} Presu :  \$ ${sura}",
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                    ),
                                  ),
                                )
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
                          style:
                              new TextStyle(fontSize: 16.0, color: Colors.red),
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
                      // setState(() {
                      //   // total++;
                      // });
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      primary: Colors.white,
                      onPrimary: Colors.blue[800],
                      splashFactory: InkRipple.splashFactory,
                    ),
                    label: Text(
                      "Kontinua ",
                      style: TextStyle(
                        color: Colors.blue[800],
                      ),
                    ),
                    icon: Icon(Icons.forward),
                  )
                ])
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class ListviewDados extends StatelessWidget {
  ListviewDados({required this.titulu});
  final String titulu;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(20.0),
      child: new Column(children: [
        new Text(titulu, style: new TextStyle(fontSize: 20.0)),
      ]),
    );
  }
}

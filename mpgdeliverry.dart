import 'package:flutter/material.dart';
import './uma.dart' as umax;
import './main.dart';
import './order.dart' as order;
import './arquivu.dart' as arquivu;
import 'package:shared_preferences/shared_preferences.dart';

class Uma extends StatefulWidget {
  @override
  _umaState createState() => _umaState();
}

class _umaState extends State<Uma> with SingleTickerProviderStateMixin {
  String naran = "";
  String id = "";
  String imagen = "";

  late TabController tabmenu;

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        //  title: new Text("Crocodelly"),
        title: new Text("Buras"),
        backgroundColor: Color.fromARGB(255, 86, 169, 70),
        // bottom: new TabBar(
        //   controller: tabmenu,
        //   tabs: [
        //     new Tab(icon: new Icon(Icons.home),),
        //        new Tab(icon: new Icon(Icons.mediation),),
        //           new Tab(icon: new Icon(Icons.save),),
        //             // new Tab(icon: new Icon(Icons.people),),
        //   ]),
      ),
      drawer: new Drawer(
        child: new ListView(children: [
          new UserAccountsDrawerHeader(
            currentAccountPicture: new GestureDetector(
              child:
                  new CircleAvatar(backgroundImage: new NetworkImage(imagen)),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: new NetworkImage(imagen), fit: BoxFit.cover),
            ),
            accountName: new Text(naran),
            accountEmail: new Text(id),
          ),
          new ListTile(
              title: new Text("Ajuda"), trailing: new Icon(Icons.help)),
          new ListTile(
            title: new Text("Termu No Privasidade"),
            trailing: new Icon(Icons.privacy_tip),
          ),
          new ListTile(
            title: new Text("Share Apps"),
            trailing: new Icon(Icons.share),
          ),
          new ListTile(
            title: new Text("Avalia Apps"),
            trailing: new Icon(Icons.star),
          ),
          new ListTile(
            title: new Text("LogOut"),
            onTap: () async {},
            trailing: new Icon(Icons.close),
          )
        ]),
      ),
      body: new TabBarView(controller: tabmenu, children: [
        new umax.Foods(),
        new order.Order(),
        //    new arquivu.Arquivu(),
      ]),
      bottomNavigationBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: new Material(
          color: Color.fromARGB(255, 86, 169, 70),
          child: new TabBar(controller: tabmenu, tabs: [
            Container(
              padding: EdgeInsets.all(5.0),
              child: new Tab(
                  icon: new Column(
                children: [
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Icon(Icons.home),
                  new Text(
                    "Varanda",
                    style: TextStyle(fontSize: 11.0),
                  )
                ],
              )),
            ),
            Container(
              padding: EdgeInsets.all(5.0),
              child: new Tab(
                  icon: new Column(
                children: [
                  new Padding(padding: EdgeInsets.only(top: 5.0)),
                  new Icon(Icons.list_alt),
                  new Text("Order", style: TextStyle(fontSize: 11.0))
                ],
              )),
            ),
            //  new Tab(icon: new Column(children: [new Padding(padding: EdgeInsets.only(top:5.0)),new Icon(Icons.account_balance_rounded),new Text("Acount",style: TextStyle(fontSize:11.0))],)),
            // new Tab(icon: new Icon(Icons.people),text: "Arquivu",),
          ]),
        ),
      ),
    );
  }
}

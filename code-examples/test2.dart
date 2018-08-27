import 'dart:convert';
import 'dart:async'; //for Futures
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _news = [];

  //this async func will get data from the internet
  //when our func is done we return a string
  void getNews() async{
    var url = 'https://techlomedia.in/wp-json/wp/v2/posts?_embed&per_page=2';
    var response = await http.get(url);

    if(response.statusCode == 200){
      setState(() => _news = json.decode(response.body));
      print('Loaded ${_news.length} news');
    }
  }

  String mainProfilePicture = "https://randomuser.me/api/portraits/men/44.jpg";

  void switchUser(){
    String backupString = mainProfilePicture;
    this.setState((){
      mainProfilePicture = backupString;
    });
  }

  @override
  Widget build(BuildContext context) {
    //getNews();
    return new Scaffold(
      appBar: new AppBar(title: new Text("Home"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Raunak Hajela", style: new TextStyle(color: Colors.black),),
              accountEmail: new Text("See profile", style: new TextStyle(color: Colors.black),),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              currentAccountPicture: new GestureDetector(
                onTap: () => switchUser(),
                child: new CircleAvatar(
                    backgroundImage: new NetworkImage(mainProfilePicture)
                ),
              ),
            ),
            new ListTile(
                title: new Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => null));
                }
            ),
            new ListTile(
                title: new Text("Bookmarks"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => null));
                }
            ),
            new ListTile(
              title: new Text("Interests"),
              onTap: () => Navigator.of(context).pop(),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Become a member"),
              onTap: () => Navigator.of(context).pop(),
            ),
            new Divider(),
            new ListTile(
              title: new Text("New story"),
              onTap: () => Navigator.of(context).pop(),
            ),
            new ListTile(
              title: new Text("Stats"),
              onTap: () => Navigator.of(context).pop(),
            ),
            new ListTile(
              title: new Text("Drafts"),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Expanded(child: new ListView.builder(
              itemCount: _news.length,
              itemBuilder: (BuildContext context, int index){
                return new Column(
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.all(5.0)),
                    new Text(_news[index]["title"]["rendered"], style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87),),
                    new Padding(padding: EdgeInsets.all(5.0)),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    getNews();
  }
}

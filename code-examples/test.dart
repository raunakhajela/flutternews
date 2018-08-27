import 'dart:convert';
import 'dart:async'; //for Futures
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //Base URL for website
  final String Url = "https://newsapi.org/";

  //api
  final String api = "v2/";

  List news;

  //this async func will get data from the internet
  //when our func is done we return a string
  Future getNews() async{
    var res = await http.get(
      //Uri.encodeFull removes all the dashes or extra characters present in our Uri
        Uri.encodeFull(Url + api + "top-headlines?country=in&apiKey=c638e546a28f4c99a9b0ee4cff77c590"),
        headers: {
          "Accept": "application/json"
        }
    );

    print(res.body);

    // fill our posts with results and update state
    setState(() {
      var resBody = json.decode(res.body);
      //print(resBody);
      news = resBody;
      //print(news);
    });

//    print(news[0]);
    return "Success!";
  }

  String mainProfilePicture = "https://randomuser.me/api/portraits/women/44.jpg";

  void switchUser(){
    String backupString = mainProfilePicture;
    this.setState((){
      mainProfilePicture = backupString;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: new Center(
            child: new RaisedButton(
              child: new Text("Get news"),
              onPressed: getNews,
            )
        )
    );
  }
}

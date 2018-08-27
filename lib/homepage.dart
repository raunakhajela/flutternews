import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:html/parser.dart'; //to parse html from the string

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _news = [];

  //this async func will get data from the internet
  //when our func is done we return a string
  void _getNews() async {
    var url = 'https://techlomedia.in/wp-json/wp/v2/posts?_embed&per_page=50';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() => _news = json.decode(response.body));
      print('Loaded ${_news.length} news');
    }
  }

  String mainProfilePicture = "https://randomuser.me/api/portraits/men/44.jpg";

  void switchUser() {
    String backupString = mainProfilePicture;
    this.setState(() {
      mainProfilePicture = backupString;
    });
  }

  //remove html code from our news excerpt
  String _parseHtmlExcerpt(String excerpt) {

    var document = parse(excerpt);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString.substring(0, 30) + "...";
  }

  @override
  Widget build(BuildContext context) {
    //getNews();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text(
                "Raunak Hajela",
                style: new TextStyle(color: Colors.black),
              ),
              accountEmail: new Text(
                "See profile",
                style: new TextStyle(color: Colors.black),
              ),
              decoration: BoxDecoration(
                color: Colors.white70,
              ),
              currentAccountPicture: new GestureDetector(
                onTap: () => switchUser(),
                child: new CircleAvatar(
                    backgroundImage: new NetworkImage(mainProfilePicture)),
              ),
            ),
            new ListTile(
                title: new Text("Home"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => null));
                }),
            new ListTile(
                title: new Text("Bookmarks"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => null));
                }),
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
      body: new Column(
        children: <Widget>[
          new Expanded(
            child: new ListView.builder(
                padding: EdgeInsets.only(bottom: 120.0),
                itemCount: _news.length,
                itemBuilder: (BuildContext context, int index){
                  return new InkWell(
                    child: new Column(
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            new Padding(
                              padding: new EdgeInsets.only(left: 18.0, top: 30.0, bottom: 0.0, right: 0.0),
                              child: new Text("based on your reading history".toUpperCase(), style: new TextStyle(fontWeight: FontWeight.w400, color: Colors.grey[600], fontSize: 16.0),),
                            ),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child: new GestureDetector(
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 18.0, right: 15.0, bottom: 15.0, top: 8.0),
                                      child: new Text(_news[index]["title"]["rendered"], style: new TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 22.0)),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 18.0, right: 15.0, bottom: 16.0),
                                      child: new Text(_parseHtmlExcerpt(_news[index]["excerpt"]["rendered"]), style: new TextStyle(color: Colors.grey[500], fontSize: 18.0),),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 18.0, top: 10.0,),
                                      child: new Text(_news[index]["_embedded"]["author"][0]["name"], style: new TextStyle(color: Colors.black87, fontSize: 16.0),),
                                    ),
                                    new Padding(
                                      padding: new EdgeInsets.only(left: 18.0, top: 5.0, bottom: 16.0),
                                      child: new Text("2 mins ago | 5 min read", style: new TextStyle(color: Colors.grey[500], fontSize: 16.0),),
                                    ),
                                  ],
                                ),
                                onTap: (){
                                  print('Open news details screen');
                                },
                              ),
                            ),
                            new Column(
                              children: <Widget>[
                                new Padding(
                                  padding: new EdgeInsets.only(top: 14.0),
                                  child: new SizedBox(
                                    height: 100.0,
                                    width: 90.0,
                                    child: new Padding(
                                      padding: new EdgeInsets.only(right: 20.0),
                                      child: new Image.network(_news[index]["_embedded"]["wp:featuredmedia"][0]["source_url"], fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                new Row(
                                  children: <Widget>[
                                    new GestureDetector(
                                      child: new Padding(
                                          padding:new EdgeInsets.all(4.0),
                                          child: new Icon(Icons.bookmark_border)),
                                      onTap: (){
                                        print('Bookmark the current article and save it in Bookmarks screen');
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        new Divider(color: Colors.black87,),
                      ],
                    ),
                  );
                }
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _getNews();
  }
}

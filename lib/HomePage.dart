import 'package:flutter/material.dart';
import 'package:flutter_app/ListPage.dart';


class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _toast(String msg) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(msg),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(widget.title),
        centerTitle: true,
        leading: new IconButton(icon: new Icon(Icons.list)
          , onPressed:()=> _toListPage(),),
        actions: <Widget>[
          new Row(
            children: <Widget>[
              new IconButton(icon: new Icon(Icons.link)
                , onPressed:()=> _toast('Link')
                ,alignment: Alignment.centerLeft,),
              new PopupMenuButton<String>(
                  itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                        value: "price", child: new Text('Sort by price',textAlign: TextAlign.center,)),
                    new PopupMenuItem<String>(
                        value: "time", child: new Text('Sort by time',textAlign: TextAlign.center,)),
                  ],
                  onSelected: (String action) {
                    switch (action) {
                      case "price":
                        _toast('Price');
                        break;
                      case "time":
                        _toast('Time');
                        break;
                    }
                  })],),
        ],
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'You have pushed the button this many times:',
              textDirection: TextDirection.ltr,
            ),
            new Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            new Container(
                width: 200.0,
                height: 200.0,
                child: new Text('$_counter'),
                alignment: Alignment.center,
                //transform: new Matrix4.rotationZ(0.3), //旋转
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
                  image: new DecorationImage(
                    image: new NetworkImage('http://i3.sinaimg.cn/cj/2015/0317/U12164P31DT20150317134615.jpg'),
                    centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
                  ),
                )
            )],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
//        child: new Icon(Icons.add),
        child: new Text("add",
          style: Theme.of(context).textTheme.body1,
          textDirection: TextDirection.ltr,
          locale: Locale("en","US"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _toListPage() {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => new MyListPage()),
    );
  }
}
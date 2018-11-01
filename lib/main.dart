import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        body : new MyHomePage(title: 'Flutter Demo Home Page'),
      ),
      //home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

  void _toast() {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("OMG"),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(widget.title),
        centerTitle: true,
        actions: <Widget>[
          new Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
            new MaterialButton(color: Colors.yellow,
              onPressed: _toast,)
          ],),
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
}

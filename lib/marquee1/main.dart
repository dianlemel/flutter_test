import 'package:flutter/material.dart';

import 'marquee.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage('Flutter Marquee'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.title);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 40.0,
              child: MarqueeContinuous(
                Container(
                  padding: EdgeInsets.all(8.0),
                  // add padding to separate
                  child: Text('this is a short but continous shown text.'),
                ),
              ),
            ),
            MarqueeSingle(Text('this is a short text')),
            MarqueeSingle(
              Container(
                color: Colors.green,
                child: Text('this is a short text with long width'),
                width: double.maxFinite,
              ),
            ),
            Container(
              height: 100.0,
              child: MarqueeContinuous(
                FlutterLogo(size: 100.0),
              ),
            ),
            MarqueeSingle(FlutterLogo(size: 100.0)),
            Container(
              height: 100.0,
              child: MarqueeContinuous(
                Row(
                  children: [
                    FlutterLogo(size: 100.0),
                    Text('text with image')
                  ],
                ),
              ),
            ),
            MarqueeSingle(
              Row(
                children: [
                  FlutterLogo(size: 100.0),
                  Text('text with image')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

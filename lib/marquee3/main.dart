import 'package:flutter/cupertino.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          // height: 50,
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.cyanAccent)),
              Expanded(child: Container(color: Colors.cyan)),
              Expanded(child: Container(color: Colors.amber)),
              Expanded(child: Container(color: Colors.greenAccent)),
              Expanded(child: Container(color: Colors.cyanAccent)),
              Expanded(child: Container(color: Colors.cyan)),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.amber,
                  child: TextMarquee("123456789 123456789 123456789",10),
                ),
              ),
              Expanded(child: Container(color: Colors.greenAccent)),
            ],
          ),
        ),
      ),
    );
  }
}

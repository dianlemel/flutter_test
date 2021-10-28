import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ScreenUtil.dart';
import 'linechart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  final List<Feature> features = [
    Feature(
      color: Colors.blue,
      data: [0.2, 0.8, 0.4, 0.7, 0.6],
    ),
    Feature(
      color: Colors.pink,
      data: [1, 0.8, 0.6, 0.7, 0.3],
    ),
    Feature(
      color: Colors.cyan,
      data: [0.5, 0.4, 0.85, 0.4, 0.7],
    ),
    Feature(
      color: Colors.green,
      data: [0.6, 0.2, 0, 0.1, 1],
    ),
    Feature(
      color: Colors.amber,
      data: [0.25, 1, 0.3, 0.8, 0.6],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 500,
          width: 700,
          color: Colors.black12,
          alignment: Alignment.center,
          child: LineGraph(
            features: features,
            labelX: const ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
            labelY: const ['20%', '40%', '60%', '80%', '100%'],
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with Design {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: sizeVertical(context, 400),
          child: Row(
            children: [
              Container(width: sizeHorizontal(context, 100)),
              Expanded(child: Container()),
              Container(width: sizeHorizontal(context, 100)),
            ],
          ),
        ),
      ),
    );
  }
}

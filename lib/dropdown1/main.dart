import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ScreenUtil.dart';
import 'dropdown.dart';

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

class _MyHomePageState extends State<MyHomePage> with Design {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: sizeVertical(context, 121),
          child: Row(
            children: [
              Container(width: sizeHorizontal(context, 100)),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '選擇單元',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    color: const Color(0xff0854b9),
                    fontSize: fontExchange(context, 60),
                  ),
                ),
              ),
              Container(width: sizeHorizontal(context, 43)),
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: const Color(0xff003f70), width: 1),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    sizeHorizontal(context, 37),
                    0,
                    sizeHorizontal(context, 37),
                    0,
                  ),
                  child: DropDown(),
                ),
              ),
              Container(width: sizeHorizontal(context, 100)),
            ],
          ),
        ),
      ),
    );
  }
}

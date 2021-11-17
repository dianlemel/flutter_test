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

class Root extends StatefulWidget {
  @override
  RootState createState() => RootState();
}

class RootState extends State<Root> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return MyHomePage();
                }));
              },
              child: Text("next", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
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
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Container()),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) {
                  return Root();
                }));
              },
              child: Text("next", style: TextStyle(fontSize: 40)),
            ),
            Container(height: sizeVertical(context, 100)),
            SizedBox(
              height: sizeVertical(context, 121),
              child: Row(
                children: [
                  Container(width: sizeHorizontal(context, 500)),
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
                        border: Border.all(
                          color: const Color(0xff003f70),
                          width: 1,
                        ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                        sizeHorizontal(context, 20),
                        0,
                        sizeHorizontal(context, 20),
                        0,
                      ),
                      child: DropDown(),
                    ),
                  ),
                  Container(width: sizeHorizontal(context, 500)),
                ],
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

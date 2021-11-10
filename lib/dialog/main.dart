import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ScreenUtil.dart';
import 'custom_dialog_box.dart';

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
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              barrierDismissible: false,
              useSafeArea: false,
              context: context,
              builder: (_) {
                return CustomDialogBox(
                  "Custom Dialog Demo",
                  "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                  "Yes",
                );
              },
            ).then((value) => print(value));
          },
          child: Text("Custom Dialog"),
        ),
      ),
    );
  }
}

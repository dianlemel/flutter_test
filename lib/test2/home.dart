import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (setting) {
        return MaterialPageRoute(
            settings: const RouteSettings(name: "Home"),
            builder: (_) {
              return Home();
            });
      },
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  Size _textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    print(_textSize("1234567890", TextStyle(fontSize: 40)));
    print(_textSize("12345", TextStyle(fontSize: 40)));

    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container()),
            Container(
              height: 47,
              width: 225,
              child: Text("1234567890", style: TextStyle(fontSize: 40)),
              color: Colors.black12,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Page01(pop)));
              },
              child: Text("push", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }

  void pop() {
    Navigator.pop(context);
  }
}

class Page01 extends StatefulWidget {
  final void Function() pop;

  Page01(this.pop);

  @override
  State<StatefulWidget> createState() => Page01State();
}

class Page01State extends State<Page01> with NavigatorObserver {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: [this],
      onGenerateRoute: (setting) {
        return MaterialPageRoute(builder: (BuildContext context) {
          return Page02();
        });
      },
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('didPop route: $route ,previousRoute: $previousRoute');
    if (previousRoute == null) {
      widget.pop();
    }
  }
}

class Page02 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Page02State();
}

class Page02State extends State<Page02> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container()),
            Text("Page02", style: TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Page03()));
              },
              child: Text("push", style: TextStyle(fontSize: 40)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("pop", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class Page03 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Page03State();
}

class Page03State extends State<Page03> {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(child: Container()),
            Text("Page03", style: TextStyle(fontSize: 40)),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: Text("pop", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

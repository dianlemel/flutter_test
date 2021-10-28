import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Page01 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page01();
}

class Page02 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page02();
}

class Page03 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page03();
}

class Page04 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Page04();
}

class MyApp extends StatelessWidget with NavigatorObserver{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (setting) {
        return MaterialPageRoute(
          settings: RouteSettings(name: "Page01"),
          builder: (ctx) {
            return Page01();
          },
        );
      },
    );
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    print('didPop: ${route.settings.name} ,previousRoute: ${previousRoute?.settings.name}');
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    print('didPush: ${route.settings.name} ,previousRoute: ${previousRoute?.settings.name}');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    print('didRemove: ${route.settings.name} ,previousRoute: ${previousRoute?.settings.name}');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    print('didReplace: ${newRoute?.settings.name} ,previousRoute: ${oldRoute?.settings.name}');
  }
}

class _Page01 extends State<Page01> {
  final String title = "01";

  @override
  Widget build(BuildContext context) {
    print('page$title build');
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Container()),
            Text("Page$title", style: TextStyle(fontSize: 40)),
            Container(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    settings: RouteSettings(name: "Page02"),
                    builder: (ctx) {
                      return Navigator(
                        onGenerateRoute: (s){
                          MaterialPageRoute(
                            settings: s,
                            builder: (ctx) {
                              return Page02();
                            },
                          );
                        },
                      );
                    },
                  ),
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     settings: RouteSettings(name: "Page02"),
                //     builder: (ctx) {
                //       return Page02();
                //     },
                //   ),
                // );
              },
              child: Text("next", style: TextStyle(fontSize: 40)),
            ),
            ElevatedButton(
              onPressed: () async {
                if(Navigator.canPop(context)){
                  Navigator.pop(context);
                }
              },
              child: Text("home", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class _Page02 extends State<Page02> {
  final String title = "02";

  @override
  Widget build(BuildContext context) {
    print('page$title build');
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        // child: WillPopScope(
        //   onWillPop: () async {
        //     print('123');
        //     return true;
        //   },
        child: Column(
          children: [
            Expanded(child: Container()),
            Text("Page$title", style: TextStyle(fontSize: 40)),
            Container(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Navigator.push(context, MaterialPageRoute(
                //   // settings: RouteSettings(name: "Page03"),
                //   builder: (ctx) {
                //     return Navigator(
                //       onGenerateRoute: (s) => MaterialPageRoute(
                //         // settings: RouteSettings(name: "Page03"),
                //         settings: s,
                //         builder: (ctx) {
                //           return Page03();
                //         }
                //       ),
                //     );
                //   },
                // ));
                Navigator.push(context, MaterialPageRoute(
                  settings: RouteSettings(name: "Page03"),
                  builder: (ctx) {
                    return Page03();
                  },
                ));
              },
              child: Text("next", style: TextStyle(fontSize: 40)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.popUntil(context, ModalRoute.withName("Page01"));
              },
              child: Text("home", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
        // ),
      ),
    );
  }
}

class _Page03 extends State<Page03> {
  final String title = "03";

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Container()),
            Text("Page$title", style: TextStyle(fontSize: 40)),
            Container(height: 20),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (ctx) {
                    return Page04();
                  },
                ));
              },
              child: Text("next", style: TextStyle(fontSize: 40)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.popUntil(context, (route) => route.isFirst);
                // Navigator.popUntil(context, ModalRoute.withName("Page01"));
              },
              child: Text("home", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

class _Page04 extends State<Page04> {
  final String title = "04";

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(child: Container()),
            Text("Page$title", style: TextStyle(fontSize: 40)),
            Container(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName("/"));
              },
              child: Text("home", style: TextStyle(fontSize: 40)),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

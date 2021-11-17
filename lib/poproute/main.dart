import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter高级进阶',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget button(context, index) {
    GlobalKey key = GlobalKey();
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        key: key,
        icon: const Icon(Icons.more_horiz, color: Colors.black),
        onPressed: () {
          // 使用路由跳转方式
          Navigator.push(
            context,
            PopRoute(
              child: Popup(
                btnContext: key.currentContext!,
                onClick: (v) => debugPrint('你点击了$v'), // 传到外面来的回调事件
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("width: ${MediaQuery.of(context).size.width}");
    print("height: ${MediaQuery.of(context).size.height}");
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter高级进阶')),
      body: ListView.builder(itemBuilder: button),
    );
  }
}

class PopRoute extends PopupRoute {
  // push的耗时，milliseconds为毫秒
  final Duration _duration = const Duration(milliseconds: 300);

  // 接收一个child，也就是我们push的内容。
  Widget child;

  // 构造方法
  PopRoute({required this.child});

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;
}

// 类型声明回调
typedef OnItem = Function(String value);

class Popup extends StatefulWidget {
  final BuildContext btnContext;
  final OnItem onClick; //点击child事件

  Popup({required this.btnContext, required this.onClick});

  @override
  PopupState createState() => PopupState();
}

class PopupState extends State<Popup> {
  // 声明对象
  late RenderBox button;
  late RenderBox overlay;
  late RelativeRect position;

  late Size size;
  late Offset offset;

  @override
  void initState() {
    super.initState();
    RenderBox renderBox = widget.btnContext.findRenderObject() as RenderBox;
    size = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);
  }

  // item构建
  Widget itemBuild(item) {
    // 字体样式
    TextStyle labelStyle = const TextStyle(color: Colors.white);

    return Expanded(
      child: ElevatedButton(
        //点击Item
        onPressed: () {
          // 如果没接收也返回的花就会报错，所以这里需要判断
          Navigator.of(context).pop();
          widget.onClick(item); // 事件返回String类型的值
        },
        child: Text(item, style: labelStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // Material类型设置
      child: GestureDetector(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              // 设置一个容器组件，是整屏幕的。
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent, // 它的颜色为透明色
            ),
            Positioned(
              child: Container(
                width: 200,
                height: 36,
                decoration: const BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.all(Radius.circular(4.0)), // 圆角
                ),
                child: Row(children: ['点赞', '评论'].map(itemBuild).toList()),
              ),
              top: offset.dy, // 顶部位置
              // right: position.right, // 右边位置
              // top: 128, // 顶部位置
              left: offset.dx - 200,
            )
          ],
        ),
        onTap: () => Navigator.of(context).pop(), //点击空白处直接返回
      ),
    );
  }
}
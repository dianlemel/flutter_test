import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as Math;

import 'package:my_app/marquee3/marquee.dart';

class Data {
  final String name;
  final dynamic value;

  Data(this.name, this.value);
}

class DropDown extends StatefulWidget {
  final List<Data> data = [];

  DropDown() {
    for (int i = 0; i < 1; i++) {
      data.add(Data("$i 123456789 987654321 123456789", i));
    }
  }

  @override
  State<StatefulWidget> createState() => DropDownState();
}

class DropDownState extends State<DropDown> {
  final GlobalKey key = GlobalKey();
  Data? select;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      key: key,
      builder: (con, box) {
        return GestureDetector(
          onTap: () async {
            var result = await Navigator.push(
              context,
              PopRoute(
                PopupList(key.currentContext!, select, widget.data),
              ),
            );
            if (result != null) {
              setState(() {
                select = result;
              });
            }
          },
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: Colors.transparent,
                  child: TextMarquee(
                    select?.name ?? "",
                    10,
                    style: TextStyle(fontSize: 40),
                  ),
                ),
              ),
              buildArrowIcon(
                Math.min(box.maxHeight, box.maxWidth),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildArrowIcon(double iconSize) {
    return Transform.rotate(
      angle: 90 * Math.pi / 180,
      child: Icon(
        Icons.arrow_forward_ios,
        color: const Color(0xff1d80c0),
        size: iconSize,
      ),
    );
  }
}

class PopRoute extends PopupRoute {
  final Widget child;

  PopRoute(this.child);

  @override
  bool get barrierDismissible => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      child;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;
}

class PopupList extends StatefulWidget {
  final BuildContext targetContext;
  final Data? select;
  final List<Data> data;

  PopupList(this.targetContext, this.select, this.data);

  @override
  State<StatefulWidget> createState() => PopupListState();
}

class PopupListState extends State<PopupList> {
  late Size size;
  late Offset offset;
  late final double popupHeight;
  final double itemHeight = 40;

  @override
  void initState() {
    super.initState();
    if (widget.data.length < 10) {
      popupHeight = widget.data.length * itemHeight + 20;
    } else {
      popupHeight = itemHeight * 10 + 20;
    }
  }

  Size textSize(String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(
        minWidth: 0,
        maxWidth: double.infinity,
      );
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    RenderBox renderBox = widget.targetContext.findRenderObject() as RenderBox;
    size = renderBox.size;
    offset = renderBox.localToGlobal(Offset.zero);
    double y = offset.dy + 5 + popupHeight;
    if (y > MediaQuery.of(context).size.height) {
      y = MediaQuery.of(context).size.height - popupHeight - 10;
    } else {
      y = offset.dy + 5;
    }
    List<Widget> column = [];
    for (var d in widget.data) {
      column.add(SizedBox(
        height: itemHeight,
        child: DropDownItem(d, (data) => Navigator.of(context).pop(data),
            ((widget.select?.name ?? "") == d.name)),
      ));
    }
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.transparent,
            ),
            Positioned(
              child: Container(
                width: size.width,
                height: popupHeight,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: column,
                  ),
                ),
              ),
              top: y, // 顶部位置
              left: offset.dx,
            )
          ],
        ),
        onTap: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class DropDownItem extends StatefulWidget {
  final Data data;
  final Function(Data) onClick;
  final bool select;

  DropDownItem(this.data, this.onClick, this.select);

  @override
  State<StatefulWidget> createState() => DropDownItemState();
}

class DropDownItemState extends State<DropDownItem> {
  bool onMouse = false;

  Color getColor() {
    if (widget.select) {
      if (onMouse) {
        return const Color(0xffd3d3d3);
      } else {
        return const Color(0xffdcdcdc);
      }
    } else {
      if (onMouse) {
        return const Color(0xfff0f0f0);
      } else {
        return Colors.transparent;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onClick(widget.data);
      },
      child: MouseRegion(
        onEnter: (e) {
          setState(() {
            onMouse = true;
          });
        },
        onExit: (e) {
          setState(() {
            onMouse = false;
          });
        },
        child: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          height: double.infinity,
          color: getColor(),
          child: TextMarquee(
            widget.data.name,
            10,
            style: TextStyle(fontSize: 40),
          ),
        ),
      ),
    );
  }
}

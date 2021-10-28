import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:my_app/marquee2/text_marquee.dart';

class DropDown extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => DropDownState();
}

class DropDownState extends State<DropDown> {

  OverlayEntry? overlayEntry;

  @override
  void dispose() {
    super.dispose();
    overlayEntry?.remove();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            foregroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: Row(
            children: [
              Expanded(
                child: Container(),
              ),
              const SizedBox(
                width: 10,
              ),
              buildArrowIcon(
                  math.min(constraints.maxHeight, constraints.maxWidth)),
            ],
          ),
        );
      },
    );
  }

  Widget buildArrowIcon(double iconSize) {
    return Transform.rotate(
      angle: 90 * math.pi / 180,
      child: Icon(Icons.arrow_forward_ios,
          color: const Color(0xff1d80c0), size: iconSize),
    );
  }

  OverlayEntry createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx,
        top: offset.dy + size.height + 5.0,
        width: size.width,
        child: Material(
          elevation: 4.0,
          child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: const [
              ListTile(
                title: TextMarquee('123456789123456789123456789123456789123456789123456789123456789123456789',style: TextStyle(fontSize: 40)),
              ),
              ListTile(
                title: TextMarquee('123456789123456789',style: TextStyle(fontSize: 40)),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onClick() {
    print('onClick');
    if (overlayEntry == null) {
      overlayEntry = createOverlayEntry();
      Overlay.of(context)!.insert(overlayEntry!);
    }else{
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }
}

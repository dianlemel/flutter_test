import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextMarquee extends StatelessWidget {
  final String text;
  final int speed;
  final TextStyle? style;

  TextMarquee(this.text, this.speed, {this.style});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      double textWidth = textSize(text, style: style).width;
      if (width < textWidth) {
        return AnimationTextMarquee(
            text, speed, constraints.maxHeight, constraints.maxWidth,
            style: style);
      } else {
        return Text(
          text,
          style: style,
        );
      }
    });
  }
}

class AnimationTextMarquee extends StatefulWidget {
  final String text;
  final int speed;
  final TextStyle? style;
  final double height;
  final double width;

  AnimationTextMarquee(this.text, this.speed, this.height, this.width,
      {this.style});

  @override
  State<StatefulWidget> createState() => AnimationTextMarqueeState();
}

class AnimationTextMarqueeState extends State<AnimationTextMarquee>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.speed),
    );
    Tween<double> tween = Tween(
        begin: widget.width,
        end: -(textSize(widget.text, style: widget.style).width));
    animation = tween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(),
      child: CustomPaint(
        painter: MarqueePainter(
          widget.text,
          animation.value,
          style: widget.style,
        ),
      ),
    );
  }
}

class MarqueePainter extends CustomPainter {
  final String text;
  final double offset;
  final TextStyle? style;

  MarqueePainter(this.text, this.offset, {this.style});

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        style: style,
        text: text,
      ),
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset centerLeft =
        Offset(offset, size.height / 2 - textPainter.size.height / 2);
    textPainter.paint(canvas, centerLeft);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

Size textSize(String text, {TextStyle? style}) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(
      minWidth: 0,
      maxWidth: double.infinity,
    );
  return textPainter.size;
}

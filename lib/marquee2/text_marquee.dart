import 'package:flutter/cupertino.dart';

class TextMarquee extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int speed;

  const TextMarquee(this.text, {Key? key, this.style, this.speed = 10})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TextMarqueeState();
}

class TextMarqueeState extends State<TextMarquee> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        Text text = Text(widget.text, style: widget.style, maxLines: 1);
        if (constraints.maxWidth >=
            textWidth(widget.text, style: widget.style)) {
          return text;
        } else {
          return MarqueeSingle(text, widget.speed);
        }
      },
    );
  }

  double textWidth(String text, {TextStyle? style}) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size.width;
  }
}

class MarqueeSingle extends StatefulWidget {
  final Widget child;
  final int speed;

  MarqueeSingle(this.child, this.speed);

  @override
  _MarqueeSingleState createState() => _MarqueeSingleState();
}

class _MarqueeSingleState extends State<MarqueeSingle>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(seconds: widget.speed));
    animation = Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset(-1.0, 0.0))
        .animate(controller);
    animation.addListener(() {

      setState(() {});
    });
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: FractionalTranslation(
        translation: animation.value,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

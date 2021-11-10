import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class LineChar extends StatefulWidget {
  final List<Feature> features;
  final List<String> labelX;
  final List<String> labelY;
  final String? fontFamily;

  LineChar(
    this.features,
    this.labelX,
    this.labelY, {
    this.fontFamily,
  });

  @override
  LineCharState createState() => LineCharState();
}

class LineCharState extends State<LineChar> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      return SizedBox(
        height: height,
        width: width,
        child: CustomPaint(
          painter: LineCharPainter(
            widget.features,
            widget.labelX,
            widget.labelY,
            widget.fontFamily,
          ),
        ),
      );
    });
  }
}

class LineCharPainter extends CustomPainter {
  final List<Feature> features;
  final List<String> labelX;
  final List<String> labelY;
  final String? fontFamily;

  LineCharPainter(
    this.features,
    this.labelX,
    this.labelY,
    this.fontFamily,
  );

  @override
  void paint(Canvas canvas, Size size) {
    double labelYWidth = 0;
    double labelYHeight = textSize(this.labelY.last).height;
    double labelXWidth = 0;
    double labelXHeight = 0;
    for (int i = 0; i < this.labelY.length; i++) {
      Size size = textSize(this.labelY[i]);
      if (size.width > labelYWidth) {
        labelYWidth = size.width;
      }
    }
    for (int i = 0; i < this.labelX.length; i++) {
      Size size = textSize(this.labelX[i]);
      if (size.height > labelXHeight) {
        labelXHeight = size.height;
      }
      if (size.width > labelXWidth) {
        labelXWidth = size.width;
      }
    }
    labelYWidth *= 1.5;
    labelXHeight *= 2;

    Size labelY = Size(labelYWidth, labelYHeight);
    Size labelX = Size(labelXWidth, labelXHeight);

    Size graph = Size(
      size.width - labelY.width - labelY.width / 2,
      size.height - labelX.height - labelY.height,
    );
    Size cell = Size(
      graph.width / (this.labelX.length - 1),
      graph.height / this.labelY.length,
    );

    drawAxis(canvas, labelY, labelX, graph, size);
    drawLabelsY(canvas, labelY, labelX, graph, cell);
    drawLabelsX(canvas, labelY, labelX, graph, cell);

    for (int i = 0; i < features.length; i++) {
      drawLine(features[i], canvas, labelY, graph, cell);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawAxis(
      Canvas canvas, Size labelY, Size labelX, Size graph, Size size) {
    Paint linePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(labelY.width, size.height - labelX.height),
      Offset(size.width - labelY.width / 2, size.height - labelX.height),
      linePaint,
    );
    canvas.drawLine(
      Offset(labelY.width, labelX.height / 2),
      Offset(labelY.width, size.height - labelX.height),
      linePaint,
    );
  }

  void drawLabelsY(
      Canvas canvas, Size labelY, Size labelX, Size graph, Size cell) {
    Paint strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < this.labelY.length; i++) {
      TextSpan span = TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontFamily: fontFamily,
        ),
        text: this.labelY[i],
      );
      TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      double x = (labelY.width - tp.size.width) / 2;
      double y = labelY.height / 2 + graph.height - (i + 1) * cell.height;
      tp.paint(canvas, Offset(x, y));
      Path linePath = Path();
      linePath.moveTo(labelY.width, y + tp.size.height / 2);
      linePath.lineTo(labelY.width + 10, y + tp.size.height / 2);
      canvas.drawPath(linePath, strokePaint);
    }
  }

  void drawLabelsX(
      Canvas canvas, Size labelY, Size labelX, Size graph, Size cell) {
    Paint strokePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < this.labelX.length; i++) {
      TextSpan span = TextSpan(
        style: TextStyle(
          color: Colors.black,
          fontFamily: fontFamily,
        ),
        text: this.labelX[i],
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      double x =
          graph.height + labelY.height + (labelX.height - tp.size.height) / 2;
      double y = labelY.width + cell.width * i - tp.size.width / 2;
      Path linePath = Path();

      if (i == 0) {
        y += tp.size.width / 2;
      } else if ((i + 1) >= this.labelX.length) {
        linePath.moveTo(y + tp.size.width / 2, graph.height + labelY.height);
        linePath.lineTo(
            y + tp.size.width / 2, graph.height + labelY.height - 10);
        canvas.drawPath(linePath, strokePaint);
        y -= tp.size.width / 2;
      } else {
        linePath.moveTo(y + tp.size.width / 2, graph.height + labelY.height);
        linePath.lineTo(
            y + tp.size.width / 2, graph.height + labelY.height - 10);
        canvas.drawPath(linePath, strokePaint);
      }
      tp.paint(canvas, Offset(y, x));
    }
  }

  void drawLine(
      Feature feature, Canvas canvas, Size labelY, Size graph, Size cell) {
    Paint strokePaint = Paint()
      ..color = feature.color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path linePath = Path();
    linePath.moveTo(
      labelY.width,
      labelY.height + graph.height - feature.data[0] * graph.height,
    );
    int i = 0;
    for (i = 1; i < feature.data.length && i < feature.data.length; i++) {
      if (feature.data[i] > 1) {
        feature.data[i] = 1;
      }
      if (feature.data[i] < 0) {
        feature.data[i] = 0;
      }
      linePath.lineTo(
        labelY.width + i * (graph.width / (feature.data.length - 1)),
        labelY.height + graph.height - feature.data[i] * graph.height,
      );
    }
    canvas.drawPath(linePath, strokePaint);
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
}

class Feature {
  String title;
  Color color;
  List<double> data;

  Feature({
    this.title = "",
    this.color = Colors.black,
    required this.data,
  });
}

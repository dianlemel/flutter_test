import 'package:flutter/material.dart';

class LineGraph extends StatefulWidget {
  final List<Feature> features;
  final List<String>? labelX;
  final List<String>? labelY;
  final String? fontFamily;
  final Color graphColor;
  final double graphOpacity;

  LineGraph({
    required this.features,
    this.labelX,
    this.labelY,
    this.fontFamily,
    this.graphColor = Colors.grey,
    this.graphOpacity = 0.3,
  });

  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  List<Feature>? features;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, BoxConstraints constraints) {
      double height = constraints.maxHeight;
      double width = constraints.maxWidth;
      return SizedBox(
        height: height,
        width: width,
        child: CustomPaint(
          size: Size(width, height),
          painter: LineGraphPainter(
            features: features,
            labelX: widget.labelX,
            labelY: widget.labelY,
            fontFamily: widget.fontFamily,
            graphColor: widget.graphColor,
            graphOpacity: widget.graphOpacity,
          ),
        ),
      );
    });
  }
}

class LineGraphPainter extends CustomPainter {
  final List<Feature>? features;
  final List<String>? labelX;
  final List<String>? labelY;
  final String? fontFamily;
  final Color graphColor;
  final double graphOpacity;

  LineGraphPainter({
    required this.features,
    required this.labelX,
    required this.labelY,
    required this.fontFamily,
    required this.graphColor,
    required this.graphOpacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double _offsetX = 1;
    for (int i = 0; i < labelY!.length; i++) {
      if (labelY![i].length > _offsetX) {
        _offsetX = labelY![i].length.toDouble();
      }
    }

    _offsetX *= 7;
    _offsetX += 2 * size.width / 20;
    Size margin = Size(_offsetX, size.height / 8);
    Size graph = Size(
      size.width - 2 * margin.width,
      size.height - 2 * margin.height,
    );
    Size cell = Size(
      graph.width / (labelX!.length - 1),
      graph.height / labelY!.length,
    );

    drawAxis(canvas, graph, margin);
    drawLabelsY(canvas, size, margin, graph, cell);
    drawLabelsX(canvas, margin, graph, cell);

    for (int i = 0; i < features!.length; i++) {
      drawGraph(features![i], canvas, graph, cell, margin);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  void drawAxis(Canvas canvas, Size graph, Size margin) {
    Paint linePaint = Paint()
      ..color = graphColor
      ..strokeWidth = 1;

    Offset xEnd =
        Offset(graph.width + margin.width, graph.height + margin.height);
    Offset yStart = Offset(margin.width, margin.height);

    //X-Axis
    canvas.drawLine(
        Offset(margin.width, graph.height + margin.height), xEnd, linePaint);
    //Y-Axis
    canvas.drawLine(
        yStart, Offset(margin.width, graph.height + margin.height), linePaint);
  }

  void drawLabelsY(
      Canvas canvas, Size size, Size margin, Size graph, Size cell) {
    for (int i = 0; i < labelY!.length; i++) {
      TextSpan span = TextSpan(
        style: TextStyle(
          color: graphColor,
          fontFamily: fontFamily,
        ),
        text: labelY![i],
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
        canvas,
        Offset(
          size.width / 20,
          margin.height + graph.height - 8 - (i + 1) * cell.height,
        ),
      );
    }
  }

  void drawLabelsX(Canvas canvas, Size margin, Size graph, Size cell) {
    for (int i = 0; i < labelX!.length; i++) {
      TextSpan span = TextSpan(
        style: TextStyle(
          color: graphColor,
          fontFamily: fontFamily,
        ),
        text: labelX![i],
      );
      TextPainter tp = TextPainter(
          text: span,
          textAlign: TextAlign.left,
          textDirection: TextDirection.ltr);
      tp.layout();
      tp.paint(
        canvas,
        Offset(
          margin.width + cell.width * i - 16,
          margin.height + graph.height + 10,
        ),
      );
    }
  }

  void drawGraph(
      Feature feature, Canvas canvas, Size graph, Size cell, Size margin) {
    Paint fillPaint = Paint()
      ..color = feature.color.withOpacity(graphOpacity)
      ..style = PaintingStyle.fill;
    Paint strokePaint = Paint()
      ..color = feature.color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    Path linePath = Path();
    path.moveTo(margin.width, graph.height + margin.height);
    path.lineTo(
      margin.width,
      margin.height + graph.height - feature.data[0] * graph.height,
    );
    linePath.moveTo(
      margin.width,
      margin.height + graph.height - feature.data[0] * graph.height,
    );
    int i = 0;
    for (i = 1; i < labelX!.length && i < feature.data.length; i++) {
      if (feature.data[i] > 1) {
        feature.data[i] = 1;
      }
      if (feature.data[i] < 0) {
        feature.data[i] = 0;
      }
      path.lineTo(
        margin.width + i * cell.width,
        margin.height + graph.height - feature.data[i] * graph.height,
      );
      linePath.lineTo(
        margin.width + i * cell.width,
        margin.height + graph.height - feature.data[i] * graph.height,
      );
    }
    path.lineTo(
      margin.width + cell.width * (i - 1),
      margin.height + graph.height,
    );
    // canvas.drawPath(path, fillPaint);
    canvas.drawPath(linePath, strokePaint);
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

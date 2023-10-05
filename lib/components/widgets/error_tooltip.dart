import 'package:flutter/material.dart';

class ErrorTooltip extends StatelessWidget {
  const ErrorTooltip({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).canvasColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: CustomPaint(
            painter: TrianglePainter(
              color: Theme.of(context).colorScheme.error,
            ),
            child: const SizedBox(height: 12, width: 12),
          ),
        ),
      ],
    );
  }
}

class TrianglePainter extends CustomPainter {
  const TrianglePainter({
    required this.color,
  });

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    canvas.drawPath(_buildPath(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) => oldDelegate.color != color;

  Path _buildPath(double x, double y) => Path()
    ..lineTo(x, 0)
    ..lineTo(x / 2, y)
    ..lineTo(0, 0);
}

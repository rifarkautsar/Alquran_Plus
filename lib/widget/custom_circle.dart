import 'dart:math';
import 'package:flutter/material.dart';

class ZigzagCircle extends StatelessWidget {
  final String surahId;

  const ZigzagCircle({super.key, required this.surahId});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(34, 34), // Ukuran lingkaran
      painter: ZigzagCirclePainter(),
      child: Center(
        child: Text(
          surahId,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ZigzagCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xD4BD9F6F) // Warna lingkaran
      ..style = PaintingStyle.fill;

    final double radius = size.width / 2;
    final Path path = Path();

    // Menggambar lingkaran bergerigi
    for (int i = 0; i < 16; i++) {
      // Total gerigi 10
      double angle = (i * 36) * (pi / 180); // Menghitung sudut dalam radian
      double length = i % 2 == 0 ? 0.9 : 0.7; // Panjang gerigi
      double x = radius + (radius * length) * cos(angle);
      double y = radius + (radius * length) * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

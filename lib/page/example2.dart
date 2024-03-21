import 'package:flutter/material.dart';

class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  Offset? firstSelectedPosition;
  Offset? secondSelectedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Game'),
      ),
      body: GestureDetector(
        onTapUp: (TapUpDetails details) {
          // Simpan posisi puzzle yang dipilih
          if (firstSelectedPosition == null) {
            setState(() {
              firstSelectedPosition = details.localPosition;
            });
          } else {
            setState(() {
              secondSelectedPosition = details.localPosition;
            });
          }
        },
        child: CustomPaint(
          painter: PuzzlePainter(
            firstSelectedPosition: firstSelectedPosition,
            secondSelectedPosition: secondSelectedPosition,
          ),
          child: Container(), // Tempatkan puzzle di sini
        ),
      ),
    );
  }
}

class PuzzlePainter extends CustomPainter {
  final Offset? firstSelectedPosition;
  final Offset? secondSelectedPosition;

  PuzzlePainter({this.firstSelectedPosition, this.secondSelectedPosition});

  @override
  void paint(Canvas canvas, Size size) {
    // Gambar garis jika kedua puzzle dipilih
    if (firstSelectedPosition != null && secondSelectedPosition != null) {
      Paint paint = Paint()
        ..color = Colors.blue
        ..strokeWidth = 4;

      // Hitung titik tengah
      double midX = (firstSelectedPosition!.dx + secondSelectedPosition!.dx) / 2;
      double midY = (firstSelectedPosition!.dy + secondSelectedPosition!.dy) / 2;
      Offset midPoint = Offset(midX, midY);

      // Gambar garis dari titik awal ke titik tengah
      canvas.drawLine(firstSelectedPosition!, midPoint, paint);

      // Gambar garis dari titik tengah ke titik akhir
      canvas.drawLine(midPoint, secondSelectedPosition!, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

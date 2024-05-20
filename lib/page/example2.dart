import 'package:flutter/material.dart';
import 'dart:math';

class Puzzle extends StatefulWidget {
  @override
  _PuzzleState createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  Offset _position = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(200.0, 200.0),
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    Offset targetVector = Offset(200.0, 200.0) - _position;

    Offset dragVector = details.delta;

    double dotProduct = targetVector.dx * dragVector.dx + targetVector.dy * dragVector.dy;

    double targetMagnitude = targetVector.distance;
    double dragMagnitude = dragVector.distance;

    double cosAngle = dotProduct / (targetMagnitude * dragMagnitude);

    double angle = acos(cosAngle);

    angle = angle * 180 / pi;

    double maxAngle = 20;

    if (angle <= maxAngle) {
      setState(() => _position += details.delta);
    } else {
      Offset reverseTargetVector = -targetVector;
      double reverseDotProduct = reverseTargetVector.dx * dragVector.dx + reverseTargetVector.dy * dragVector.dy;
      double reverseCosAngle = reverseDotProduct / (targetMagnitude * dragMagnitude);
      double reverseAngle = acos(reverseCosAngle);
      reverseAngle = reverseAngle * 180 / pi;

      if (reverseAngle <= maxAngle) {
        setState(() => _position += details.delta);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag Path Demo'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 200,
            top: 200,
            child: DragTarget(
              builder: (BuildContext context, List<Object?> candidateData, List<dynamic> rejectedData) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                  child: Center(child: Text('Drop here')),
                );
              },
              onAccept: (data) {
                print('Object dropped!');
              },
            ),
          ),
          Positioned(
            left: _position.dx,
            top: _position.dy,
            child: GestureDetector(
              onPanUpdate: _onDragUpdate,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
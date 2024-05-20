import 'package:flutter/material.dart';
import 'package:onet_dental/component/colors.dart';
import 'package:onet_dental/component/util.dart';

class PageGame1 extends StatefulWidget {
  const PageGame1({super.key});

  @override
  State<PageGame1> createState() => _PageGame1State();
}

class _PageGame1State extends State<PageGame1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Timer', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: primary,
    );
  }
}

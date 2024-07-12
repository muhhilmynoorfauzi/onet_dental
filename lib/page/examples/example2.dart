import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:onet_dental/component/util.dart';

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('contoh'),
      ),
      body: Center(
        child: Container(
          height: tinggi(context),
          width: tinggi(context),
          color: primary,
          child: const ModelViewer(
            backgroundColor: Colors.white,
            src: 'assets/gigi1.glb',
          ),
        ),
      ),
    );
  }
}

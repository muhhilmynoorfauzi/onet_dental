import 'package:flutter/material.dart';
import 'package:onet_dental/component/colors.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        title: const Text('Menu'),
        backgroundColor: primary,
      ),
    );
  }
}

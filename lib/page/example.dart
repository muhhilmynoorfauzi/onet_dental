import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class MyWorld extends FlameGame {
  @override
  FutureOr<void> onLoad() async {
    add(TextComponent(text: "hello world $size", position: size / 4));
    await super.onLoad();
  }
}

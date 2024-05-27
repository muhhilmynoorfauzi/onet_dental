import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  //--------------------------------------------------------------------------------------------
  final _player = AudioPlayer();
  final _playerNotif = AudioPlayer();
  var getMusic = true;

  Future<void> setMusic(bool value) async {
    if (value) {
      await _player.play(AssetSource('music.mp3'));
      _player.setReleaseMode(ReleaseMode.loop);
      getMusic = true;
    } else {
      await _player.stop();
      getMusic = false;
    }
    notifyListeners();
  }

  //--------------------------------------------------------------------------------------------
  var getNotification = false;

  Future<void> setNotification(bool value) async {
    if (value) {
      await _playerNotif.play(AssetSource('ye.mp3'));
      _playerNotif.setReleaseMode(ReleaseMode.stop);
      getNotification = true;
    } else {
      await _playerNotif.stop();
      getNotification = false;
    }
    notifyListeners();
  }
//--------------------------------------------------------------------------------------------

// context.watch<CounterProvider>().getScore
// context.read<CounterProvider>().setScore(value:)
}

/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onet_dental/model/game_model.dart';

class GameService {
  static Future<void> add(GameModel game) async {
    await FirebaseFirestore.instance.collection('game').add(game.toJson());
  }

  static Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('game').doc(id).delete();
  }

  static Future<void> edit({
    required String id,
    required String uid,
    required DateTime? date,
    required int score,
    required bool complite,
  }) async {
    final docRef = FirebaseFirestore.instance.collection('game').doc(id);

    final updates = <String, dynamic>{
      'uid': uid,
      'date': date?.toIso8601String(),
      'score': score,
      'complite': complite,
    };

    await docRef.update(updates);
  }
}
*/

import 'package:onet_dental/database/db_service.dart';
import 'package:onet_dental/model/game_model.dart';
import 'package:sqflite/sqflite.dart';

class GameDB {
  final tableName = 'game';

  Future<void> createTable(Database database) async {
    await database.execute('''CREATE TABLE IF NOT EXISTS $tableName (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "date" INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
      "score" INTEGER NOT NULL,
      "complete" INTEGER NOT NULL
      )''');
  }

  Future<int> create({required int score, required bool complete}) async {
    final database = await DbService().database;
    return await database.rawInsert(
      '''INSERT INTO $tableName (date, score, complete) VALUES (?, ?, ?)''',
      [DateTime.now().millisecondsSinceEpoch ~/ 1000, score, complete ? 1 : 0],
    );
  }

  Future<List<GameModel>> fetchAll() async {
    final database = await DbService().database;
    final games = await database.rawQuery('''SELECT * FROM $tableName ORDER BY date''');
    return games.map((game) => GameModel.fromMap(game)).toList().cast<GameModel>();
  }

  Future<GameModel?> fetchById(int id) async {
    final database = await DbService().database;
    final results = await database.rawQuery('''SELECT * FROM $tableName WHERE id = ?''', [id]);

    if (results.isNotEmpty) {
      return GameModel.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<int> update({required int id, required int newScore, required bool newComplete}) async {
    final database = await DbService().database;
    return await database.update(
      tableName,
      {
        'date': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        'score': newScore,
        'complete': newComplete ? 1 : 0,
      },
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> delete(int id) async {
    final database = await DbService().database;
    return await database.rawDelete('''DELETE FROM $tableName WHERE id = ?''', [id]);
  }
}

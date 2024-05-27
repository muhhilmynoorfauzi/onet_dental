class GameModel {
  int id;
  DateTime date;
  int score;
  bool complete;

  GameModel({
    required this.id,
    required this.date,
    required this.score,
    required this.complete,
  });

  // Metode tambahan untuk konversi dari dan ke map (untuk penyimpanan ke SQLite)
  factory GameModel.fromMap(Map<String, dynamic> map) {
    return GameModel(
      id: map['id'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] * 1000),
      score: map['score'],
      complete: map['complete'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.millisecondsSinceEpoch ~/ 1000,
      'score': score,
      'complete': complete ? 1 : 0,
    };
  }
}

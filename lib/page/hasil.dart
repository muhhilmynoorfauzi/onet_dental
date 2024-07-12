import 'package:flutter/material.dart';
import 'package:onet_dental/component/transition.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/page/games/page_game.dart';

import '../database/game_db.dart';

class HasilPage extends StatelessWidget {
  final int idContinue;
  final int score;

  HasilPage({required this.score, required this.idContinue});

  final GameDB _gameDB = GameDB();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: primary,
        body: Container(
          alignment: Alignment.center,
          height: tinggi(context),
          width: lebar(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg_hasil.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Good Job', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Colors.white)),
              Container(
                width: 300,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Score Anda $score ', style: const TextStyle(fontSize: 20)),
                    const Icon(Icons.emoji_events, color: Colors.orange, size: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
        extendBody: true,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 60,
          width: lebar(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton(
                style: TextButton.styleFrom(side: const BorderSide(color: Colors.white)),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali ke Home', style: TextStyle(color: Colors.white)),
              ),
              OutlinedButton(
                style: TextButton.styleFrom(side: const BorderSide(color: Colors.white)),
                onPressed: () async {
                  if (idContinue == 0) {
                    await _gameDB.create(score: score, complete: true);
                  } else {
                    await _gameDB.update(id: idContinue, newScore: score, newComplete: true);
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      content: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: Text('Data berhasil disimpan!', style: TextStyle(color: primary)),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
              OutlinedButton(
                style: TextButton.styleFrom(side: const BorderSide(color: Colors.white)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    SlideTransition1(PageGame(colRow: 4, timeLong: 10, level: 1, idContinue: 0, score: 0)),
                  );
                },
                child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

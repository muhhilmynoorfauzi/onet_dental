import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:onet_dental/component/transition.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/database/game_db.dart';
import 'package:onet_dental/model/game_model.dart';
import 'package:onet_dental/page/games/page_game.dart';

class ContinuePage extends StatefulWidget {
  const ContinuePage({Key? key}) : super(key: key);

  @override
  State<ContinuePage> createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
  List<GameModel> completedGames = [];

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  void fetchGames() async {
    final gamesFromDB = await GameDB().fetchAll();
    setState(() => completedGames = gamesFromDB.where((game) => !game.complete).toList());
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy \'pukul\' HH:mm');
    return formatter.format(dateTime);
  }

  void deleteGame(int id) async {
    final gameDB = GameDB();
    await gameDB.delete(id);
    fetchGames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: primary,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.navigate_before_rounded, color: Colors.white, size: 30),
        ),
        title: const Text('Continue', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: (completedGames.isNotEmpty)
          ? Center(
              child: ListView.builder(
                itemCount: completedGames.length,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                itemBuilder: (context, index) {
                  final game = completedGames[index];
                  return Container(
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 10, top: 5),
                    width: lebar(context) / 2,
                    child: Card(
                      color: Colors.green,
                      margin: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(formatDateTime(game.date)),
                                  Text(game.score.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              if (game.score == 0) {
                                Navigator.pushReplacement(
                                  context,
                                  SlideTransition1(
                                    PageGame(colRow: 4, timeLong: 10, level: 1, idContinue: game.id, score: 0),
                                  ),
                                );
                              } else if (game.score == 20) {
                                Navigator.pushReplacement(
                                  context,
                                  SlideTransition1(
                                    PageGame(colRow: 8, timeLong: 15, level: 2, idContinue: game.id, score: 20),
                                  ),
                                );
                              } else if (game.score == 40) {
                                Navigator.pushReplacement(
                                  context,
                                  SlideTransition1(
                                    PageGame(colRow: 10, timeLong: 20, level: 3, idContinue: game.id, score: 40),
                                  ),
                                );
                              } else if (game.score == 60) {
                                Navigator.pushReplacement(
                                  context,
                                  SlideTransition1(
                                    PageGame(colRow: 12, timeLong: 25, level: 4, idContinue: game.id, score: 60),
                                  ),
                                );
                              } else if (game.score == 80) {
                                Navigator.pushReplacement(
                                  context,
                                  SlideTransition1(
                                    PageGame(colRow: 12, timeLong: 30, level: 5, idContinue: game.id, score: 80),
                                  ),
                                );
                              }
                            },
                            child: const Text('Lanjutkan', style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(
              child: SizedBox(
                height: tinggi(context),
                width: lebar(context) / 2,
                // color: Colors.red,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(30),
                      child: Text('Tidak Ada data simpanan'),
                    ),
                    Expanded(child: Image.asset('assets/bingung.jpeg'))
                  ],
                ),
              ),
            ),
    );
  }
}

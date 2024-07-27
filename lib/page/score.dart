import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:onet_dental/component/transition.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/database/game_db.dart';
import 'package:onet_dental/model/game_model.dart';
import 'package:onet_dental/page/examples/example2.dart';

class ScorePage extends StatefulWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  State<ScorePage> createState() => _ScorePageState();
}

class _ScorePageState extends State<ScorePage> {
  List<GameModel> completedGames = [];

  @override
  void initState() {
    super.initState();
    fetchGames();
  }

  void fetchGames() async {
    final allGames = await GameDB().fetchAll();
    setState(() => completedGames = allGames.where((game) => game.complete).toList());
  }

  String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy \'pukul\' HH:mm');
    return formatter.format(dateTime);
  }

  void deleteGame(int id) async {
    final gameDB = GameDB();
    await gameDB.delete(id);
    fetchGames(); // Refresh the list after deletion
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
        title: const Text('Score', style: TextStyle(color: Colors.white)),
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
                      color: Colors.grey,
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
                          IconButton(
                            onPressed: () => deleteGame(game.id),
                            icon: const Icon(Icons.delete, color: Colors.white),
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
                    Expanded(
                      child: Image.asset('assets/bingung.png'),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze/maze.dart';
import 'package:onet_dental/component/state_manajement.dart';
import 'package:onet_dental/component/transition.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/database/game_db.dart';
import 'package:onet_dental/model/game_model.dart';
import 'package:onet_dental/page/hasil.dart';
import 'package:provider/provider.dart';

class PageGame extends StatefulWidget {
  final int idContinue;
  final int level;
  final int colRow;
  final int timeLong;
  final int score;

  PageGame({required this.colRow, required this.timeLong, required this.level, required this.idContinue, required this.score});

  @override
  State<PageGame> createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {
  double? timer = 0;
  // bool timeOut = false;
  bool selesai = false;
  final GameDB _gameDB = GameDB();
  var edu = '';

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1), () => setState(() => timer = 400));
  }

  @override
  void initState() {
    delay();
    switch (widget.level) {
      case 1:
        edu = 'assets/level1.png';
      case 2:
        edu = 'assets/level2.png';
      case 3:
        edu = 'assets/level3.png';
      case 4:
        edu = 'assets/level4.png';
      case 5:
        edu = 'assets/level5.png';
    }
    super.initState();
  }

  Future dialog({List<Widget>? actions, required String assetName, Widget? title}) => showDialog(
        context: context,
        builder: (context) => SlideFadeTransition(
          curve: Curves.elasticOut,
          delayStart: const Duration(milliseconds: 200),
          animationDuration: const Duration(milliseconds: 1500),
          offset: 2.5,
          direction: Direction.vertical,
          child: AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              content: Container(
                width: lebar(context) / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(assetName)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              title: title,
              actionsPadding: const EdgeInsets.all(10),
              contentPadding: EdgeInsets.zero,
              actions: actions),
        ),
      );

  Widget actionButton({required Widget title, required VoidCallback task}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 35,
      width: 120,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          side: const BorderSide(color: Colors.white),
          foregroundColor: Colors.white,
        ),
        onPressed: task,
        child: title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final music = context.watch<CounterProvider>().getMusic;
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: primary,
        body: SafeArea(
          child: Center(
            child: Row(
              children: [
                SizedBox(
                  height: tinggi(context),
                  width: 150,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        'Level ${widget.level}',
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Score :${widget.score}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      actionButton(
                        title: const Text('Home'),
                        task: () {
                          dialog(
                            assetName: 'assets/player.png',
                            title: const Text(
                              'Kembali ke Home dan simpan?',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  if (widget.idContinue == 0) {
                                    await _gameDB.create(score: widget.score, complete: false);
                                  } else {
                                    await _gameDB.update(id: widget.idContinue, newScore: widget.score, newComplete: false);
                                  }
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Ya'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: const Text('Tidak'),
                              ),
                              TextButton(onPressed: () => Navigator.pop(context), child: const Text('batal')),
                            ],
                          );
                        },
                      ),
                      actionButton(
                        title: Icon((music) ? Icons.music_note_rounded : Icons.music_off_outlined),
                        task: () {
                          if (music) {
                            context.read<CounterProvider>().setMusic(false);
                          } else {
                            context.read<CounterProvider>().setMusic(true);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      if (!selesai)
                        Column(
                          children: [
                            const Text('Timer', style: TextStyle(color: Colors.white)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 400,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: AnimatedContainer(
                                    duration: Duration(seconds: widget.timeLong),
                                    onEnd: () {
                                      Navigator.pushReplacement(
                                        context,
                                        SlideTransition1(HasilPage(score: widget.score, idContinue: widget.idContinue)),
                                      );
                                      // setState(() => timeOut = true);
                                    },
                                    height: 5,
                                    width: timer,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                                  ),
                                ),
                                Text(' ${widget.timeLong} Detik', style: const TextStyle(color: Colors.white, fontSize: 12)),
                              ],
                            )
                          ],
                        ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: tinggi(context),
                              alignment: Alignment.center,
                              // color: Colors.red,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: tinggi(context),
                                    child: Maze(
                                      player: MazeItem('assets/player.png', ImageType.asset),
                                      columns: widget.colRow,
                                      rows: widget.colRow,
                                      wallThickness: 5,
                                      wallColor: Colors.white,
                                      finish: MazeItem('assets/finish.png', ImageType.asset),
                                      onFinish: () {
                                        context.read<CounterProvider>().setNotification(true);
                                        if (widget.level == 5) {
                                          Navigator.pushReplacement(
                                            context,
                                            SlideTransition1(
                                              HasilPage(score: widget.score + 20, idContinue: widget.idContinue),
                                            ),
                                          );
                                        } else {
                                          setState(() => selesai = true);
                                          dialog(assetName: edu, actions: [
                                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Oke')),
                                          ]);
                                        }
                                      },
                                    ),
                                  ),
                                  if (selesai)
                                    actionButton(
                                      title: const Text('Lanjutkan'),
                                      task: () {
                                        Navigator.pushReplacement(
                                          context,
                                          SlideTransition1(
                                            PageGame(
                                              colRow: widget.colRow + 2,
                                              timeLong: widget.timeLong + 5,
                                              level: widget.level + 1,
                                              idContinue: widget.idContinue,
                                              score: widget.score + 20,
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                ],
                              ),
                            ),
                            /*if (timeOut)
                              Container(
                                color: primary,
                                height: tinggi(context),
                                alignment: Alignment.center,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    'Waktu Anda Habis',
                                    style: TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                ),
                              ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

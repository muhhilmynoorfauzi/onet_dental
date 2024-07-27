import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:maze/maze.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
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

  ScrollController controller = ScrollController();
  bool selesai = false;
  final GameDB _gameDB = GameDB();
  var asset3D = '';
  var asset3D1 = '';
  var txt = '';

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 1), () => setState(() => timer = 400));
  }

  @override
  void initState() {
    delay();
    switch (widget.level) {
      case 1:
        asset3D = 'assets/cara_sikat_gigi.png';
        asset3D1 = 'assets/gerakan_sikat.glb';
        txt = 'Flouride, menyikat gigi 2 kali sehari';
      case 2:
        asset3D = 'assets/makanan_manis.png';
        asset3D1 = 'assets/menempel_digigi.glb';
        txt = 'Makanan dan minuman manis membuat gigi rusak';
      case 3:
        asset3D = 'assets/gusi_bengkak.glb';
        txt = 'Jarang membersihkan gigi dan mulut';
      case 4:
        asset3D = 'assets/bau_mulut.glb';
        txt = 'Tidak menjaga kebersihkan gigi dan mulut';
      case 5:
        asset3D = 'assets/gigi_sehat.glb';
        txt = 'Rutin ke dokter gigi 6 bulan sekali';
    }
    super.initState();
  }

  Future dialog({List<Widget>? actions, Widget? asset, Widget? title}) => showDialog(
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
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: lebar(context) / 2,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: (asset != null) ? asset : const SizedBox(),
            ),
            title: title,
            actionsPadding: const EdgeInsets.all(10),
            actions: actions,
          ),
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
                                      finish: MazeItem(
                                        'assets/finish.png',
                                        ImageType.asset,
                                      ),
                                      onFinish: () async {
                                        context.read<CounterProvider>().setNotification(true);
                                        setState(() => selesai = true);
                                        await dialog(
                                          title: Text(
                                            txt,
                                            style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                          ),
                                          asset: (widget.level == 1 || widget.level == 2)
                                              ? SingleChildScrollView(
                                                  controller: controller,
                                                  scrollDirection: Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: lebar(context) / 2,
                                                        child: ModelViewer(
                                                          backgroundColor: Colors.transparent,
                                                          src: asset3D1,
                                                          disableZoom: false,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: lebar(context) / 2,
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 20),
                                                          child: Image.asset(asset3D),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : ModelViewer(
                                                  backgroundColor: Colors.transparent,
                                                  src: asset3D,
                                                  disableZoom: false,
                                                ),
                                          actions: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                if (widget.level == 1 || widget.level == 2)
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        IconButton(
                                                          onPressed: () => controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut),
                                                          icon: const Icon(Icons.navigate_before_rounded, color: Colors.black),
                                                        ),
                                                        IconButton(
                                                          onPressed: () {
                                                            controller.animateTo(lebar(context) / 2, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                                                          },
                                                          icon: const Icon(Icons.navigate_next_rounded, color: Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: const Text('Oke'),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                        if (widget.level == 5) {
                                          Navigator.pushReplacement(
                                            context,
                                            SlideTransition1(
                                              HasilPage(score: widget.score + 20, idContinue: widget.idContinue),
                                            ),
                                          );
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

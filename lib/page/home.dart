import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:onet_dental/component/state_manajement.dart';
import 'package:onet_dental/component/transition.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/page/continue.dart';
import 'package:onet_dental/page/games/page_game.dart';
import 'package:onet_dental/page/score.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(systemStatusBarContrastEnforced: true));
    context.read<CounterProvider>().setMusic(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return onMo(context);
  }

  Widget onMo(BuildContext context) {
    final music = context.watch<CounterProvider>().getMusic;
    return PopScope(
      onPopInvoked: (didPop) async => context.read<CounterProvider>().setMusic(false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () async {
              if (music) {
                context.read<CounterProvider>().setMusic(false);
              } else {
                context.read<CounterProvider>().setMusic(true);
              }
            },
            icon: Icon(music ? Icons.music_note_rounded : Icons.music_off_rounded, color: Colors.black),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Row(
          children: [
            const SizedBox(width: 50),
            Container(
              height: tinggi(context),
              width: tinggi(context),
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/w1.jpg'), fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                height: tinggi(context) * .7,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.5),
                      blurRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Little Mazedent',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        SlideTransition1(PageGame(colRow: 4, timeLong: 10, level: 1, idContinue: 0, score: 0)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 200,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text('New Game', style: TextStyle(color: primary)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Navigator.push(context, SlideTransition1(const ContinuePage())),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 200,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: Text('Continue', style: TextStyle(color: primary)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, SlideTransition1(const ScorePage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                        ),
                        child: const Text('Score', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

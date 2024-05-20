import 'package:flutter/material.dart';
import 'package:onet_dental/component/util.dart';

class Score extends StatefulWidget {
  const Score({super.key});

  @override
  State<Score> createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  var onReset = false;

  @override
  Widget build(BuildContext context) {
    return onMo(context);
  }

  Widget onMo(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.navigate_before_rounded, color: Colors.white, size: 30),
        ),
        title: const Text('Score', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () async {
                // onLoading = true;
                onReset = !onReset;
                // await Future.delayed(const Duration(seconds: 1), () => onLoading = false);

                setState(() {});
              },
              child: const Text('Reset')),
          const SizedBox(width: 10),
        ],
        backgroundColor: primary,
      ),
      body: Center(
        child: onReset
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.history, color: Colors.black, size: 100),
                  Text('Tidak Ada Riwayat'),
                ],
              )
            : Container(
                height: tinggi(context),

                child: ListView.builder(
                  itemCount: 7,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                      width: lebar(context) / 2,
                      child: const Card(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('20:21, 12/03/2024'),
                              Text('90', style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }
}

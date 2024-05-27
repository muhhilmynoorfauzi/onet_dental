// import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onet_dental/component/util.dart';

class Download extends StatelessWidget {
  const Download({super.key});

  final String urlDownload = 'https://storage.googleapis.com/onet-dental-5503c.appspot.com/apk/nurul.apk';
  final String urlImage =
      'https://firebasestorage.googleapis.com/v0/b/onet-dental-5503c.appspot.com/o/assets%2Fbg_download.png?alt=media&token=188f652a-2b89-4b4d-8954-9596b233df88';

  void download() {
    // html.window.open(urlDownload, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          (lebar(context) < 800)
              ? SizedBox(
                  width: lebar(context),
                  height: tinggi(context),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          child: Image.network(urlImage, width: lebar(context) - 50),
                        ),
                      ),
                      Container(
                        height: 300,
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Selamat datang di \nMaze Game for Nurul', style: GoogleFonts.poppins(color: primary, fontSize: 30), textAlign: TextAlign.center),
                            const SizedBox(height: 20),
                            TextButton.icon(
                              style: TextButton.styleFrom(backgroundColor: primary, padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                              onPressed: () => download(),
                              label: Text('Get App for Android', style: GoogleFonts.poppins(color: Colors.white, fontSize: 20)),
                              icon: const Icon(Icons.android, color: Colors.white, size: 40),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  width: lebar(context),
                  height: tinggi(context),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Image.network(urlImage, height: tinggi(context) - 100),
                      ),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Selamat datang di \nMaze Game for Nurul', style: GoogleFonts.poppins(color: primary, fontSize: 50)),
                              const SizedBox(height: 20),
                              TextButton.icon(
                                style: TextButton.styleFrom(backgroundColor: primary, padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20)),
                                onPressed: () => download(),
                                label: Text('Get App for Android', style: GoogleFonts.poppins(color: Colors.white, fontSize: 30)),
                                icon: const Icon(Icons.android, color: Colors.white, size: 50),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}

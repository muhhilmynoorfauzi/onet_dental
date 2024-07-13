import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onet_dental/component/state_manajement.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/firebase_options.dart';
import 'package:onet_dental/page/examples/download.dart';
import 'package:onet_dental/page/examples/example2.dart';
import 'package:onet_dental/page/games/page_game.dart';
import 'package:onet_dental/page/hasil.dart';
import 'package:onet_dental/page/home.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations([
    // DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CounterProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Little Mazedent',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
      ),
      home:
          // const Example2(),
          const Home(),
          // PageGame(colRow: 2, timeLong: 100, level: 2, idContinue: 0, score: 0),
      // const Download(),
    );
  }
}

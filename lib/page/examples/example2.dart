import 'package:flutter/material.dart';
import 'package:onet_dental/component/util.dart';
import 'package:onet_dental/database/game_db.dart';

class AddScorePage extends StatefulWidget {
  const AddScorePage({Key? key}) : super(key: key);

  @override
  State<AddScorePage> createState() => _AddScorePageState();
}

class _AddScorePageState extends State<AddScorePage> {
  final TextEditingController _scoreController = TextEditingController();
  bool? _selectedComplete;
  final GameDB _gameDB = GameDB();

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
        title: const Text('Add Score', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _scoreController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Score',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<bool>(
              value: _selectedComplete,
              onChanged: (bool? value) {
                setState(() => _selectedComplete = value);
              },
              items: const [
                DropdownMenuItem<bool>(
                  value: true,
                  child: Text('True'),
                ),
                DropdownMenuItem<bool>(
                  value: false,
                  child: Text('False'),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Complete',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final int score = int.tryParse(_scoreController.text) ?? 0;
                final bool complete = _selectedComplete ?? false;
                await _gameDB.create(score: score, complete: complete);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Data berhasil disimpan!'),
                  ),
                );
                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }
}

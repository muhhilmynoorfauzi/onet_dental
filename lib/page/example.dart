import 'dart:math';
import 'package:flutter/material.dart';

class OnetScreen extends StatefulWidget {
  @override
  _OnetScreenState createState() => _OnetScreenState();
}

class _OnetScreenState extends State<OnetScreen> {
  final int rows = 4;
  final int cols = 4;
  List<List<int>> grid = [];
  int selectedRow = -1;
  int selectedCol = -1;

  @override
  void initState() {
    super.initState();
    initializeGrid();
  }

  void initializeGrid() {
    grid = List.generate(rows, (_) => List.generate(cols, (_) => Random().nextInt(3) + 1));

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        if (grid[row][col] == 0) {
          grid[row][col] = Random().nextInt(3) + 1;
        }
      }
    }
  }

  void onTileTap(int row, int col) {
    setState(() {
      if (selectedRow == -1 && selectedCol == -1) {
        selectedRow = row;
        selectedCol = col;
      } else {
        if (grid[selectedRow][selectedCol] == grid[row][col] && (selectedRow != row || selectedCol != col)) {
          grid[selectedRow][selectedCol] = 0;
          grid[row][col] = 0;
        }
        selectedRow = -1;
        selectedCol = -1;
      }
    });
  }

  bool isValidConnection(int firstRow, int firstCol, int secondRow, int secondCol) {
    if (firstRow == secondRow || firstCol == secondCol) {
      return isStraightConnection(firstRow, firstCol, secondRow, secondCol);
    } else {
      return isTwoTurnsConnection(firstRow, firstCol, secondRow, secondCol);
    }
  }

  bool isStraightConnection(int firstRow, int firstCol, int secondRow, int secondCol) {
    if (firstRow == secondRow) {
      int minCol = firstCol < secondCol ? firstCol : secondCol;
      int maxCol = firstCol > secondCol ? firstCol : secondCol;
      for (int col = minCol + 1; col < maxCol; col++) {
        if (grid[firstRow][col] != 0) {
          return false;
        }
      }
      return true;
    } else if (firstCol == secondCol) {
      int minRow = firstRow < secondRow ? firstRow : secondRow;
      int maxRow = firstRow > secondRow ? firstRow : secondRow;
      for (int row = minRow + 1; row < maxRow; row++) {
        if (grid[row][firstCol] != 0) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  bool isTwoTurnsConnection(int firstRow, int firstCol, int secondRow, int secondCol) {
    if (isStraightConnection(firstRow, firstCol, secondRow, firstCol) && isStraightConnection(secondRow, firstCol, secondRow, secondCol)) {
      return true;
    }
    if (isStraightConnection(firstRow, firstCol, firstRow, secondCol) && isStraightConnection(firstRow, secondCol, secondRow, secondCol)) {
      return true;
    }
    return false;
  }

  Widget buildTile(int row, int col) {
    return GestureDetector(
      onTap: () {
        if (grid[row][col] != 0) {
          onTileTap(row, col);
        }
      },
      child: Container(
        color: selectedRow == row && selectedCol == col ? Colors.red : Colors.grey,
        margin: const EdgeInsets.all(2),
        child: Center(
          child: Text(
            grid[row][col].toString(),
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onet Game'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: rows * cols,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ cols;
          int col = index % cols;
          return buildTile(row, col);
        },
      ),
    );
  }
}

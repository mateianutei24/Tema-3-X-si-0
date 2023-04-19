import 'dart:developer';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> _colors = List<Color>.filled(9, Colors.white);

  int _turn = 1;
  bool _gameEnded = false;

  bool hasWon(List<Color> colors) {
    log(colors.toString());
    for (int i = 0; i < 3; i++) {
      if (colors[i] == colors[i + 3] &&
          colors[i] == colors[i + 6] &&
          colors[i + 3] == colors[i + 6] &&
          colors[i] != Colors.white) {
        return true;
      }
      if (colors[i * 2 + i] == colors[i * 2 + i + 1] &&
          colors[i * 2 + i] == colors[i * 2 + i + 2] &&
          colors[i * 2 + i + 1] == colors[i * 2 + i + 2] &&
          colors[i * 2 + i] != Colors.white) {
        return true;
      }
    }
    if (colors[0] == colors[4] && colors[0] == colors[8] && colors[4] == colors[8] && colors[0] != Colors.white) {
      return true;
    }
    if (colors[2] == colors[4] && colors[2] == colors[6] && colors[4] == colors[6] && colors[2] != Colors.white) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('X&0'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GridView.builder(
                itemCount: 9,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!_gameEnded) {
                          if (_colors[index] == Colors.white) {
                            if (_turn.isOdd) {
                              _colors[index] = Colors.red;
                            } else {
                              _colors[index] = Colors.green;
                            }

                            _turn++;
                          }

                          _gameEnded = hasWon(_colors);
                          if (_turn == 10) {
                            _gameEnded = true;
                          }
                        }
                      });
                    },
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: _colors[index],
                        border: Border.all(),
                      ),
                    ),
                  );
                }),
          ),
          if (_gameEnded)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _gameEnded = false;
                    _colors = List<Color>.filled(9, Colors.white);
                    _turn = 1;
                  });
                },
                child: const Text('Play again'),
              ),
            ),
        ],
      ),
    );
  }
}

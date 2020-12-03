import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.orange[100],
        appBarTheme: const AppBarTheme(color: Colors.red),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<int> _player1Boxes = <int>[];
  final List<int> _player2Boxes = <int>[];

  String _text = 'Player\'s 1 turn';

  bool player2Turn = false;
  bool existsWinner = false;

  final Color _player1Color = Colors.black;
  final Color _player2Color = Colors.red;

  void checkWinner() {
    if ((_player1Boxes.contains(0) && _player1Boxes.contains(1) && _player1Boxes.contains(2)) ||
        (_player1Boxes.contains(3) && _player1Boxes.contains(4) && _player1Boxes.contains(5)) ||
        (_player1Boxes.contains(6) && _player1Boxes.contains(7) && _player1Boxes.contains(8))) {
      _text = 'Winner is Player 1';
      existsWinner = true;
    }

    if ((_player1Boxes.contains(0) && _player1Boxes.contains(3) && _player1Boxes.contains(6)) ||
        (_player1Boxes.contains(1) && _player1Boxes.contains(4) && _player1Boxes.contains(7)) ||
        (_player1Boxes.contains(2) && _player1Boxes.contains(5) && _player1Boxes.contains(8))) {
      _text = 'Winner is Player 1';
      existsWinner = true;
    }

    if ((_player1Boxes.contains(0) && _player1Boxes.contains(4) && _player1Boxes.contains(8)) ||
        (_player1Boxes.contains(2) && _player1Boxes.contains(4) && _player1Boxes.contains(6))) {
      _text = 'Winner is Player 1';
      existsWinner = true;
    }

    if ((_player2Boxes.contains(0) && _player2Boxes.contains(1) && _player2Boxes.contains(2)) ||
        (_player2Boxes.contains(3) && _player2Boxes.contains(4) && _player2Boxes.contains(5)) ||
        (_player2Boxes.contains(6) && _player2Boxes.contains(7) && _player2Boxes.contains(8))) {
      _text = 'Winner is Player 2';
      existsWinner = true;
    }

    if ((_player2Boxes.contains(0) && _player2Boxes.contains(3) && _player2Boxes.contains(6)) ||
        (_player2Boxes.contains(1) && _player2Boxes.contains(4) && _player2Boxes.contains(7)) ||
        (_player2Boxes.contains(2) && _player2Boxes.contains(5) && _player2Boxes.contains(8))) {
      _text = 'Winner is Player 2';
      existsWinner = true;
    }

    if ((_player2Boxes.contains(0) && _player2Boxes.contains(4) && _player2Boxes.contains(8)) ||
        (_player2Boxes.contains(2) && _player2Boxes.contains(4) && _player2Boxes.contains(6))) {
      _text = 'Winner is Player 2';
      existsWinner = true;
    }

    if (_player1Boxes.length + _player2Boxes.length == 9 && existsWinner == false) {
      _text = 'DRAW';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              _text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Poppins',
                color: Colors.yellow[800],
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                crossAxisCount: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (!existsWinner) {
                      setState(() {
                        if (!_player1Boxes.contains(index) && !_player2Boxes.contains(index)) {
                          if (!player2Turn) {
                            _player1Boxes.add(index);
                            _text = 'Player\'s 2 turn';
                            player2Turn = !player2Turn;
                          } else {
                            _player2Boxes.add(index);
                            _text = 'Player\'s 1 turn';
                            player2Turn = !player2Turn;
                          }
                        }
                        checkWinner();
                        if (existsWinner) {
                          showDialog<AlertDialog>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Congrats',
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.yellow[800],
                                  ),
                                  content: Text(
                                    _text,
                                    textAlign: TextAlign.center,
                                  ),
                                  contentTextStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.yellow[800],
                                  ),
                                  actions: <Widget>[
                                    RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          _player1Boxes.clear();
                                          _player2Boxes.clear();
                                          existsWinner = false;
                                          _text = 'Player\'s 1 turn';
                                          player2Turn = false;
                                          Navigator.of(context).pop();
                                        });
                                      },
                                      color: Colors.red,
                                      child: const Text(
                                        'Ok',
                                        style:
                                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }
                      });
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    height: 100.0,
                    width: 100.0,
                    color: _player1Boxes.contains(index)
                        ? _player1Color
                        : _player2Boxes.contains(index)
                            ? _player2Color
                            : Colors.grey,
                    child: Center(
                      child: Text(
                        _player1Boxes.contains(index)
                            ? 'X'
                            : _player2Boxes.contains(index)
                                ? 'O'
                                : '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24.0),
          RaisedButton(
            color: Colors.red,
            onPressed: () {
              setState(() {
                _player1Boxes.clear();
                _player2Boxes.clear();
                player2Turn = false;
                _text = 'Player\'s 1 turn';
                existsWinner = false;
              });
            },
            child: const Text(
              'Reset',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                fontFamily: 'Poppins',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _myRandomNumber = Random().nextInt(100) + 1;
  int _usedHints = 0;
  int _currentTry = 0;

  String _errorMessage;
  String _userInput = '';
  String _hintMessage = '';
  String _previousUserInput = '';
  String _responseMessage = '';

  final Random _random = Random();
  final TextEditingController _controller = TextEditingController();

  static const int _MAXIMUM_NUMBER_OF_HINTS = 3;
  static const int _MAXIMUM_NUMBER_OF_TRIES = 10;

  bool _giveMeAHint = false;
  bool _showResponse = false;
  bool _enableTextField = true;
  bool _enableRestart = false;

  bool _isValidInput(String input) {
    if (input == null) {
      return false;
    }

    if (input.isEmpty) {
      return false;
    }

    if (input[0] == '0' && input.length > 1) {
      return false;
    }
    final int intInput = int.tryParse(input);
    if (intInput < 1 || intInput > 100 || intInput == null) {
      return false;
    }
    return true;
  }

  void _setErrorMessage(String input) {
    if (input.isEmpty || input == null) {
      _errorMessage = 'This filed could not be empty.';
      return;
    }
    if (input[0] == '0' && input.length > 1) {
      _errorMessage = 'A valid number could not start with 0';
      return;
    }
    final int inputToInt = int.tryParse(input);
    if (inputToInt < 1 || inputToInt > 100) {
      _errorMessage = 'Your number must be a number between 1 and 100.';
      return;
    }
    _errorMessage = null;
  }

  dynamic createAlertDialog(BuildContext context) {
    return showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Congrats',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            content: Text(
              'It was $_previousUserInput',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24,
                color: Colors.green[800],
              ),
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.blue[100],
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  child: const Text(
                    'Try Again',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[900],
                  onPressed: () {
                    setState(() {
                      _showResponse = false;
                      _giveMeAHint = false;
                      _usedHints = 0;
                      _currentTry = 0;
                      _myRandomNumber = _random.nextInt(100) + 1;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: RaisedButton(
                  child: const Text(
                    'Ok',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  color: Colors.blue[900],
                  onPressed: () {
                    setState(() {
                      _enableTextField = false;
                      _enableRestart = true;
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://previews.123rf.com/images/z_i_b_i/z_i_b_i1010/z_i_b_i101000059/8102784-numbers-background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'I\'m thinking of a number between 1 and 100',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'It\'s your turn to guess my number!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (_showResponse) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _responseMessage,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                if (_giveMeAHint) ...<Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _hintMessage,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: Colors.grey[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
                Container(
                  height: 225,
                  width: 375,
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 10,
                    margin: const EdgeInsets.all(10),
                    color: Colors.blue[100],
                    child: Column(
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Try a number',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            enabled: _enableTextField,
                            controller: _controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Please insert a number',
                              errorText: _errorMessage,
                            ),
                            keyboardType: const TextInputType.numberWithOptions(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            onChanged: (String input) {
                              setState(() {
                                _userInput = input;
                              });
                            },
                          ),
                        ),
                        if (!_enableRestart) ...<Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                RaisedButton(
                                  child: const Text(
                                    'Guess',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    ),
                                  ),
                                  color: Colors.blue[900],
                                  onPressed: () {
                                    print(_myRandomNumber);
                                    setState(() {
                                      _setErrorMessage(_userInput);
                                      if (_isValidInput(_userInput)) {
                                        if (_currentTry < _MAXIMUM_NUMBER_OF_TRIES) {
                                          _previousUserInput = _userInput;
                                          _responseMessage = 'You tried $_userInput';
                                          _currentTry++;
                                          if (_myRandomNumber == int.tryParse(_userInput)) {
                                            _hintMessage = 'You guessed right, congrats!';
                                            _giveMeAHint = true;
                                            _showResponse = true;
                                            createAlertDialog(context);
                                          } else {
                                            _giveMeAHint = false;
                                          }
                                        } else {
                                          _responseMessage = 'You dindn\'t guess the number, please try again...';
                                          _enableTextField = false;
                                          _giveMeAHint = false;
                                          _enableRestart = true;
                                        }
                                        _showResponse = true;
                                        _controller.clear();
                                        _userInput = '';
                                      }
                                    });
                                  },
                                ),
                                FloatingActionButton(
                                  child: Icon(
                                    Icons.lightbulb,
                                    color: Colors.amber[800],
                                  ),
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  onPressed: () {
                                    setState(() {
                                      if (_usedHints < _MAXIMUM_NUMBER_OF_HINTS) {
                                        if (_myRandomNumber < int.tryParse(_previousUserInput)) {
                                          _hintMessage = 'Try lower';
                                        } else if (_myRandomNumber > int.tryParse(_previousUserInput)) {
                                          _hintMessage = 'Try higher';
                                        }
                                        _usedHints++;
                                      } else {
                                        _hintMessage = 'No more hints available';
                                      }
                                      _giveMeAHint = true;
                                      _controller.clear();
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                        ] else ...<Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(100, 30, 100, 0),
                            child: RaisedButton(
                              color: Colors.red[400],
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Restart',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    CupertinoIcons.restart,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              onPressed: () {
                                _currentTry = 0;
                                _usedHints = 0;
                                _myRandomNumber = _random.nextInt(100) + 1;
                                setState(() {
                                  _enableTextField = true;
                                  _showResponse = false;
                                  _giveMeAHint = false;
                                  _enableRestart = false;
                                });
                              },
                            ),
                          ),
                        ],
                      ],
                    ),
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

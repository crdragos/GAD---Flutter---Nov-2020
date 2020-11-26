import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  String _errorMessage;
  String _previousUserInput;
  String _userInput;
  String _responseMessage = '';

  final TextEditingController _controller = TextEditingController();

  bool _isValidInput(String input) {
    if (input == null || input.isEmpty) {
      _errorMessage = 'This field could not be empty';
      return false;
    }

    if (input[0] == '0' && input.length != 1) {
      _errorMessage = 'A valid number can\'t start with 0';
      return false;
    }

    _errorMessage = null;
    return true;
  }

  bool _isSquareNumber(int number) {
    return sqrt(number) == sqrt(number).truncate();
  }

  bool _isCubeNumber(int number) {
    final int cubeRoot = pow(number, 1 / 3).round();

    return cubeRoot * cubeRoot * cubeRoot == number;
  }

  void _setResponseMessage(int input) {
    if (_isSquareNumber(input) && _isCubeNumber(input)) {
      _responseMessage = input.toString() + ' is both Square and Triangular Number';
      return;
    }

    if (_isSquareNumber(input)) {
      _responseMessage = input.toString() + ' is a Square Number';
      return;
    }

    if (_isCubeNumber(input)) {
      _responseMessage = input.toString() + ' is a Triangular Number';
      return;
    }

    _responseMessage = input.toString() + ' is neither Square or Triangular Number';
    return;
  }

  dynamic _createAlertDialog(BuildContext context) {
    return showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
            _responseMessage,
            textAlign: TextAlign.center,
          ),
          contentTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(10.0),
          backgroundColor: Colors.tealAccent,
          actions: <Widget>[
            RaisedButton(
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
              color: Colors.yellow[700],
              child: Text(
                'Ok',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.tealAccent[100],
                ),
              ),
            ),
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Number Shapes',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      backgroundColor: Colors.tealAccent[100],
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Please input a number to see if it is sqaure or triangular.',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    if (_isValidInput(_userInput)) {
                      _previousUserInput = _userInput;
                      _setResponseMessage(int.tryParse(_previousUserInput));
                      _userInput = null;
                      _controller.clear();
                      _createAlertDialog(context);
                    }
                  });
                },
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: Colors.yellow[700],
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super (key: key);

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

  String input = '';
  String suffix = '';
  String errorMessage;
  String newAmountOfMoney = '';

  RegExp decimalNumber = RegExp(r'^[0-9]+(.[0-9]+)?$');

  bool isValidInput(String input) {
    if (input == null || input.isEmpty) {
      return false;
    }

    if (input.length > 1 && input[0] == '0' && input[1] != '.') {
      return false;
    }

    if (input.length > 11) {
      return false;
    }

    // nu stiu de ce expresia regex accepta si caracterul , chiar daca eu am specificat cifre si .
    if (input.contains(',')) {
      return false;
    }

    return decimalNumber.hasMatch(input);
  }
  
  String createEroorMessage(String input) {
    if (input.length > 11 ) {
      return 'Field does not match criteria (maximum 10 digits)';
    } else if (input.isEmpty) {
      return 'Please insert the amount of money';
    } else if (!decimalNumber.hasMatch(input) || input.contains(',')) {
      return 'Please insert a valid number';
    } else if (input.length > 1 && input[0] == '0' && input[1] != '.') {
      return 'Please insert a valid number!';
    }

    return null;
  }

  void updateSuffixMessage(String input) {
    if (input.isEmpty) {
      suffix = '';
      newAmountOfMoney = '';
    } else {
      suffix = 'EUR';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Currecncy Converter',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber[600],
        ),
        body: Column(
          children: <Widget>[
            Image.network('https://www.nationsonline.org/gallery/World/currencies.jpg'),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter the amount in EUR',
                  errorText: errorMessage,
                  suffix: Text(suffix),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) {
                  setState(() {
                    input = value;
                    updateSuffixMessage(input);
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(100, 10, 100, 10),
              child: RaisedButton(
                color: Colors.amber[600],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    Text(
                      'Convert',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.double_arrow_outlined),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    errorMessage = createEroorMessage(input);
                    if (isValidInput(input)) {
                      newAmountOfMoney = (4.5 * double.parse(input)).toStringAsFixed(2) + ' RON';
                    } else {
                      newAmountOfMoney = '';
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                newAmountOfMoney,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 35.0,
                  fontFamily: 'TimesNewRoman',
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '0';
  String _currentInput = '';
  double _num1 = 0.0;
  double _num2 = 0.0;
  String _operand = '';

  void _handleClick(String buttonText) {
    if (buttonText == 'C') {
      _clear();
    } else if (buttonText == '+' ||
        buttonText == '-' ||
        buttonText == '*' ||
        buttonText == '/') {
      _handleOperator(buttonText);
    } else if (buttonText == '=') {
      _calculate();
    } else {
      _handleDigit(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = '0';
      _currentInput = '';
      _num1 = 0.0;
      _num2 = 0.0;
      _operand = '';
    });
  }

  void _handleOperator(String operator) {
    if (_currentInput.isNotEmpty) {
      setState(() {
        _num1 = double.parse(_currentInput);
        _currentInput = '';
        _operand = operator;
      });
    }
  }

  void _handleDigit(String digit) {
    setState(() {
      if (_currentInput == '0') {
        _currentInput = digit;
      } else {
        _currentInput += digit;
      }
    });
  }

  void _calculate() {
    if (_currentInput.isNotEmpty && _operand.isNotEmpty) {
      setState(() {
        _num2 = double.parse(_currentInput);
        switch (_operand) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case '*':
            _output = (_num1 * _num2).toString();
            break;
          case '/':
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = 'Error';
            }
            break;
          default:
            _output = 'Error';
        }
        _currentInput = '';
        _operand = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20.0),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('*'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String buttonText) {
    return ElevatedButton(
      onPressed: () => _handleClick(buttonText),
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 24.0),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[300],
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}

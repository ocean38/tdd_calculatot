import 'package:flutter/material.dart';
import 'string_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'String Calculator TDD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StringCalculatorPage(),
    );
  }
}

class StringCalculatorPage extends StatefulWidget {
  const StringCalculatorPage({super.key});

  @override
  State<StringCalculatorPage> createState() => _StringCalculatorPageState();
}

class _StringCalculatorPageState extends State<StringCalculatorPage> {
  final TextEditingController _controller = TextEditingController();
  final StringCalculator _calculator = StringCalculator();
  String _result = '';
  String _error = '';

  void _calculate() {
    setState(() {
      _error = '';
      try {
        int sum = _calculator.add(_controller.text);
        _result = 'Result: $sum';
      } catch (e) {
        _error = 'Error: ${e.toString()}';
        _result = '';
      }
    });
  }

  void _clear() {
    setState(() {
      _controller.clear();
      _result = '';
      _error = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('String Calculator TDD'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Enter numbers',
                hintText: 'e.g., "1,2,3" or "//;\\n1;2;3"',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _calculate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Calculate'),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _clear,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text('Clear'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_result.isNotEmpty)
              Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _result,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ),
            if (_error.isNotEmpty)
              Card(
                color: Colors.red.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _error,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

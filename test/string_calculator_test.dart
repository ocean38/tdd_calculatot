import 'package:demo/string_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late StringCalculator calculator;

  setUp(() {
    calculator = StringCalculator();
  });

  group('StringCalculator Tests', () {
    test('should return 0 for empty string', () {
      expect(calculator.add(''), equals(0));
    });

    test('should return the number itself for single number', () {
      expect(calculator.add('1'), equals(1));
      expect(calculator.add('5'), equals(5));
    });

    test('should return sum for two comma-separated numbers', () {
      expect(calculator.add('1,5'), equals(6));
      expect(calculator.add('2,3'), equals(5));
    });

    test('should handle multiple numbers', () {
      expect(calculator.add('1,2,3'), equals(6));
      expect(calculator.add('1,2,3,4,5'), equals(15));
      expect(calculator.add('10,20,30,40'), equals(100));
    });

    test('should handle newlines as delimiters', () {
      expect(calculator.add('1\n2,3'), equals(6));
      expect(calculator.add('1\n2\n3'), equals(6));
      expect(calculator.add('1,2\n3,4'), equals(10));
    });

    test('should support custom delimiters', () {
      expect(calculator.add('//;\n1;2'), equals(3));
      expect(calculator.add('//|\n1|2|3'), equals(6));
      expect(calculator.add('//*\n1*2*3*4'), equals(10));
    });

    test('should handle custom delimiter with newlines', () {
      expect(calculator.add('//;\n1;2\n3'), equals(6));
    });

    test('should throw exception for single negative number', () {
      expect(
        () => calculator.add('-1'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('negative numbers not allowed -1'),
        )),
      );
    });

    test('should throw exception for multiple negative numbers', () {
      expect(
        () => calculator.add('1,-2,3,-4'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('negative numbers not allowed -2,-4'),
        )),
      );
    });

    test('should throw exception for negative numbers with custom delimiter',
        () {
      expect(
        () => calculator.add('//;\n1;-2;3;-4'),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          contains('negative numbers not allowed -2,-4'),
        )),
      );
    });

    // Edge cases
    test('should handle empty segments gracefully', () {
      expect(calculator.add('1,,2'), equals(3));
      expect(calculator.add('1,\n,2'), equals(3));
    });

    test('should handle whitespace', () {
      expect(calculator.add(' 1 , 2 '), equals(3));
      expect(calculator.add('//;\n 1 ; 2 ; 3 '), equals(6));
    });
  });
}

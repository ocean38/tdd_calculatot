class StringCalculator {
  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    var split = ',';

    if (numbers.startsWith('//')) {
      int delimiterEnd = numbers.indexOf('\n');
      if (delimiterEnd != -1) {
        split = numbers.substring(2, delimiterEnd);
        numbers = numbers.substring(delimiterEnd + 1);
      }
    }

    numbers = numbers.replaceAll('\n', split);

    final nums = _parseNumbers(numbers, split);

    final negatives = nums.where((n) => n < 0).toList();

    if (negatives.isNotEmpty) {
      String negativesList = negatives.join(',');
      throw ArgumentError('negative numbers not allowed $negativesList');
    }

    return nums.fold(0, (sum, n) => sum + n);
  }

  List<int> _parseNumbers(String numbers, String split) {
    if (numbers.isEmpty) {
      return [];
    }

    return numbers
        .split(split)
        .where((s) => s.isNotEmpty)
        .map((s) => int.parse(s.trim()))
        .toList();
  }
}

class NumberConverterUtil {
  static String numberToWords(int number) {
    if (number == 0) {
      return 'Zero';
    }

    List<String> words = [];
    int index = 0;

    /// Loop for every three digit (1-999) and convert to words.
    /// The thousands (thousand, million, billion, etc) will be added based
    /// on the iteration. 
    ///  - First iteration (first 3 digit) mean the number doesn't reach 
    ///    thousand yet (only hundreds),
    ///  - Second iteration (next 3 digit) mean the number is thousand
    ///  - Third iteration (next 3 digit) mean the number is million
    ///  - and so forth until the digit is run out
    while (number > 0) {
      // Get last three digit from existing number
      var digits = number % 1000;

      // Convert the digits to words then add its thousands words.
      //
      // Put the word in the first index of the words list since the existing
      // number should be bigger than the previous processed number
      if (digits != 0) {
        words.insert(0, _recursiveConverter(digits) + thousands[index]);
      }

      // Remove last three digit of existing number
      number = (number / 1000).floor();

      // Add index to increment thousands
      index++;
    }

    return words.join().trim();
  }

  /// This function will recursively convert three digits of number (1-999) 
  /// to words
  /// - This function will run recursively until the input is <20.
  /// - The value is obtained from the number words list
  static String _recursiveConverter(int val) {
    late int index;

    if (val == 0) {
      return '';
    }

    if (val < 10) {
      index = val - 1;
      return '${ones[index]} ';
    }

    if (val < 20) {
      index = val - 10;
      return '${teens[index]} ';
    }

    if (val < 100) {
      index = (val / 10).floor() - 2;
      var separator = val % 10 == 0 ? ' ' : '-';
      return '${tens[index]}$separator${_recursiveConverter(val % 10)}';
    }

    index = (val / 100).floor();
    return '${hundreds[index]} ${_recursiveConverter(val % 100)}';
  }

  static List<String> ones = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five',
    'Six',
    'Seven',
    'Eight',
    'Nine',
  ];
  static List<String> teens = [
    'Ten',
    'Eleven',
    'Twelve',
    'Thirteen',
    'Fourteen',
    'Fifteen',
    'Sixteen',
    'Seventeen',
    'Eighteen',
    'Nineteen',
  ];
  static List<String> tens = [
    'Twenty',
    'Thirty',
    'Forty',
    'Fifty',
    'Sixty',
    'Seventy',
    'Eighty',
    'Ninety',
  ];
  static List<String> hundreds = [
    '',
    'One Hundred',
    'Two Hundred',
    'Three Hundred',
    'Four Hundred',
    'Five Hundred',
    'Six Hundred',
    'Seven Hundred',
    'Eight Hundred',
    'Nine Hundred',
  ];
  static List<String> thousands = [
    '',
    'Thousand ',
    'Million ',
    'Billion ',
    'Trillion ',
    'Quadrillion ',
  ];
}

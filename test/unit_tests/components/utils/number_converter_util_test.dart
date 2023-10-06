// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/utils/number_converter_util.dart';

void main() {
  test('test NumberToWord extension', () {
    var testCases = [
      1,
      10,
      100,
      1000,
      1000000,
      1000000000,
      1000000000000,
      1000000000000000,
      999999999999999,
      1234567891234567,
      5274573498573495,
    ];
    
    var expectedResults = [
      'one',
      'ten',
      'one hundred',
      'one thousand',
      'one million',
      'one billion',
      'one trillion',
      'one quadrillion',
      'nine hundred ninety-nine trillion nine hundred ninety-nine billion nine hundred ninety-nine million nine hundred ninety-nine thousand nine hundred ninety-nine',
      'one quadrillion two hundred thirty-four trillion five hundred sixty-seven billion eight hundred ninety-one million two hundred thirty-four thousand five hundred sixty-seven',
      'five quadrillion two hundred seventy-four trillion five hundred seventy-three billion four hundred ninety-eight million five hundred seventy-three thousand four hundred ninety-five',
    ];

    for (var i = 0; i < testCases.length; i++) {
      expect(
        NumberConverterUtil.numberToWords(testCases[i]).toLowerCase(),
        expectedResults[i],
      );
    }
  });
}

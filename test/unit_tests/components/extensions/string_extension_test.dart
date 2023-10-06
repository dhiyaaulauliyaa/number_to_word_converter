import 'package:flutter_test/flutter_test.dart';
import 'package:gluon_test/components/extensions/string_extension.dart';

void main() {
  test('test toSentenceCase', () {
    expect(
      'The Quick Brown Fox. Jumps Over The Lazy Dog.'.toSentenceCase,
      'The quick brown fox. Jumps over the lazy dog.',
    );
    expect(
      'THE QUICK BROWN FOX'.toSentenceCase,
      'The quick brown fox',
    );
    expect(
      'the quick brown fox'.toSentenceCase,
      'The quick brown fox',
    );
  });
}

extension StringX on String {
  String get toSentenceCase {
    if (isEmpty) {
      return this;
    }

    // Split text into sentences
    var sentences = split('.');

    // Convert each sentences into sentence case
    var converted = sentences.map((sentence) {
      var trimmed = sentence.trim();

      if (trimmed.isEmpty) return sentence;

      // Convert first char of first word into capital
      return trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();
    });

    // Join the sentences back together with period+space.
    var result = converted.join('. ');

    return result.trim();
  }
}

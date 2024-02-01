class Obfuscation {
  static String decodeString(String obfuscatedString) {
    // Split the obfuscated string into hexadecimal segments
    List<String> breakStringIntoTwoCharChunks(String input) {
      List<String> chunks = [];
      for (int i = 0; i < input.length; i += 2) {
        int end = i + 2;
        if (end > input.length) {
          end = input.length;
        }
        chunks.add(input.substring(i, end));
      }
      return chunks;
    }

    List<String> obfuscatedSegments =
        breakStringIntoTwoCharChunks(obfuscatedString);

    // Convert the hexadecimal segments back to Unicode code points
    List<int> unicodeCodePoints = obfuscatedSegments
        .map((segment) => int.parse(segment, radix: 16))
        .toList();

    // Convert Unicode code points to characters
    String decryptedString = String.fromCharCodes(unicodeCodePoints);

    return decryptedString;
  }
}

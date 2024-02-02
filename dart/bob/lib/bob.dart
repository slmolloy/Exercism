class Bob {
  String response(String input) => input.isBlank
      ? 'Fine. Be that way!'
      : input.isAllCaps
          ? input.isQuestion
              ? 'Calm down, I know what I\'m doing!'
              : 'Whoa, chill out!'
          : input.isQuestion
              ? 'Sure.'
              : 'Whatever.';
}

extension on String {
  bool get isBlank => trim().isEmpty;

  // Check if a capital letter is present and return when first lower case letter is found
  bool get isAllCaps {
    bool hasCapitalLetter = false;
    for (final char in runes) {
      if (!hasCapitalLetter) {
        if (char >= 65 && char <= 90) {
          hasCapitalLetter = true;
        }
      }
      if (char >= 97 && char <= 122) {
        return false;
      }
    }
    return hasCapitalLetter;
  }

  bool get isQuestion => trim().endsWith('?');
}

class WordCount {
  // Interseting solution I made to reduce reliance on regex.
  // Map<String, int> countWords(String input) {
  //   final counter = WordCounter(input);
  //   return counter.wordCount;
  // }

  // Solution using more complex regex but less code.
  Map<String, int> countWords(String s) {
    final regExp = RegExp(r"[a-z]+'[a-z]+|[a-z]+|[0-9]+");
    var words = <String, int>{};
    for (final m in regExp.allMatches(s.toLowerCase())) {
      words.update(m[0] ?? "", (value) => value + 1, ifAbsent: () => 1);
    }
    return words;
  }
}

class WordCounter {
  WordCounter(this.input) {
    for (int i = 0; i <= input.length; i++) {
      checkCharacter(i);
    }
  }

  String input;
  int? _wordStart;
  Map<String, int> words = {};

  Map<String, int> get wordCount => words;

  void checkCharacter(int index) {
    if (isWordCharacter(index)) {
      if (_wordStart == null) {
        _wordStart = index;
      }
    } else if (_wordStart != null) {
      final word = input.substring(_wordStart!, index).toLowerCase();
      words[word] = (words[word] ?? 0) + 1;
      _wordStart = null;
    }
  }

  bool isWordCharacter(int index) {
    if (index >= input.length) {
      return false;
    }

    if (RegExp(r"[A-Za-z0-9]").hasMatch(input[index])) {
      return true;
    } else if (RegExp(r"[']").hasMatch(input[index])) {
      if (_wordStart != null && isWordCharacter(index + 1)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

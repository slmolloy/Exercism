class Forth {
  final _stack = Stack<int>();
  List<int> get stack => _stack.list;
  Map<String, String> _userDefinedWords = {};

  void evaluate(String input) {
    input = input.toLowerCase();
    if (input.isUserDefinedWord) {
      _evaluateUserDefinedWord(input);
    } else {
      final words = input.split(' ');
      for (final word in words) {
        if (word.isNumber) {
          _stack.push(int.parse(word));
        } else if (_isUserDefinedWord(word)) {
          _executeUserDefinedWord(word);
        } else if (word.isArithmetic) {
          _executeAritmetic(word);
        } else if (word.isCommand) {
          _executeCommand(word);
        } else {
          throw Exception('Unknown command');
        }
      }
    }
  }

  bool _isUserDefinedWord(String word) => _userDefinedWords.containsKey(word);

  void _evaluateUserDefinedWord(String input) {
    final userDefined = input.split(' ');
    final command = userDefined[1];
    if (command.isNumber) {
      throw Exception('Invalid definition');
    }

    final expanded = userDefined.getRange(2, userDefined.length - 1).map((e) {
      if (_isUserDefinedWord(e)) {
        return _userDefinedWords[e]!;
      } else {
        return e;
      }
    }).join(' ');
    _userDefinedWords[command] = expanded;
  }

  void _executeUserDefinedWord(String word) {
    final definition = _userDefinedWords[word];
    if (definition == null) {
      throw Exception('Unknown command');
    }
    evaluate(definition);
  }

  void _executeAritmetic(String operation) {
    final b = _stack.pop();
    final a = _stack.pop();
    switch (operation) {
      case '+':
        _stack.push(a + b);
        break;
      case '-':
        _stack.push(a - b);
        break;
      case '*':
        _stack.push(a * b);
        break;
      case '/':
        if (b == 0) {
          throw Exception('Division by zero');
        }
        _stack.push(a ~/ b);
        break;
    }
  }

  void _executeCommand(String command) {
    switch (command) {
      case 'dup':
        final a = _stack.peek;
        _stack.push(a);
        break;
      case 'drop':
        _stack.pop();
        break;
      case 'swap':
        final b = _stack.pop();
        final a = _stack.pop();
        _stack.push(b);
        _stack.push(a);
        break;
      case 'over':
        final b = _stack.pop();
        final a = _stack.peek;
        _stack.push(b);
        _stack.push(a);
        break;
    }
  }
}

extension on String {
  bool get isNumber => int.tryParse(this) != null || this[0] == '-' && int.tryParse(substring(1)) != null;
  bool get isArithmetic => this == '+' || this == '-' || this == '*' || this == '/';
  bool get isCommand => this == 'dup' || this == 'drop' || this == 'swap' || this == 'over';
  bool get isUserDefinedWord => this.startsWith(': ') && this.endsWith(' ;');
}

class Stack<E> {
  final _list = <E>[];
  List<E> get list => _list;

  void push(E value) => _list.add(value);
  E pop() => _list.isEmpty ? throw Exception('Stack empty') : _list.removeLast();
  E get peek => _list.isEmpty ? throw Exception('Stack empty') : _list.last;
  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

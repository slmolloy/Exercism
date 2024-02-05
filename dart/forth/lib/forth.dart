class Forth {
  final _stack = Stack<int>();
  List<int> get stack => _stack.list;
  Map<String, String> _userDefinedWords = {};

  void evaluate(String input) {
    if (input.isUserDefinedWord) {
      final trimed = input.substring(2, input.length - 2); // remove ':' and ';'
      final commandEnd = trimed.indexOf(' ');
      final command = trimed.substring(0, commandEnd);
      final definition = trimed.substring(commandEnd + 1);
      print('command: "${command}", definition: "${definition}"');
      _userDefinedWords[command] = definition;
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
        }
      }
    }
  }

  bool _isUserDefinedWord(String word) => _userDefinedWords.containsKey(word);

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
  bool get isCommand =>
      this.toLowerCase() == 'dup' ||
      this.toLowerCase() == 'drop' ||
      this.toLowerCase() == 'swap' ||
      this.toLowerCase() == 'over';
  bool get isUserDefinedWord => this.startsWith(': ') && this.endsWith(' ;');
}

class Stack<E> {
  final _list = <E>[];
  List<E> get list => _list;

  void push(E value) => _list.add(value);

  E pop() {
    if (_list.isEmpty) {
      throw Exception('Stack empty');
    }
    return _list.removeLast();
  }

  E get peek {
    if (_list.isEmpty) {
      throw Exception('Stack empty');
    }
    return _list.last;
  }

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

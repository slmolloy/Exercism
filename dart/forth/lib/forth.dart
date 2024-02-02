class Forth {
  final _stack = Stack<int>();

  void evaluate(String input) {
    final words = input.split(' ');
    for (final word in words) {
      if (word.isNumber) {
        _stack.push(int.parse(word));
      } else if (word.isArithmetic) {
        final b = _stack.pop();
        final a = _stack.pop();
        switch (word) {
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
      } else {
        _execute(word);
      }
    }
  }

  void _execute(String command) {}

  List<int> get stack => _stack.list;
}

extension on String {
  bool get isNumber => int.tryParse(this) != null || this[0] == '-' && int.tryParse(substring(1)) != null;
  bool get isArithmetic => this == '+' || this == '-' || this == '*' || this == '/';
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

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

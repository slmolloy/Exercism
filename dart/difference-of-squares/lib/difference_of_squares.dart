import 'dart:math';

class DifferenceOfSquares {
  int squareOfSum(int n) => pow((n * (n + 1)) ~/ 2, 2).toInt();

  int sumOfSquares(int n) => (n * (n + 1) * (2 * n + 1)) ~/ 6;

  int differenceOfSquares(int n) => squareOfSum(n) - sumOfSquares(n);
}

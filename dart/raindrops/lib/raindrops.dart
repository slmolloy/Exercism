class Raindrops {
  String convert(int number) {
    var result = '';
    if (number % 3 == 0) result += 'Pling';
    if (number % 5 == 0) result += 'Plang';
    if (number % 7 == 0) result += 'Plong';
    return result.isEmpty ? number.toString() : result;
  }
}

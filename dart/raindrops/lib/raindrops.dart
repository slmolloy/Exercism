class Raindrops {
  Map<String, int> rainMap = {"Pling": 3, "Plang": 5, "Plong": 7};
  String convert(int number) {
    final result = rainMap.keys.where((key) => number % rainMap[key]! == 0).join();
    return result.isNotEmpty ? result : number.toString();
  }
}

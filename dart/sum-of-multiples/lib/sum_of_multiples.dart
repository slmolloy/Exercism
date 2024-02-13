class SumOfMultiples {
  int sum(List<int> multiples, int max) => multiples
      .where((m) => m <= max && m > 0)
      .map((m) => List.generate((max - 1) ~/ m, (e) => (e + 1) * m))
      .fold<Set<int>>(Set(), (s, e) => s..addAll(e))
      .fold(0, (a, b) => a + b);
}

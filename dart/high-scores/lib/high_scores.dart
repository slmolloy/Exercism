class HighScores {
  List<int> scores;

  HighScores(this.scores);

  int latest() => scores.last;

  int personalBest() => scores.fold(0, (max, cur) => cur > max ? cur : max);

  // Copy and sort would get expensive for large lists.
  List<int> personalTopThree() {
    final copy = List<int>.from(scores);
    copy.sort((a, b) => b.compareTo(a));
    return copy.take(3).toList();
  }
}

class Hamming {
  int distance(String strand1, String strand2) {
    if (strand1.length != strand2.length) {
      throw ArgumentError('strands must be of equal length');
    }
    return 0;
  }
}

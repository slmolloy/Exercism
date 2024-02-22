class Anagram {
  List<String> findAnagrams(String word, List<String> list) => list.where((e) => _isAnagram(word, e)).toList();

  bool _isAnagram(String w, String t) =>
      w.length == t.length && w.toLowerCase() != t.toLowerCase() && _sortString(w) == _sortString(t);

  String _sortString(String unsorted) => (unsorted.toLowerCase().split('')..sort()).join();
}

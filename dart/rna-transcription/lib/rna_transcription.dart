class RnaTranscription {
  static const dnaToRna = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U'};
  String toRna(String dna) => dna.split('').map((dna) => dnaToRna[dna]).join();
}

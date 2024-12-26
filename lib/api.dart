class WordDetails {
  final String word;
  final List<Map<String, dynamic>> phonetics;
  final List<Map<String, dynamic>> meanings;
  final Map<String, dynamic> license;
  final List<String> sourceUrls;

  WordDetails({
    required this.word,
    required this.phonetics,
    required this.meanings,
    required this.license,
    required this.sourceUrls,
  });

  factory WordDetails.fromJson(Map<String, dynamic> json) {
    return WordDetails(
      word: json['word'] ?? "",
      phonetics: List<Map<String, dynamic>>.from(json['phonetics'] ?? []),
      meanings: List<Map<String, dynamic>>.from(json['meanings'] ?? []),
      license: Map<String, dynamic>.from(json['license'] ?? {}),
      sourceUrls: List<String>.from(json['sourceUrls'] ?? []),
    );
  }
}

class Parser {
  static String parse(dynamic json, [String? key]) {
    final Map<String, dynamic> mapJson = json as Map<String, dynamic>;
    final dynamic value = mapJson[key] ?? '';
    if (value is String) {
      return value;
    } else if (value is bool) {
      return value.toString();
    } else {
      throw Exception('Unsupported type for key $key');
    }
  }
}

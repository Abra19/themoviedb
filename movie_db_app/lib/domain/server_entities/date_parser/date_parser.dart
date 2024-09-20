DateTime? parseDateFromString(String? rawDate) {
  if (rawDate == null || rawDate.isEmpty) {
    return null;
  }
  return DateTime.parse(rawDate);
}

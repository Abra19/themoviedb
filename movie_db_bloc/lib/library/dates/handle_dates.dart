import 'package:intl/intl.dart';

String stringFromDate(DateTime? date, DateFormat dateFormat) =>
    date != null ? dateFormat.format(date) : '';

String makeYearFromDate(DateTime? date) {
  return date != null ? ' (${date.year})' : '';
}

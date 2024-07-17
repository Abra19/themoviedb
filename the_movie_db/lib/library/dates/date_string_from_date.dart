import 'package:intl/intl.dart';

String dateStringFromDate(DateFormat dateFormat, DateTime? date) =>
    date != null ? dateFormat.format(date) : '';

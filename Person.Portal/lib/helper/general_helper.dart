import 'package:intl/intl.dart';

String ToDateFormat(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  } else {
    return '';
  }
}

String ToEuro(double? value) {
  if (value != null) {
    return NumberFormat.currency(locale: 'nl_NL', symbol: '€', decimalDigits: 2).format(value);
  } else {
    return '';
  }
}
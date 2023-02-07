import 'package:intl/intl.dart';

String ToDateFormat(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  } else {
    return '';
  }
}

String ToDateFormatNoDelimit(DateTime? dateTime) {
  if (dateTime != null) {
    return DateFormat("yyyyMMdd").format(dateTime);
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

String ToEuroDecimal(double? value) {
  if (value != null) {
    return NumberFormat('#,###,##0.00', 'nl_NL').format(value);
  } else {
    return '';
  }
}
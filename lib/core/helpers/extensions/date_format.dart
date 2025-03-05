import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String get formatted {
    final DateFormat formatter = DateFormat('yyyy-MM-dd, h:mm a', 'en');
    return formatter.format(this);
  }
}

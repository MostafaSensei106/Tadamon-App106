import 'package:intl/intl.dart';

extension DateFormatExtension on DateTime {
  String get formatted {
    final DateFormat formatter = DateFormat('dd-MM-yyyy h:mm a', 'ar');
    return formatter.format(this);
  }
}

import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final String formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
  // final String formattedTime = DateFormat('HH:mm').format(dateTime);
  return formattedDate;
}

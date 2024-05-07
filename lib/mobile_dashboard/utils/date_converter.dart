import 'package:intl/intl.dart';

class DateConverter {
  String getMonth(int currentMonthIndex) {
    return DateFormat('MMM').format(DateTime(0, currentMonthIndex)).toString();
  }

  String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }
}

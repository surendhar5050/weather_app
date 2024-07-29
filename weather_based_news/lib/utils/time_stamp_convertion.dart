import 'package:intl/intl.dart';

class TimeStampConvertion {
  static String convertTimestamp(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    DateFormat formatter = DateFormat('MMM d yyyy');
    String formattedDate = formatter.format(date);
    return formattedDate;
  }

  static String getShortDay(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateFormat formatter = DateFormat('EEE');
    String shortDay = formatter.format(date);

    return shortDay;
  }

  static String getTime(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

    DateFormat formatter = DateFormat('h:mm a');
    String shortDay = formatter.format(date);

    return shortDay;
  }

  static String getNewsdate(String dateFormatString) {
    DateTime dateTime = DateTime.parse(dateFormatString);

    DateFormat dateFormat = DateFormat('yyyy-MM-dd');

    String date = dateFormat.format(dateTime);
    return date;
  }

  static String getNewstime(String dateFormatString) {
    DateTime dateTime = DateTime.parse(dateFormatString);

    DateFormat timeFormat = DateFormat('HH:mm a');

    String date = timeFormat.format(dateTime);

    return date;
  }
}

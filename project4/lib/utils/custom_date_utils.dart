import 'package:intl/intl.dart';

class CustomDateUtils {
  CustomDateUtils._();

  static int getTsFromDateString(String date) {
    DateTime tempDate = DateFormat("dd/MM/yyy HH:mm:ss").parse(date);
    return tempDate.millisecond;
  }

  static String formatDateFromTs(int ts) {
    return DateFormat('HH:mm dd/MM/yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(ts));
  }
}
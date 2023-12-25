
import 'package:intl/intl.dart';

class DateUtil {
  /// get yyyy/MM/dd format date string
  static String getYMD(DateTime dateTime, {String format = 'yyyyMMdd'}) {
    return DateFormat(format).format(dateTime);
  }
}
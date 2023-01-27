import 'package:intl/intl.dart';

class TimeConverter {
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' day ago';
      } else {
        time = diff.inDays.toString() + ' day ago';
      }
    } else if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' week ago';
    } else {
      time = getDate(date);
    }

    return time;
  }

  String readSchDate(String sdate) {
    String year = sdate.substring(0, 4);
    String month = getMonth(sdate.substring(5, 7));
    String day = sdate.substring(8, 10);

    var date = DateTime.now();
    String adate = date.toString();

    String current_year = adate.substring(0, 4);
    String current_month = getMonth(adate.substring(5, 7));
    String current_day = adate.substring(8, 10);

    String date_lbl = '';
    if (int.parse(day) == int.parse(current_day) &&
        month == current_month &&
        year == current_year) {
      date_lbl = 'TODAY';
    } else if (int.parse(day) == int.parse(current_day) + 1 &&
        month == current_month &&
        year == current_year) {
      date_lbl = 'TOMORROW';
    } else if (int.parse(day) == int.parse(current_day) + 2 &&
        month == current_month &&
        year == current_year) {
      date_lbl = 'NEXT TOMORROW';
    } else if (int.parse(day) == int.parse(current_day) - 1 &&
        month == current_month &&
        year == current_year) {
      date_lbl = 'YESTERDAY';
    } else {
      date_lbl = day + " - " + month + " - " + year;
    }

    return date_lbl;
  }

  //Financial Reporting Council of Nigeria Meeting
  String getSchTime(String sdate) {
    //2022-07-02 08:55
    int hour = int.parse(sdate.substring(11, 13));
    int minute = int.parse(sdate.substring(14, 16));
    //print(sdate.substring(14, 16));
    //print(minute);
    int real_hour = 0;
    String ampm = 'am';
    if (hour > 12) {
      real_hour = hour - 12;
    } else {
      real_hour = hour;
    }
    if (hour >= 12) {
      ampm = 'pm';
    } else {
      ampm = 'am';
    }
    String real_minute =
        (minute.toString().length == 1) ? "0$minute" : minute.toString();
    return '$real_hour:$real_minute $ampm';
  }

  String getDate(date) {
    String adate = date.toString();
    String year = adate.substring(0, 4);
    String month = getMonth(adate.substring(5, 7));
    String day = adate.substring(8, 10);
    String getdate = month + ' ' + day + ', ' + year;
    return getdate;
  }

  List<int> getMin(String date) {
    //'2021-11-22 09:28:46.841595'

    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(5, 7));
    int day = int.parse(date.substring(8, 10));
    //2021, 8, 26
    return [year, month, day];
  }

  List<int> getMax(String date) {
    int year = int.parse(date.substring(0, 4));
    int month = int.parse(date.substring(5, 7));
    int days = getDays(date.substring(5, 7));
    int day = int.parse(date.substring(8, 10));
    if (day == days) {
      if (month == 12) {
        month = 1;
        year = year + 1;
        day = 1;
      } else {
        month = month + 1;
        day = 1;
      }
    } else {
      day = day + 1;
    }
    //2021, 8, 26
    return [year, month, day];
  }

  String getTime(DateTime date_from) {
    int hour = date_from.hour;
    int minute = date_from.minute;
    int real_hour = 0;
    String ampm = 'am';
    if (hour > 12) {
      real_hour = hour - 12;
    } else {
      real_hour = hour;
    }
    if (hour >= 12) {
      ampm = 'pm';
    } else {
      ampm = 'am';
    }
    String real_minute =
        (minute.toString().length == 1) ? "0$minute" : minute.toString();
    return '$real_hour:$real_minute $ampm';
  }

  String getMonthShort(String substring) {
    switch (substring) {
      case '01':
        return 'Jan';
        break;

      case '02':
        return 'Feb';
        break;

      case '03':
        return 'March';
        break;

      case '04':
        return 'April';
        break;

      case '05':
        return 'May';
        break;

      case '06':
        return 'Jun';
        break;

      case '07':
        return 'Jul';
        break;

      case '08':
        return 'Aug';
        break;

      case '09':
        return 'Sep';
        break;

      case '10':
        return 'Oct';
        break;

      case '11':
        return 'Nov';
        break;

      case '12':
        return 'Dec';
        break;
      default:
        return 'Jan';
        break;
    }
  }

  String getMonth(String substring) {
    switch (substring) {
      case '01':
        return 'January';
        break;

      case '02':
        return 'Febuary';
        break;

      case '03':
        return 'March';
        break;

      case '04':
        return 'April';
        break;

      case '05':
        return 'May';
        break;

      case '06':
        return 'June';
        break;

      case '07':
        return 'July';
        break;

      case '08':
        return 'August';
        break;

      case '09':
        return 'September';
        break;

      case '10':
        return 'October';
        break;

      case '11':
        return 'November';
        break;

      case '12':
        return 'December';
        break;
      default:
        return 'January';
        break;
    }
  }

  int getDays(String substring) {
    switch (substring) {
      case '01':
        return 31;
        break;

      case '02':
        return 28;
        break;

      case '03':
        return 31;
        break;

      case '04':
        return 30;
        break;

      case '05':
        return 31;
        break;

      case '06':
        return 30;
        break;

      case '07':
        return 31;
        break;

      case '08':
        return 31;
        break;

      case '09':
        return 30;
        break;

      case '10':
        return 31;
        break;

      case '11':
        return 30;
        break;

      case '12':
        return 31;
        break;
      default:
        return 31;
        break;
    }
  }
}

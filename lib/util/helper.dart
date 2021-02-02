import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'defaultText.dart';

enum ImageRatio { profile, banner }

class Helper {

  static String formatCurrencyIdr(String value) {
    try {
      final formatter = new NumberFormat("#,###");
      return "IDR ${formatter.format(int.parse(value))}";
    } catch (e) {
      return 'IDR 0';
    }
  }

  static String getMimeType(String path) {
    String extension = path.substring(path.lastIndexOf("/") + 1);
    return extension.toLowerCase();
  }

  static String formatDate(String date,
      {String format = 'dd MMMM yyyy'}) {
    String result = '';

    var now = DateTime.parse(date);
    var formatter = new DateFormat(format);
    result = formatter.format(now);

    return result;
  }

  static String formatMonth(String date) {
    print('date $date ');

    if (date == '01') {
      return 'Jan';
    }

    if (date == '02') {
      return 'Feb';
    }

    if (date == '03') {
      return 'Mar';
    }

    if (date == '04') {
      return 'Apr';
    }

    if (date == '05') {
      return 'May';
    }

    if (date == '06') {
      return 'Jun';
    }

    if (date == '07') {
      return 'Jul';
    }

    if (date == '08') {
      return 'Aug';
    }

    if (date == '09') {
      return 'Sep';
    }

    if (date == '10') {
      return 'Oct';
    }

    if (date == '11') {
      return 'Nov';
    }

    if (date == '12') {
      return 'Dec';
    }
  }

  static String formatDatetoandFrom(String dateStart, String dateEnd) {
    String result = '';
    // String datest = dateStart.replaceAll('/', '-');

    List resultstartlist = dateStart.split('/');
    List resultendlist = dateEnd.split('/');

    print('result date ${resultstartlist}');
    print('result date ${resultendlist}');

    String resultstart1 = formatMonth(resultstartlist[0]);
    print('result date ${resultstart1}');

    String resultstart = resultstartlist[1] + ' ' + resultstart1;
    String resultend1 = formatMonth(resultendlist[0]);
    String resultend = resultendlist[1] + ' ' + resultend1 + ' ' +
        resultendlist[2];

    result = resultstart + ' - ' + resultend;

    return result;
  }

  static DateTime formatToDateTime(String date) {
    var now = DateTime.parse(date);
    return now;
  }

  static String formatToDateTimetoString(DateTime date) {
    var formater = DateFormat('dd MMMM yyyy');
    var now = formater.format(date);
    return now;
  }

  static String formatToDateTimeString(DateTime date,
      {String format = 'yyyy-MM-dd'}) {
    var formater = DateFormat(format);
    var now = formater.format(date);
    return now;
  }

  static int formatToDateTimetoDateTime(DateTime date) {
    var formater = DateFormat(DateFormat.HOUR24).format(date);
    var dateint = int.parse(formater);
    return dateint;
  }

  static String formatTimeHr(DateTime date) {
    var formater = DateFormat(DateFormat.HOUR_MINUTE_SECOND).format(date);
    return formater;
  }
}
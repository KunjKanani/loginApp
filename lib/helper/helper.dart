import 'package:flutter/cupertino.dart';

emptyVerticalBox({double height = 20}) => SizedBox(height: height);
emptyHorizontalBox({double width = 20}) => SizedBox(width: width);

getStringFromDate(DateTime date) {
  return "${date.day} ${getMonthName(date.month)} ${date.year} ${date.hour}:${date.minute}";
}

String getMonthName(int month) {
  switch (month) {
    case 1:
      return "Jan";
    case 2:
      return "Feb";
    case 3:
      return "Mar";
    case 4:
      return "Apr";
    case 5:
      return "May";
    case 6:
      return "Jun";
    case 7:
      return "Jul";
    case 8:
      return "Aug";
    case 9:
      return "Sep";
    case 10:
      return "Oct";
    case 11:
      return "Nov";
    case 12:
      return "Dec";
    default:
      return "";
  }
}

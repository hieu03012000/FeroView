import 'package:intl/intl.dart';

String castGender(int gender) {
  String g;
  if (gender == 0)
    g = "Male";
  else if (gender == 1)
    g = "Female";
  else
    g = "Another";
  return g;
}

String castAge(String date) {
  DateTime dateTime = DateTime.parse(date);
  int age = DateTime.now().year - dateTime.year;
  return age.toString() + ' years old';
}

String formatDate(String date) {
  DateTime dt = DateTime.parse(date);
  var formatter = new DateFormat('EEEE, d MMM, yyyy');
  return formatter.format(dt);
}

String formatTime(String date) {
  DateTime dt = DateTime.parse(date);
  var formatter = new DateFormat('HH:mm');
  return formatter.format(dt);
}

DateTime parseDatetime(String date) {
  DateTime dt = DateTime.parse(date);
  return dt;
}

String formatCurrency(double salary) {
  final formatter = new NumberFormat.simpleCurrency(decimalDigits: 0);
  return formatter.format(salary);
}

String getCastingStatus(String openTime, String closeTime) {
  var d = new DateTime.now();
  return d.isBefore(DateTime.parse(openTime))
      ? 'Not Opened'
      : d.isAfter(DateTime.parse(closeTime))
          ? 'Closed'
          : 'Opening';
}

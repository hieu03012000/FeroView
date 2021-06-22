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
  var formatter = new DateFormat('dd-MM-yyyy');
  return formatter.format(dt);
}

// Validate if user is at least 10 years old
import 'package:intl/intl.dart';

String? validateDOB(String? dob) {
  if (dob == null || dob.isEmpty) return "Please enter your date of birth";

  DateTime parsedDOB = DateFormat('yyyy-MM-dd').parse(dob);
  int age = DateTime.now().year - parsedDOB.year;

  if (DateTime.now().month < parsedDOB.month ||
      (DateTime.now().month == parsedDOB.month && DateTime.now().day < parsedDOB.day)) {
    age--; // Adjust age if birthday hasn't occurred this year
  }
  if (age < 10) return "You must be at least 10 years old";
  return null; // Valid DOB
}


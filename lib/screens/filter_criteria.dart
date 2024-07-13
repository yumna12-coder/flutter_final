import 'package:flutter/material.dart';
import 'package:flutter_final/screens/course.dart';

class FilterCriteria {
  String city;
  String gender;
  int age;
  String level;

  FilterCriteria({
    required this.city,
    required this.gender,
    required this.age,
    required this.level,
  });

  bool matches(Course course) {
    return (city == 'Select City' || city == course.city) &&
        (gender == 'Select Gender' || gender == course.gender) &&
        (age == 0 || age == course.ageRange) &&
        (level == 'Select Level' || level == course.level);
  }
}

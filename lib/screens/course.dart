import 'package:flutter/material.dart';

class Course {
  final String name;
  final String imageUrl;
  final String city;
  final String gender;
  final RangeValues ageRange;
  final String level;
  bool isChecked;
    List<String> times; // New field for times


  Course({
    required this.name,
    required this.imageUrl,
    required this.city,
    required this.gender,
    required this.ageRange,
    required this.level,
    this.isChecked = false,
    this.times = const [], 
  });
}

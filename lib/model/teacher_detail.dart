import 'teacher_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class TeacherDetail {
  final List<TeacherPage> _list = [
    TeacherPage(
      name: "Ahmed",
      imagePath: "https://th.bing.com/th/id/OIP.HFRs-kqVIFRz12Gr5LPLHgHaHg?rs=1&pid=ImgDetMain,",
      price: 10,
      description: "Quran memorizer, worked 5 years in the Ministry of Endowment",
      category: Category.Tajweed,
      times: ["10:00 AM", "2:00 PM", "6:00 PM"],gender: Gender.male,email: "Ah21@gmail.com",phone: "078949838"
 // Add available times
    ),
    TeacherPage(
      name: "Mohamed",
      imagePath: "https://th.bing.com/th/id/OIP.HFRs-kqVIFRz12Gr5LPLHgHaHg?rs=1&pid=ImgDetMain",
      price: 12,
      description: "Expert in Tajweed, teaching for 8 years",
      category: Category.Tajweed,
      times: ["9:00 AM", "1:00 PM", "5:00 PM"],      gender: Gender.male,email: "Mohamed@gmail.com",phone: "078949838"
 // Add available times
    ),
    TeacherPage(
      name: "Hassan",
      imagePath: "https://th.bing.com/th/id/OIP.HFRs-kqVIFRz12Gr5LPLHgHaHg?rs=1&pid=ImgDetMain",
      price: 8,
      description: "Specialist in Quran memorization, with 10 years of experience",
      category: Category.memorizing,
      times: ["8:00 AM", "12:00 PM", "4:00 PM"],      gender: Gender.male,email: "Hassan@gmail.com",phone: "078949838"
 // Add available times
    ),
    TeacherPage(
      name: "Ali",
      imagePath: "https://th.bing.com/th/id/OIP.HFRs-kqVIFRz12Gr5LPLHgHaHg?rs=1&pid=ImgDetMain",
      price: 15,
      description: "Memorization expert, trained students worldwide",
      category: Category.memorizing,
      times: ["7:00 AM", "11:00 AM", "3:00 PM"],      gender: Gender.male,email: "Ali@gmail.com",phone: "078949838"
 // Add available times
    ),
    TeacherPage(
      name: "Omar",
      imagePath: "https://th.bing.com/th/id/OIP.HFRs-kqVIFRz12Gr5LPLHgHaHg?rs=1&pid=ImgDetMain",
      price: 20,
      description: "Experienced in both Tajweed and memorization",
      category: Category.memorizing,
      times: ["6:00 AM", "10:00 AM", "2:00 PM"],      gender: Gender.male,email: "Omar@gmail.com",phone: "078949838"
 // Add available times
    ),
  ];

  List<TeacherPage> get list => _list;

  List<TeacherPage> getByCategory(Category category) {
    return _list.where((teacher) => teacher.category == category).toList();
  }
}

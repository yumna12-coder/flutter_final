enum Category { memorizing, Tajweed }
enum Gender { male, female }

class TeacherPage {
  final String name;
  final String imagePath;
  final double price;
  final String description;
  final Category category;
  final List<String> times;
  final Gender gender;
  final String email;
  final String phone;

  TeacherPage({
    required this.name,
    required this.imagePath,
    required this.price,
    required this.description,
    required this.category,
    required this.times,
    required this.gender,
    required this.email,
    required this.phone,
  });
}
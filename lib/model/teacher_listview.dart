import 'package:flutter/material.dart';
import 'package:flutter_final/model/teacher_enroll.dart';
import 'package:flutter_final/model/teacher_page.dart';

class TeacherListView extends StatelessWidget {
  final List<TeacherPage> teachers;

  const TeacherListView({Key? key, required this.teachers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: teachers.length,
      itemBuilder: (context, index) {
        final teacher = teachers[index];
        return ListTile(
          leading: Image.network(teacher.imagePath),
          title: Text(teacher.name),
          subtitle: Text('Price: \$${teacher.price}'),
          trailing: ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.green,
            ),
            onPressed: () {
              _showContactDialog(context, teacher.email, teacher.phone);
            },
            child: Text('Contact'),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherDetailPage(teacher: teacher),
              ),
            );
          },
        );
      },
    );
  }

  void _showContactDialog(BuildContext context, String? email, String? phone) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Contact Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (email != null) Text('Email: $email'),
              SizedBox(height: 10),
              if (phone != null) Text('Phone: $phone'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

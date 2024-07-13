// teacher_detail_page.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'teacher_page.dart';

class TeacherDetailPage extends StatefulWidget {
  final TeacherPage teacher;

  const TeacherDetailPage({super.key, required this.teacher});

  @override
  _TeacherDetailPageState createState() => _TeacherDetailPageState();
}

class _TeacherDetailPageState extends State<TeacherDetailPage> {
  String? selectedTime;
  String? enrollmentId;

  Future<String?> addEnrollment(String email, String teacherName, String? selectedTime) async {
    if (selectedTime == null) {
      // Handle case where no time is selected
      return null;
    }
    DocumentReference docRef = await FirebaseFirestore.instance.collection('enrollments').add({
      'email': email,
      'teacherName': teacherName,
      'selectedTime': selectedTime,
      'enrolledAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  Future<void> cancelEnrollment(String? enrollmentId) async {
    if (enrollmentId != null) {
      await FirebaseFirestore.instance.collection('enrollments').doc(enrollmentId).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String email = user?.email ?? 'unknown@example.com';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.teacher.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container( 
                child:Image.network(widget.teacher.imagePath,scale:3,),
                
                ),
            ),
           
            SizedBox(height: 20),
            Text(
              widget.teacher.description,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Price: \$${widget.teacher.price}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Category: ${widget.teacher.category.toString().split('.').last}',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20),
            Divider(
              color: Colors.black87,
            ),
            SizedBox(height: 10),
            Text('Times Available:'),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 95, 90, 90),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.teacher.times.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(
                      widget.teacher.times[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: widget.teacher.times[index],
                    groupValue: selectedTime,
                    onChanged: (String? value) {
                      setState(() {
                        selectedTime = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String? id = await addEnrollment(email, widget.teacher.name, selectedTime);
                      if (id != null) {
                        setState(() {
                          enrollmentId = id;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Enrollment Successful'),
                              content: Text('You have enrolled in ${widget.teacher.name} at $selectedTime.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Enroll Now',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  if (enrollmentId != null)
                    ElevatedButton(
                      onPressed: () async {
                        await cancelEnrollment(enrollmentId);
                        setState(() {
                          enrollmentId = null;
                          selectedTime = null;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Enrollment Cancelled'),
                              content: Text('You have cancelled your enrollment with ${widget.teacher.name}.'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Cancel Enrollment',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).shadowColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

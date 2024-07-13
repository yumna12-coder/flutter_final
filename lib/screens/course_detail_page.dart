import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'course.dart';

class CourseDetailPage extends StatefulWidget {
  final Course course;

  CourseDetailPage({required this.course});

  @override
  _CourseDetailPageState createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends State<CourseDetailPage> {
  String? selectedTime;
  String? enrollmentId;

  Future<String?> addEnrollment(String email, String courseName, String? selectedTime) async {
    if (selectedTime == null) {
      // Handle case where no time is selected
      return null;
    }
    DocumentReference docRef = await FirebaseFirestore.instance.collection('enrollments').add({
      'email': email,
      'courseName': courseName,
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
        title: Text('Course Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.course.imageUrl),
            SizedBox(height: 20),
            Text(
              'Course Name: ${widget.course.name},',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
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
                itemCount: widget.course.times.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(
                      widget.course.times[index],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    value: widget.course.times[index],
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
                      String? id = await addEnrollment(email, widget.course.name, selectedTime);
                      if (id != null) {
                        setState(() {
                          enrollmentId = id;
                        });
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Enrollment Successful'),
                              content: Text('You have enrolled in ${widget.course.name} at $selectedTime.'),
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
                              content: Text('You have cancelled your enrollment in ${widget.course.name}.'),
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

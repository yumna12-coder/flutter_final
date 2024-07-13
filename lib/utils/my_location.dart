import 'package:flutter/material.dart';
import 'package:flutter_final/screens/private_course.dart';

class MyLocation extends StatelessWidget {
  const MyLocation({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 100,right: 200 ),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Perform some action
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PrivateCoursePage(),
                  ),
                );
              },
              child: Text('private learning '),
            )
          ],
        ),
      ),
    );
  }
}

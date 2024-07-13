import 'package:flutter/material.dart';
import 'package:flutter_final/screens/course.dart';
import 'package:flutter_final/screens/filter_criteria.dart';
import 'package:flutter_final/utils/my_drawer.dart';
import 'package:flutter_final/utils/my_location.dart';
import 'package:flutter_final/utils/filter.dart';
import 'package:flutter_final/utils/my_silver_app_bar.dart';
import 'course_detail_page.dart'; // Import the CourseDetailPage

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Course> allCourses = [
    Course(name: 'Sufian-althawri', times: ['Wensd 7:30', ' Fr 9:30', ' Fr 12:30'],imageUrl: 'https://worldview.stratfor.com/sites/default/files/styles/2x1_full/public/islam.jpg?itok=u2HABl_p', city: 'Amman', gender: 'Male', ageRange:  RangeValues(8, 18), level: 'Beginner'),
    Course(name: 'Al-huda', times: ['Su 8:00', ' Su 10:00', 'Su 3:00'],imageUrl: 'https://worldview.stratfor.com/sites/default/files/styles/2x1_full/public/islam.jpg?itok=u2HABl_p', city: 'Irbid', gender: 'Female', ageRange:  RangeValues(10, 25), level: 'Intermediate'),
    // Add more cour Course(name: 'Course 1', imageUrl: 'https://via.placeholder.com/150', city: 'Amman', gender: 'Male', age: 20, level: 'Beginner'),
    Course(name: 'Just_project',times: [' Fr 12:00', ' Fr 3:00', 'Th 5:00'], imageUrl: 'https://worldview.stratfor.com/sites/default/files/styles/2x1_full/public/islam.jpg?itok=u2HABl_p', city: 'Irbid', gender: 'Female', ageRange:  RangeValues(18, 25), level: 'Intermediate'),

  ];

  List<Course> filteredCourses = [];

  @override
  void initState() {
    super.initState();
    filteredCourses = allCourses;
  }

  void onFilterChanged(FilterCriteria criteria) {
    setState(() {
      filteredCourses = allCourses.where((course) => criteria.matches(course)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            pinned: true,
            floating: true,
            expandedHeight: 200.0,

            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Choose a course'),
              background: Column(
                children: [
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Color.fromARGB(159, 228, 224, 224),
                  ),
                  MyLocation(),
                  
                ],
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                FilterExample(onFilterChanged: onFilterChanged),
                SizedBox(height: 16), // Add some spacing
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredCourses.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                  ),
                  itemBuilder: (context, index) {
                    final course = filteredCourses[index];

                    return GestureDetector(
                      
                         onTap: () =>Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CourseDetailPage(course: course),
      ),
    ),

                 child:    Card(child: Container(
                        color: Colors.green,
                      child: Column(
                        children: [
                          Image.network(course.imageUrl),
                          Text(course.name),
                        ],
                      ),
                    )));
                  },

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
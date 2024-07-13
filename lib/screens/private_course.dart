import 'package:flutter/material.dart';
import 'package:flutter_final/model/teacher_detail.dart';
import 'package:flutter_final/model/teacher_listview.dart';
import 'package:flutter_final/model/teacher_page.dart';
import 'package:flutter_final/screens/recording_page.dart';
import 'package:flutter_final/utils/my_silver_app_bar.dart';
import 'my_tab_bar.dart';

class PrivateCoursePage extends StatefulWidget {
  const PrivateCoursePage({super.key});

  @override
  State<PrivateCoursePage> createState() => _PrivateCoursePageState();
}

class _PrivateCoursePageState extends State<PrivateCoursePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TeacherDetail teacherDetail = TeacherDetail();

  double _selectedMaxPrice = 50.0;
  Gender? _selectedGender;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<TeacherPage> _applyFilters(List<TeacherPage> teachers) {
    return teachers.where((teacher) {
      bool matchesPrice = teacher.price <= _selectedMaxPrice;
      bool matchesGender = _selectedGender == null || teacher.gender == _selectedGender;
      return matchesPrice && matchesGender;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySilverAppBar(
            title: MyTabBar(tabController: _tabController),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, top: 100),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green, // Text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context)=>RecordingVideosPage()));
                      // Perform some action
                    },
                    child: Text('Your recording private lessons'),
                  ),
                ),
                Divider(
                  indent: 10,
                  endIndent: 10,
                  color: Color.fromARGB(159, 228, 224, 224),
                ),
                // Filter Widgets
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Max Price: \$${_selectedMaxPrice.toInt()}'),
                      Expanded(
                        child: Slider(
                          value: _selectedMaxPrice,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label: _selectedMaxPrice.round().toString(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMaxPrice = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Gender: '),
                      DropdownButton<Gender?>(
                        value: _selectedGender,
                        items: [
                          DropdownMenuItem(
                            child: Text('All'),
                            value: null,
                          ),
                          DropdownMenuItem(
                            child: Text('Male'),
                            value: Gender.male,
                          ),
                          DropdownMenuItem(
                            child: Text('Female'),
                            value: Gender.female,
                          ),
                        ],
                        onChanged: (Gender? value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TeacherListView(teachers: _applyFilters(teacherDetail.getByCategory(Category.memorizing))),
                  TeacherListView(teachers: _applyFilters(teacherDetail.getByCategory(Category.Tajweed))),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 20),
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
                      // Perform some actioNn
                    },
                    child: Text('Private Learning'),
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

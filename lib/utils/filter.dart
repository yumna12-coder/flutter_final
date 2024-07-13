import 'package:flutter/material.dart';
import 'package:flutter_final/screens/filter_criteria.dart';



class FilterExample extends StatefulWidget {
  final Function(FilterCriteria) onFilterChanged;

  FilterExample({required this.onFilterChanged});

  @override
  _FilterExampleState createState() => _FilterExampleState();
}

class _FilterExampleState extends State<FilterExample> {
  String selectedCity = 'Select City';
  String selectedGender = 'Select Gender';
  int selectedAge = 0;
  String selectedLevel = 'Select Level';

  List<String> cities = ['Select City', 'New Zarqa', 'Amman', 'Irbid'];
  List<String> genders = ['Select Gender', 'Male', 'Female'];
  List<String> levels = ['Select Level', 'Beginner', 'Intermediate', 'Advanced'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('City:'),
          DropdownButton<String>(
            value: selectedCity,
            onChanged: (value) {
              setState(() {
                selectedCity = value!;
              });
            },
            items: cities.map((city) {
              return DropdownMenuItem<String>(
                value: city,
                child: Text(city),
              );
            }).toList(),
          ),
          Text('Gender:'),
          DropdownButton<String>(
            value: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value!;
              });
            },
            items: genders.map((gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
          ),
          Text('Age:'),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter age'),
            onChanged: (value) {
              setState(() {
                selectedAge = int.tryParse(value) ?? 0;
              });
            },
          ),
          Text('Level:'),
          DropdownButton<String>(
            value: selectedLevel,
            onChanged: (value) {
              setState(() {
                selectedLevel = value!;
              });
            },
            items: levels.map((level) {
              return DropdownMenuItem<String>(
                value: level,
                child: Text(level),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              applyFilters();
            },
            child: Text('Apply Filters'),
          ),
        ],
      ),
    );
  }

  void applyFilters() {
    FilterCriteria criteria = FilterCriteria(
      city: selectedCity,
      gender: selectedGender,
      age: selectedAge,
      level: selectedLevel,
    );

    widget.onFilterChanged(criteria);
  }
}

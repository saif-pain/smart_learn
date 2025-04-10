import 'package:flutter/material.dart';
import 'package:smart_learn/core/app_colors.dart';
import 'package:smart_learn/screens/semester_results_page.dart';

class AcademicResultsPage extends StatefulWidget {
  const AcademicResultsPage({Key? key}) : super(key: key);

  @override
  State<AcademicResultsPage> createState() => _AcademicResultsPageState();
}

class _AcademicResultsPageState extends State<AcademicResultsPage> {
  final _formKey = GlobalKey<FormState>();
  final _studentIdController = TextEditingController();
  String? _selectedSemester;

  final List<Map<String, dynamic>> _semesters = [
    {'name': 'Spring 2024', 'value': 'spring2024'},
    {'name': 'Summer 2024', 'value': 'summer2024'},
    {'name': 'Fall 2024', 'value': 'fall2024'},
    {'name': 'Spring 2025', 'value': 'spring2025'},
  ];

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }

  void _viewResults() {
    if (_formKey.currentState!.validate() && _selectedSemester != null) {
      // Here we would typically make an API call to fetch the results
      // For now, we'll just navigate to a results page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SemesterResultsPage(
            studentId: _studentIdController.text,
            semester: _selectedSemester!,
            semesterName: _semesters
                .firstWhere((element) => element['value'] == _selectedSemester)['name'],
          ),
        ),
      );
    } else if (_selectedSemester == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a semester'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Academic Results',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Check Your Results',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your student ID and select a semester to view your academic results.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              _buildResultsForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultsForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student ID TextField
          const Text(
            'Student ID',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _studentIdController,
            decoration: InputDecoration(
              hintText: 'Enter your student ID',
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.blue),
              ),
              prefixIcon: const Icon(
                Icons.person,
                color: Colors.blue,
              ),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your student ID';
              }
              return null;
            },
          ),
          
          const SizedBox(height: 24),
          
          // Semester Dropdown
          const Text(
            'Semester',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButtonFormField<String>(
                value: _selectedSemester,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.blue,
                  ),
                ),
                hint: const Text('Select semester'),
                isExpanded: true,
                items: _semesters.map((semester) {
                  return DropdownMenuItem<String>(
                    value: semester['value'],
                    child: Text(semester['name']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSemester = value;
                  });
                },
              ),
            ),
          ),
          
          const SizedBox(height: 40),
          
          // View Results Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _viewResults,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Results',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class SemesterResultsPage extends StatelessWidget {
  final String studentId;
  final String semester;
  final String semesterName;

  const SemesterResultsPage({
    Key? key,
    required this.studentId,
    required this.semester,
    required this.semesterName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // This would typically come from an API based on the studentId and semester
    final courses = _getMockCoursesData(semester);

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
          'Semester Results',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildResultHeader(),
              const SizedBox(height: 24),
              _buildResultsTable(courses),
              const SizedBox(height: 24),
              _buildSemesterSummary(courses),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultHeader() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: Colors.blue, size: 24),
                const SizedBox(width: 8),
                Text(
                  semesterName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              children: [
                const Text(
                  'Student ID: ',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  studentId,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsTable(List<Map<String, dynamic>> courses) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Course Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 20,
                headingRowColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) => Colors.grey[200]!,
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Course Code',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Course Title',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Credit',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Grade',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Grade Point',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
                rows: courses.map((course) {
                  return DataRow(
                    cells: [
                      DataCell(Text(course['code'])),
                      DataCell(Text(course['title'])),
                      DataCell(Text(course['credit'].toString())),
                      DataCell(
                        Text(
                          course['grade'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getGradeColor(course['grade']),
                          ),
                        ),
                      ),
                      DataCell(Text(course['gradePoint'].toString())),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSemesterSummary(List<Map<String, dynamic>> courses) {
    double totalCredits = 0;
    double totalPoints = 0;

    for (var course in courses) {
      totalCredits += course['credit'] as double;
      totalPoints += (course['credit'] as double) * (course['gradePoint'] as double);
    }

    final gpa = totalPoints / totalCredits;

    return Card(
      elevation: 4,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Semester Summary',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Credits:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  totalCredits.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Semester GPA:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  gpa.toStringAsFixed(2),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _getGpaColor(gpa),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A':
      case 'A-':
        return Colors.green;
      case 'B+':
      case 'B':
      case 'B-':
        return Colors.blue;
      case 'C+':
      case 'C':
        return Colors.orange;
      case 'D':
        return Colors.red[300]!;
      case 'F':
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  Color _getGpaColor(double gpa) {
    if (gpa >= 3.7) {
      return Colors.green;
    } else if (gpa >= 3.0) {
      return Colors.blue;
    } else if (gpa >= 2.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  List<Map<String, dynamic>> _getMockCoursesData(String semester) {
    // Different mock data based on the semester
    switch (semester) {
      case 'spring2024':
        return [
          {
            'code': 'CSE221',
            'title': 'Algorithms',
            'credit': 3.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
          {
            'code': 'CSE255',
            'title': 'Database Systems',
            'credit': 3.0,
            'grade': 'A-',
            'gradePoint': 3.7,
          },
          {
            'code': 'MAT211',
            'title': 'Linear Algebra',
            'credit': 3.0,
            'grade': 'B+',
            'gradePoint': 3.3,
          },
          {
            'code': 'CSE250',
            'title': 'Project Work I',
            'credit': 2.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
        ];
      case 'summer2024':
        return [
          {
            'code': 'CSE311',
            'title': 'Computer Architecture',
            'credit': 3.0,
            'grade': 'B+',
            'gradePoint': 3.3,
          },
          {
            'code': 'CSE331',
            'title': 'Compiler Design',
            'credit': 3.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
          {
            'code': 'CSE351',
            'title': 'Computer Networks',
            'credit': 3.0,
            'grade': 'B',
            'gradePoint': 3.0,
          },
        ];
      case 'fall2024':
        return [
          {
            'code': 'CSE411',
            'title': 'Software Engineering',
            'credit': 3.0,
            'grade': 'A-',
            'gradePoint': 3.7,
          },
          {
            'code': 'CSE431',
            'title': 'Web Programming',
            'credit': 3.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
          {
            'code': 'CSE451',
            'title': 'Mobile App Development',
            'credit': 3.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
          {
            'code': 'CSE450',
            'title': 'Project Work II',
            'credit': 2.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
        ];
      case 'spring2025':
        return [
          {
            'code': 'CSE499',
            'title': 'Capstone Project',
            'credit': 4.0,
            'grade': 'A',
            'gradePoint': 4.0,
          },
          {
            'code': 'CSE460',
            'title': 'Machine Learning',
            'credit': 3.0,
            'grade': 'A-',
            'gradePoint': 3.7,
          },
          {
            'code': 'CSE470',
            'title': 'Cloud Computing',
            'credit': 3.0,
            'grade': 'B+',
            'gradePoint': 3.3,
          },
        ];
      default:
        return [];
    }
  }
}
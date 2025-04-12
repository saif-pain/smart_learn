import 'package:flutter/material.dart';
import 'package:smart_learn/models/semester_result_model.dart';
import 'package:smart_learn/models/course_result_model.dart';
import 'package:smart_learn/models/student_model.dart';

class SemesterResultsPage extends StatelessWidget {
  final SemesterResult semesterResult;
  final Student? studentInfo;

  const SemesterResultsPage({
    Key? key,
    required this.semesterResult,
    this.studentInfo,
  }) : super(key: key);

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
              _buildStudentProfile(),
              const SizedBox(height: 24),
              _buildResultsTable(),
              const SizedBox(height: 24),
              _buildSemesterSummary(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentProfile() {
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
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 24,
                  child: Text(
                    studentInfo != null ? studentInfo!.studentName.substring(0, 1) : 'S',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        studentInfo != null ? studentInfo!.studentName : 'Student Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ID: ${semesterResult.studentId}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            if (studentInfo != null) ...[
              _buildInfoRow(Icons.school, 'Program', studentInfo!.programName),
              _buildInfoRow(Icons.business, 'Department', studentInfo!.departmentName),
              _buildInfoRow(Icons.people, 'Batch', 'Batch ${studentInfo!.batchNo}'),
              _buildInfoRow(Icons.location_on, 'Campus', studentInfo!.campusName),
            ],
            _buildInfoRow(
              Icons.calendar_today, 
              'Semester', 
              semesterResult.getFormattedSemesterName()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blue),
          const SizedBox(width: 12),
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTable() {
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
                rows: semesterResult.courses.map((course) {
                  return DataRow(
                    cells: [
                      DataCell(Text(course.customCourseId)),
                      DataCell(Text(course.courseTitle)),
                      DataCell(Text(course.totalCredit.toString())),
                      DataCell(
                        Text(
                          course.gradeLetter,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _getGradeColor(course.gradeLetter),
                          ),
                        ),
                      ),
                      DataCell(Text(course.pointEquivalent.toString())),
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

  Widget _buildSemesterSummary() {
    // Use provided CGPA if available, otherwise calculate from courses
    final gpa = semesterResult.cgpa ?? semesterResult.calculateGPA();
    final totalCredits = semesterResult.calculateTotalCredits();

    return Card(
      elevation: 4,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.summarize,
                  color: Colors.blue,
                  size: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Semester Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSummaryRow('Total Credits:', totalCredits.toString()),
            _buildSummaryRow(
              'Semester GPA:',
              gpa.toStringAsFixed(2),
              valueColor: _getGpaColor(gpa),
              valueFontSize: 18,
            ),
            const SizedBox(height: 8),
            _buildGpaStatusMessage(gpa),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {Color? valueColor, double? valueFontSize}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: valueFontSize ?? 16,
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGpaStatusMessage(double gpa) {
    String message;
    Color color;

    if (gpa >= 3.7) {
      message = 'Excellent performance!';
      color = Colors.green;
    } else if (gpa >= 3.0) {
      message = 'Good performance.';
      color = Colors.blue;
    } else if (gpa >= 2.0) {
      message = 'Satisfactory performance.';
      color = Colors.orange;
    } else {
      message = 'Needs improvement.';
      color = Colors.red;
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(
            gpa >= 3.0 ? Icons.check_circle : Icons.info,
            color: color,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            message,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
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
      case 'D+':
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
}
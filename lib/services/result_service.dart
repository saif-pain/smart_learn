import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_learn/models/semester_result_model.dart';
import 'package:smart_learn/models/course_result_model.dart';
import 'package:smart_learn/models/student_model.dart';

class ResultService {
  // Base URL for the DIU API
  final String diuApiUrl = 'http://software.diu.edu.bd:8006';

  // Fetch student information by student ID
  Future<Student> fetchStudentInfo(String studentId) async {
    try {
      final response = await http.get(
        Uri.parse('$diuApiUrl/result/studentInfo?studentId=$studentId'),
      );

      if (response.statusCode == 200) {
        return Student.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load student info: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load student info: $e');
    }
  }

  // Fetch semester results for a student
  Future<SemesterResult> fetchSemesterResults(String studentId, String semesterId) async {
    try {
      final response = await http.get(
        Uri.parse('$diuApiUrl/result?semesterId=$semesterId&studentId=$studentId'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> resultData = jsonDecode(response.body);
        return SemesterResult.fromApiResponse(resultData);
      } else {
        throw Exception('Failed to load results: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load results: $e');
    }
  }

  // Fetch available semesters for a student (we'll mock this for now)
  Future<List<Map<String, dynamic>>> fetchAvailableSemesters() async {
    // In a real implementation, this would call an API to get the student's available semesters
    // For now, we'll return a mock list
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network delay
    
    return [
      {'id': '243', 'name': 'Fall 2024'},
      {'id': '242', 'name': 'Summer 2024'},
      {'id': '241', 'name': 'Spring 2024'},
      {'id': '233', 'name': 'Fall 2023'},
      {'id': '232', 'name': 'Summer 2023'},
      {'id': '231', 'name': 'Spring 2023'},
      {'id': '223', 'name': 'Fall 2022'},
      {'id': '222', 'name': 'Summer 2022'},
      {'id': '221', 'name': 'Spring 2022'},
    ];
  }
}